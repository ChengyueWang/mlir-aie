# Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
# SPDX-License-Identifier: MIT

from copy import copy, deepcopy
import json
import os
from typing import Tuple
import warnings
try:
    from IPython.display import display
except ImportError:
    display = None
try:
    from . import svg
    from . import svg_config as config
except ImportError:
    # Handle direct execution
    import svg
    import svg_config as config

_ct_color = {
    0: {'kernel': config.dark_pink,
        'inbuf': [config.light_pink, config.light_red],
        'outbuf': [config.dark_pink, config.lilac]},
    1: {'kernel': config.yellow,
        'inbuf': [config.orange, config.purple],
        'outbuf': [config.yellow, config.orange]},
    2: {'kernel': config.dark_blue,
        'inbuf': [config.light_blue, config.lilac],
        'outbuf': [config.dark_blue, config.pink]},
    3: {'kernel': config.red,
        'inbuf': [config.light_red, config.magenta],
        'outbuf': [config.red, config.light_orange]}
}

_it2mt_color = [config.green, config.artichoke]
_mt2it_color = [config.purple, config.orchid]


class AppViz:
    """ Visualize the Dataflow Graph in a column of the NPU"""
    def __init__(self, metadata: str):
        self._kanimate_duration = 4
        # Parse metadata first to get the correct format
        self._md = self._parse_metadata(metadata)
        
        # Store original metadata for text report generation
        if hasattr(self, '_original_md'):
            # Already set in _parse_metadata
            pass
        else:
            # Fallback
            if isinstance(metadata, dict):
                self._original_md = metadata
            elif os.path.isfile(metadata):
                with open(metadata, "r") as fp:
                    self._original_md = json.load(fp)
            else:
                try:
                    self._original_md = json.loads(metadata)
                except:
                    self._original_md = {}
        
        self._loc_conv = {2: 3, 3: 2, 4: 1, 5: 0}
        self._appname = self._md['application']
        
        # Determine the number of columns and create column mapping for sparse layouts
        max_col = 0
        min_col = float('inf')
        used_cols = set()
        for k in self._md['kernels'].values():
            if 'tloc' in k and len(k['tloc']) > 0:
                col = k['tloc'][0]
                max_col = max(max_col, col)
                min_col = min(min_col, col)
                used_cols.add(col)
        
        # Create column mapping for sparse layouts
        self._col_mapping = {col: i for i, col in enumerate(sorted(used_cols))}
        cols = len(used_cols)  # Use actual number of used columns
        
        # Determine the number of rows and create row mapping for sparse layouts
        max_row = 0
        min_row = float('inf')
        compute_tile_rows = set()
        all_tile_rows = set()
        used_rows = set()
        for k in self._md['kernels'].values():
            if 'tloc' in k and len(k['tloc']) > 1:
                row = k['tloc'][1]
                max_row = max(max_row, row)
                min_row = min(min_row, row)
                all_tile_rows.add(row)
                used_rows.add(row)
                # Track compute tile rows specifically
                if k['type'] == 'CT':
                    compute_tile_rows.add(row)
        
        # Create row mapping for compute tiles only (for proper array indexing)
        compute_rows_sorted = sorted(compute_tile_rows, reverse=True)
        self._compute_row_mapping = {row: i for i, row in enumerate(compute_rows_sorted)}
        
        # For NPU architecture, we need to account for the complete tile structure:
        # - Interface tiles at row 0 
        # - Memory tiles at row 1
        # - Compute tiles at row 2+
        # The visualization should include all rows that contain any tiles
        if compute_tile_rows:
            # If we have compute tiles, count how many distinct compute rows we have
            rows = len(compute_tile_rows)
        else:
            # If no compute tiles, we still need a minimal structure for interface/memory tiles
            # Set rows to 0 to indicate no compute tiles should be created
            rows = 0
        
        # Always use RyzenAiArray - it can handle single column designs too
        # RyzenAiArray is more flexible and has better support for no-compute-tile scenarios
        self._col_svg = svg.RyzenAiArray(rows=rows, cols=cols, remove_if_tile=False)
            
        self._ct_color = deepcopy(_ct_color)
        self._drawn_kernels = self._draw_kernels()
        
        # Track which interconnect paths are used
        self._used_interconnect_tiles = set()
        # Track which external memory connections are used
        self._used_external_mem_connections = set()
        # Track specific connection directions for each tile
        self._used_tile_directions = {}  # {tile_id: {directions}}
        
        self._ct2mt_counter = 0
        self._mt2ct_counter = 0
        self._it2ct_counter = 0
        self._ct2it_counter = 0
        self._it2mt_counter = 0
        self._mt2it_counter = 0
        self._mt2ct_pt = {}
        self._dbuf_colors = {}
        self._ct2mt_dict = {}
        self._draw_connections_sorted()
        
        # Add detailed annotations to tiles BEFORE making unused tiles transparent
        self._add_detailed_annotations()
        
        # Make unused tiles transparent AFTER connections are drawn and annotations added
        self.make_unused_tiles_transparent(opacity=0.8)
        
        # Make unused interconnect paths transparent
        self.make_unused_interconnect_transparent(opacity=0.7)

    def _track_tile_direction(self, tile_id, direction):
        """Track that a specific direction is used for a tile"""
        if tile_id not in self._used_tile_directions:
            self._used_tile_directions[tile_id] = set()
        self._used_tile_directions[tile_id].add(direction)
        self._draw_key()

    def _draw_key(self) -> None:
        kernels = []
        for kname, k in self._drawn_kernels.items():
            # Only add kernels that have colors (CT tiles)
            if 'kcolor' in k:
                p = tuple([kname, k['kcolor']])
                kernels.append(p)
        
        # Only generate key if the method exists (RyzenAiColumn has it, RyzenAiArray doesn't)
        if hasattr(self._col_svg, 'generate_key'):
            self._col_svg.generate_key(kernels)

    def _draw_kernels(self) -> dict:
        """ Draws the kernels onto the appropriate tiles
            Returns a dict containing a reference to all
            the drawn kernels that can be used for
            appending buffers and connections to the
            kernels"""
        drawn_kernels = {}
        for k in self._md['kernels'].values():
            info = {}
            
            if k['type'] == "CT":
                # For compute tiles, use their actual row position
                # In NPU architecture: compute tiles are typically at row 2 and above
                info['row'] = k['tloc'][1]  # Use actual row from MLIR
                info['col'] = k['tloc'][0]  # Keep original column
                info['kcolor'] = self._ct_color[info['row'] % len(self._ct_color)]['kernel']  # Use row-based colors
                
                tile_index = self._get_tile_index(info['row'], info['col'])
                self._col_svg.aie_tiles[tile_index].add_kernel(
                        info['kcolor'],
                        self._kanimate_duration)
            elif k['type'] == "MT":
                # Memory tiles: use their actual positions  
                info['row'] = k['tloc'][1]
                info['col'] = k['tloc'][0]
                # Memory tiles don't get kernels added, they're handled separately
            elif k['type'] == "IT":
                # Interface tiles: use their actual positions
                info['row'] = k['tloc'][1] 
                info['col'] = k['tloc'][0]
                # Interface tiles don't get kernels added, they're handled separately
                
            drawn_kernels[k['name']] = info

        return drawn_kernels

    def _get_mapped_col_index(self, col):
        """Get the mapped column index for sparse layouts"""
        return self._col_mapping.get(col, 0) if hasattr(self, '_col_mapping') else col

    def _get_tile_index(self, row, col=0):
        """Get the correct tile index for either RyzenAiColumn or RyzenAiArray"""
        if hasattr(self._col_svg, 'cols') and hasattr(self._col_svg, 'rows'):
            # RyzenAiArray uses row * cols + col indexing
            # Use mappings to handle sparse layouts
            
            # Map the actual column to array column index
            mapped_col = self._get_mapped_col_index(col)
            
            # For compute tiles, map the actual row to array row index
            if row in self._compute_row_mapping:
                mapped_row = self._compute_row_mapping[row]
                return mapped_row * self._col_svg.cols + mapped_col
            else:
                # For non-compute tiles (interface/memory), use row directly if in valid range
                # This handles interface tiles (row 0) and memory tiles (row 1)
                return mapped_col  # For now, just use column mapping for non-compute tiles
        else:
            # RyzenAiColumn uses just row indexing
            return row

    def _get_output_buffer(self, kernelidx: int):
        color = None
        if self._ct_color[kernelidx]['outbuf']:
            color = self._ct_color[kernelidx]['outbuf'][0]
            self._ct_color[kernelidx]['outbuf'].remove(color)
        if color is None:
            warnings.warn("Cannot display more than two output buffers for "
                          f"compute tile {kernelidx}")
        return color

    def _get_input_buffer(self, kernelidx: int):
        color = None
        if self._ct_color[kernelidx]['inbuf']:
            color = self._ct_color[kernelidx]['inbuf'][0]
            self._ct_color[kernelidx]['inbuf'].remove(color)
        if color is None:
            warnings.warn("Cannot display more than two input buffers for "
                          f"compute tile {kernelidx}")
        return color

    def _is_rtp_con(self, connection: dict) -> bool:
        """ determines if a connection is an RTP from the json """
        # For new format, check if source tile is 'user' (RTP connections)
        source_tile = connection.get('source', {}).get('tile', '')
        return source_tile == 'user'

    def _draw_connections_sorted(self) -> None:
        """Draw connections with a pre-defined priority"""

        conn = copy(self._md['connections'])
        tmpconn = copy(self._md['connections'])

        # Draw cascade connections first (highest priority)
        for k, c in conn.items():
            if c.get('type') == 'cascade':
                self._draw_connection(c)
                tmpconn.pop(k)
        conn = copy(tmpconn)

        # Draw animations starting in the IT first
        for k, c in conn.items():
            if not self._is_rtp_con(c):
                if c['srcport'] == 'ITout':
                    self._draw_connection(c)
                    tmpconn.pop(k)
            else:
                tmpconn.pop(k)
        conn = copy(tmpconn)

        # Draw animations starting in the MT second. Run twice for ping-pong
        for i in range(2):
            for k, c in conn.items():
                if c['srcport'] == 'MTout' and c['sinkport'] != 'ITin':
                    self._draw_connection(c, bool(i))
                    if i == 1:
                        tmpconn.pop(k)
            self._mt2ct_counter = 0
        conn = copy(tmpconn)

        # Draw animations ending in the MT third. Run twice for ping-pong
        for i in range(2):
            for k, c in conn.items():
                if c['sinkport'] == 'MTin':
                    self._draw_connection(c, bool(i))
                    if i == 1:
                        tmpconn.pop(k)
            self._ct2mt_counter = 0
        conn = copy(tmpconn)

        # Draw remaining animations
        for c in conn.values():
            self._draw_connection(c)

    def _draw_connection(self, c, dbuf: bool = False) -> None:
        """ Draws kernels, buffers and data movement

        Iterates through the connections, drawing the kernel, buffers and
        data movement.
        """
        # Extract source and destination information from new format
        source_info = c.get('source', {})
        dest_info = c.get('destination', {})
        
        source_tile = source_info.get('tile', '')
        dest_tile = dest_info.get('tile', '')
        source_port = source_info.get('port', '')
        dest_port = dest_info.get('port', '')
        
        # Skip if we don't have valid tile information
        if not source_tile or not dest_tile:
            return
            
        # Get tile information from kernels/tiles metadata
        src = self._md['kernels'].get(source_tile)
        dst = self._md['kernels'].get(dest_tile)
        
        # Skip if tiles not found in kernels metadata
        if not src or not dst:
            return

        if src['type'] == 'CT' and dst['type'] == 'CT':
            src_row = self._drawn_kernels[src['name']]['row']
            src_col = self._drawn_kernels[src['name']]['col']
            dst_row = self._drawn_kernels[dst['name']]['row']
            dst_col = self._drawn_kernels[dst['name']]['col']
            
            src_tile_index = self._get_tile_index(src_row, src_col)
            dst_tile_index = self._get_tile_index(dst_row, dst_col)
            
            # Check if this is a cascade connection
            if c.get('type') == 'cascade':
                self._draw_cascade_connection(src, dst, c)
            else:
                for i in range(2):
                    self._col_svg.aie_tiles[src_tile_index].add_buffer(
                                self._drawn_kernels[src['name']]['kcolor'],
                                self._kanimate_duration/2,
                                start_empty=not bool(i))
                    # if CTs are non neighbors we need to add double buffer in dst
                    if not self._are_neighbors(src, dst):
                        self._col_svg.aie_tiles[dst_tile_index].add_buffer(
                                self._drawn_kernels[src['name']]['kcolor'],
                                self._kanimate_duration/2,
                                start_empty=bool(i))

                self._draw_ct2ct_data_movement(src, dst)

        if src['type'] == 'IT' and dst['type'] == 'CT':
            dst_row = self._drawn_kernels[dst['name']]['row']
            dst_col = self._drawn_kernels[dst['name']]['col']
            dst_tile_index = self._get_tile_index(dst_row, dst_col)
            # Use mapped row index for color lookup
            mapped_dst_row = self._compute_row_mapping.get(dst_row, dst_row)
            bufcol = self._get_input_buffer(mapped_dst_row)
            for i in range(2):
                self._col_svg.aie_tiles[dst_tile_index].add_buffer(
                            bufcol,
                            self._kanimate_duration/2,
                            start_empty=bool(i))
            self._draw_ub_ic_ingress(dst, bufcol)
            self._it2ct_counter += 1

        if src['type'] == 'CT' and dst['type'] == 'IT':
            src_row = self._drawn_kernels[src['name']]['row']
            src_col = self._drawn_kernels[src['name']]['col']
            src_tile_index = self._get_tile_index(src_row, src_col)
            # Use mapped row index for color lookup
            mapped_src_row = self._compute_row_mapping.get(src_row, src_row)
            bufcol = self._get_output_buffer(mapped_src_row)
            for i in range(2):
                self._col_svg.aie_tiles[src_tile_index].add_buffer(
                            bufcol,
                            self._kanimate_duration/2,
                            start_empty=not bool(i))
            self._draw_ub_ic_egress(src, bufcol)
            self._ct2it_counter += 1

        if src['type'] == 'CT' and dst['type'] == 'MT':
            src_row = self._drawn_kernels[src['name']]['row']
            if not dbuf:
                # Use mapped row index for color lookup
                mapped_src_row = self._compute_row_mapping.get(src_row, src_row)
                bufcol = self._get_output_buffer(mapped_src_row)
                self._dbuf_colors[c['name']] = bufcol
            else:
                bufcol = self._dbuf_colors[c['name']]

            if (key := c['sinkkernel']) not in self._ct2mt_dict.keys():
                self._ct2mt_dict[key] = {'idx': len(self._ct2mt_dict)}

            dst_it_color = _mt2it_color[self._ct2mt_dict[key]['idx']]

            self._col_svg.mem_tiles[0].add_buffer(
                        bufcol,
                        self._kanimate_duration/2,
                        start_empty=not dbuf,
                        color2=dst_it_color,
                        delay=self._ct2mt_counter/5)
            if not dbuf:
                src_row = self._drawn_kernels[src['name']]['row']
                src_col = self._drawn_kernels[src['name']]['col']
                src_tile_index = self._get_tile_index(src_row, src_col)
                for i in range(2):
                    self._col_svg.aie_tiles[src_tile_index].add_buffer(
                                bufcol,
                                self._kanimate_duration/2,
                                start_empty=bool(i))

                self._draw_ct2mem_ic(src, bufcol)
            else:
                self._ct2mt_counter += 1

        if src['type'] == 'MT' and dst['type'] == 'CT':
            dst_row = self._drawn_kernels[dst['name']]['row']
            if not dbuf:
                # Use mapped row index for color lookup
                mapped_dst_row = self._compute_row_mapping.get(dst_row, dst_row)
                dst_buf_color = self._get_input_buffer(mapped_dst_row)
                self._dbuf_colors[c['name']] = dst_buf_color
            else:
                dst_buf_color = self._dbuf_colors[c['name']]

            show_mem_buffer = True
            mtmode = src.get('mtmode')
            if mtmode == 'passthrough':
                if not self._mt2ct_pt.get(src['name']):
                    self._mt2ct_pt[src['name']] = {'color': dst_buf_color}
                elif self._mt2ct_pt[src['name']]:
                    dst_buf_color = self._mt2ct_pt[src['name']]['color']
                    show_mem_buffer = False

            # Extract index from source tile name for color selection
            # Try to get a numeric index from the source tile, default to 0
            try:
                # Extract numbers from tile name, e.g., "(0, 1)" -> use column number
                if ',' in source_tile:
                    # Format like "(0, 1)" - extract column number
                    col_part = source_tile.split(',')[1].strip().rstrip(')')
                    idx = int(col_part) % 2
                else:
                    # Fallback: try to extract last digit from tile name
                    digits = ''.join(filter(str.isdigit, source_tile))
                    idx = int(digits[-1]) % 2 if digits else 0
            except (ValueError, IndexError):
                idx = 0
            
            src_color = _it2mt_color[idx]

            if show_mem_buffer:
                for i in range(int(bool(self._mt2ct_pt)) + 1):
                    self._col_svg.mem_tiles[0].add_buffer(
                                src_color,
                                self._kanimate_duration/2,
                                start_empty=not (dbuf ^ bool(i)),
                                color2=dst_buf_color,
                                delay=self._mt2ct_counter/5)
            dst_row = self._drawn_kernels[dst['name']]['row']
            dst_col = self._drawn_kernels[dst['name']]['col']
            dst_tile_index = self._get_tile_index(dst_row, dst_col)
            self._col_svg.aie_tiles[dst_tile_index].add_buffer(
                        dst_buf_color,
                        self._kanimate_duration/2,
                        start_empty=dbuf)
            if not dbuf:
                self._draw_mem2ct_ic(dst, dst_buf_color, mtmode)
            else:
                self._mt2ct_counter += 1

        self._draw_ub2mem_ic(src, dst)
        self._draw_mem2ub_ic(src, dst)

    def _draw_ct2mem_ic(self, src, src_color) -> None:
        """Display animation originating from CT and destination MT"""

        src_row = self._drawn_kernels[src['name']]['row']  # Use mapped row position
        src_col = self._drawn_kernels[src['name']]['col']  # Use mapped column position
        delay = self._ct2mt_counter / 5

        # Track that this interconnect path is used
        tile_index = self._get_tile_index(src_row, src_col)
        self._used_interconnect_tiles.add(tile_index)
        # Track specific directions used
        self._track_tile_direction(tile_index, 'diagonal_from')
        self._track_tile_direction(tile_index, 'south')
        # Also track memory tile
        mem_tile_index = self._get_mapped_col_index(src_col) if hasattr(self._col_svg, 'cols') else 0
        self._used_interconnect_tiles.add(f"mem_{mem_tile_index}")
        self._track_tile_direction(f"mem_{mem_tile_index}", 'diagonal_to')

        # Draw animation from compute tile (src_row) to memory (row 1)
        # Only animate from the source row, no intermediate rows needed
        tile_index = self._get_tile_index(src_row, src_col)
        self._col_svg.aie_tiles[tile_index].add_ic_animation(
                diagonal_from_tile=True,
                south=1,
                duration=self._kanimate_duration/2,
                delay=delay,
                color=src_color)

        self._col_svg.mem_tiles[0].add_ic_animation(
                    diagonal_to_tile=1,
                    duration=self._kanimate_duration/2,
                    delay=delay,
                    color=src_color)
        self._ct2mt_counter += 1

    def _draw_mem2ct_ic(self, dst, dst_color, mtmode=None) -> None:
        """Display animation originating from MT and destination CT"""

        dst_row = self._drawn_kernels[dst['name']]['row']  # Use mapped row position
        dst_col = self._drawn_kernels[dst['name']]['col']  # Use mapped column position
        delay = self._mt2ct_counter / 5

        # Track that this interconnect path is used
        tile_index = self._get_tile_index(dst_row, dst_col)
        self._used_interconnect_tiles.add(tile_index)
        # Track specific directions used
        self._track_tile_direction(tile_index, 'diagonal_to')
        self._track_tile_direction(tile_index, 'north')
        # Also track memory tile
        mem_tile_index = self._get_mapped_col_index(dst_col) if hasattr(self._col_svg, 'cols') else 0
        self._used_interconnect_tiles.add(f"mem_{mem_tile_index}")
        self._track_tile_direction(f"mem_{mem_tile_index}", 'diagonal_from')

        # For memory tiles, we need to find the correct memory tile index
        mem_tile_index = self._get_mapped_col_index(dst_col) if hasattr(self._col_svg, 'cols') else 0
        self._col_svg.mem_tiles[mem_tile_index].add_ic_animation(
                    diagonal_from_tile=1,
                    duration=self._kanimate_duration/2,
                    delay=delay,
                    color=dst_color)

        # Draw animation from memory (row 1) to compute tile (dst_row)
        # Only animate to the destination row, no intermediate rows needed
        tile_index = self._get_tile_index(dst_row, dst_col)
        self._col_svg.aie_tiles[tile_index].add_ic_animation(
                diagonal_to_tile=True,
                north=1,
                duration=self._kanimate_duration/2,
                delay=delay,
                color=dst_color)
        self._mt2ct_counter += int(mtmode == 'split')

    def _draw_ub2mem_ic(self, src, dst) -> None:
        """Display animation originating from IT and destination MT"""

        if src['type'] == 'IT' and dst['type'] == 'MT':
            if self._it2mt_counter > 1:
                warnings.warn("Cannot display more than two input buffers "
                              "from the interface tile to the memory tile")
                return
            src_color = _it2mt_color[self._it2mt_counter]
            
            # Get the correct column indices
            dst_col = dst['tloc'][0] if 'tloc' in dst else 0
            src_col = src['tloc'][0] if 'tloc' in src else 0
            
            # Track that this interconnect path is used
            if_tile_index = self._get_mapped_col_index(src_col) if hasattr(self._col_svg, 'cols') else 0
            mem_tile_index = self._get_mapped_col_index(dst_col) if hasattr(self._col_svg, 'cols') else 0
            self._used_interconnect_tiles.add(f"if_{if_tile_index}")
            self._used_interconnect_tiles.add(f"mem_{mem_tile_index}")
            # Track specific directions used
            self._track_tile_direction(f"if_{if_tile_index}", 'diagonal_from')
            self._track_tile_direction(f"if_{if_tile_index}", 'south_up')
            self._track_tile_direction(f"mem_{mem_tile_index}", 'diagonal_to')
            self._track_tile_direction(f"mem_{mem_tile_index}", 'north')
            # Track external memory connection usage
            self._used_external_mem_connections.add(if_tile_index)
            
            # Use correct tile indices
            mem_tile_index = self._get_mapped_col_index(dst_col) if hasattr(self._col_svg, 'cols') else 0
            if_tile_index = self._get_mapped_col_index(src_col) if hasattr(self._col_svg, 'cols') else 0
            
            self._col_svg.mem_tiles[mem_tile_index].add_ic_animation(
                        diagonal_to_tile=1,
                        north=1,
                        duration=self._kanimate_duration/2,
                        color=src_color,
                        delay=self._it2mt_counter/5)
            self._col_svg.if_tiles[if_tile_index].add_dma_animation(
                        south_up=1,
                        duration=self._kanimate_duration/2,
                        color=src_color,
                        delay=self._it2mt_counter/5)
            self._col_svg.if_tiles[if_tile_index].add_ic_animation(
                        diagonal_from_tile=1,
                        duration=self._kanimate_duration/2,
                        color=src_color,
                        delay=self._it2mt_counter/5)
            self._it2mt_counter += 1

    def _draw_mem2ub_ic(self, src, dst) -> None:
        """Display animation originating from MT and destination IT"""

        if src['type'] == 'MT' and dst['type'] == 'IT':
            if self._mt2it_counter > 1:
                warnings.warn("Cannot display more than two output buffers "
                              "from the memory tile to the interface tile")
                return
            dst_color = _mt2it_color[self._mt2it_counter]
            
            # Get the correct column indices
            src_col = src['tloc'][0] if 'tloc' in src else 0
            dst_col = dst['tloc'][0] if 'tloc' in dst else 0
            
            # Track that this interconnect path is used
            mem_tile_index = self._get_mapped_col_index(src_col) if hasattr(self._col_svg, 'cols') else 0
            if_tile_index = self._get_mapped_col_index(dst_col) if hasattr(self._col_svg, 'cols') else 0
            self._used_interconnect_tiles.add(f"mem_{mem_tile_index}")
            self._used_interconnect_tiles.add(f"if_{if_tile_index}")
            # Track specific directions used
            self._track_tile_direction(f"mem_{mem_tile_index}", 'diagonal_from')
            self._track_tile_direction(f"mem_{mem_tile_index}", 'south')
            self._track_tile_direction(f"if_{if_tile_index}", 'diagonal_to')
            self._track_tile_direction(f"if_{if_tile_index}", 'south_down')
            # Track external memory connection usage
            self._used_external_mem_connections.add(if_tile_index)
            
            # Use correct tile indices
            mem_tile_index = self._get_mapped_col_index(src_col) if hasattr(self._col_svg, 'cols') else 0
            if_tile_index = self._get_mapped_col_index(dst_col) if hasattr(self._col_svg, 'cols') else 0
            
            self._col_svg.mem_tiles[mem_tile_index].add_ic_animation(
                        diagonal_from_tile=1,
                        south=1,
                        duration=self._kanimate_duration/2,
                        color=dst_color,
                        delay=self._mt2it_counter/5)
            self._col_svg.if_tiles[if_tile_index].add_ic_animation(
                        diagonal_to_tile=1,
                        duration=self._kanimate_duration/2,
                        color=dst_color,
                        delay=self._mt2it_counter/5)
            self._col_svg.if_tiles[if_tile_index].add_dma_animation(
                        south_down=1,
                        duration=self._kanimate_duration/2,
                        color=dst_color,
                        delay=self._mt2it_counter/5)
            self._mt2it_counter += 1

    def _draw_ub_ic_egress(self, src, src_color) -> None:
        """Display animation originating from CT and destination IT"""

        src_row = self._drawn_kernels[src['name']]['row']  # Use mapped row position
        src_col = self._drawn_kernels[src['name']]['col']  # Use mapped column position

        # Draw animation from source compute tile
        tile_index = self._get_tile_index(src_row, src_col)
        self._col_svg.aie_tiles[tile_index].add_ic_animation(
                diagonal_from_tile=True,
                south=1,
                duration=self._kanimate_duration/2,
                    color=src_color,
                    delay=self._ct2it_counter/5)

        # Use correct memory tile and interface tile indices
        mem_tile_index = self._col_mapping.get(src_col, 0) if hasattr(self._col_svg, 'cols') else 0
        if_tile_index = self._col_mapping.get(src_col, 0) if hasattr(self._col_svg, 'cols') else 0
        
        self._col_svg.mem_tiles[mem_tile_index].add_ic_animation(
                    south=1,
                    duration=self._kanimate_duration/2,
                    color=src_color,
                    delay=self._ct2it_counter/5)

        self._col_svg.if_tiles[if_tile_index].add_ic_animation(
                    diagonal_to_tile=1,
                    duration=self._kanimate_duration/2,
                    color=src_color,
                    delay=self._ct2it_counter/5)

        self._col_svg.if_tiles[if_tile_index].add_dma_animation(
                    south_down=1,
                    duration=self._kanimate_duration/2,
                    color=src_color,
                    delay=self._ct2it_counter/5)

    def _draw_ub_ic_ingress(self, dst, kcolor) -> None:
        """Display animation originating from IT and destination CT"""

        dst_col = self._drawn_kernels[dst['name']]['col']  # Use mapped column position
        
        # Use correct interface tile and memory tile indices
        if_tile_index = self._col_mapping.get(dst_col, 0) if hasattr(self._col_svg, 'cols') else 0
        mem_tile_index = self._col_mapping.get(dst_col, 0) if hasattr(self._col_svg, 'cols') else 0
        
        self._col_svg.if_tiles[if_tile_index].add_ic_animation(
                    diagonal_from_tile=1,
                    duration=self._kanimate_duration/2,
                    color=kcolor,
                    delay=self._it2ct_counter/5)
        self._col_svg.if_tiles[if_tile_index].add_dma_animation(
                    south_up=1,
                    duration=self._kanimate_duration/2,
                    color=kcolor,
                    delay=self._it2ct_counter/5)

        self._col_svg.mem_tiles[mem_tile_index].add_ic_animation(
                    north=1,
                    duration=self._kanimate_duration/2,
                    color=kcolor,
                    delay=self._it2ct_counter/5)

        dst_row = self._drawn_kernels[dst['name']]['row']  # Use mapped row position
        # Draw animation to destination compute tile
        tile_index = self._get_tile_index(dst_row, dst_col)
        self._col_svg.aie_tiles[tile_index].add_ic_animation(
                diagonal_to_tile=True,
                north=1,
                duration=self._kanimate_duration/2,
                color=kcolor,
                delay=self._it2ct_counter/5)

    def _draw_cascade_connection(self, src, dst, connection) -> None:
        """Display cascade connection between two compute tiles"""
        src_row = self._drawn_kernels[src['name']]['row']
        src_col = self._drawn_kernels[src['name']]['col']
        dst_row = self._drawn_kernels[dst['name']]['row']
        dst_col = self._drawn_kernels[dst['name']]['col']
        
        src_tile_index = self._get_tile_index(src_row, src_col)
        dst_tile_index = self._get_tile_index(dst_row, dst_col)
        
        # Use a distinctive color for cascade connections (purple/magenta)
        cascade_color = config.green
        
        # Add cascade buffers on both tiles
        for i in range(2):
            # Source tile cascade out buffer
            self._col_svg.aie_tiles[src_tile_index].add_buffer(
                        cascade_color,
                        self._kanimate_duration/2,
                        start_empty=not bool(i))
            # Destination tile cascade in buffer  
            self._col_svg.aie_tiles[dst_tile_index].add_buffer(
                        cascade_color,
                        self._kanimate_duration/2,
                        start_empty=bool(i))
        
        # Draw cascade animation - unidirectional from source to destination
        # Instead of NoC paths, draw direct line between kernel areas
        if src_col < dst_col:
            # East cascade (tile_0_2 to tile_1_2) - draw horizontal line between kernels
            self._draw_direct_cascade_line(src_tile_index, dst_tile_index, 'east', cascade_color)
        elif src_col > dst_col:
            # West cascade - draw horizontal line between kernels
            self._draw_direct_cascade_line(src_tile_index, dst_tile_index, 'west', cascade_color)
        elif src_row < dst_row:
            # South cascade - draw vertical line between kernels
            self._draw_direct_cascade_line(src_tile_index, dst_tile_index, 'south', cascade_color)
        elif src_row > dst_row:
            # North cascade - draw vertical line between kernels
            self._draw_direct_cascade_line(src_tile_index, dst_tile_index, 'north', cascade_color)
        
        # Track cascade connections differently - they don't use NoC interconnect
        # Only the source tile might still need NoC tracking if it has other stream connections
        # The destination tile (tile_1_2) should NOT be tracked as using NoC interconnect
        # since cascade is a direct kernel-to-kernel connection, not a streaming NoC connection

    def _draw_direct_cascade_line(self, src_tile_index, dst_tile_index, direction, color):
        """Draw a direct line between kernel areas for cascade connection"""
        src_tile = self._col_svg.aie_tiles[src_tile_index]
        dst_tile = self._col_svg.aie_tiles[dst_tile_index]
        
        # Calculate kernel center positions
        # Kernel is located at: tile.x + aie_container_offset_x + aie_box_offset_x (relative) + aie_box_width/2
        src_kernel_center_x = src_tile.x + config.aie_container_offset_x + config.aie_box_width/2 + (config.aie_container_width - config.aie_box_width * 2) / 4
        src_kernel_center_y = src_tile.y + config.aie_container_offset_y + config.aie_container_height/2
        
        dst_kernel_center_x = dst_tile.x + config.aie_container_offset_x + config.aie_box_width/2 + (config.aie_container_width - config.aie_box_width * 2) / 4  
        dst_kernel_center_y = dst_tile.y + config.aie_container_offset_y + config.aie_container_height/2
        
        # Create direct line SVG between kernel centers
        line_svg = f'<line id="cascade_line_{src_tile_index}_{dst_tile_index}" '\
                  f'x1="{src_kernel_center_x}" y1="{src_kernel_center_y}" '\
                  f'x2="{dst_kernel_center_x}" y2="{dst_kernel_center_y}" '\
                  f'stroke="{color}" stroke-width="3" fill="none" />\n'
        
        # Create animated circle flowing along the line
        if direction == 'east':
            path_length = dst_kernel_center_x - src_kernel_center_x
            animation_path = f"M0,0 L{path_length},0"
        elif direction == 'west':
            path_length = src_kernel_center_x - dst_kernel_center_x
            animation_path = f"M0,0 L{-path_length},0"
        elif direction == 'south':
            path_length = dst_kernel_center_y - src_kernel_center_y
            animation_path = f"M0,0 L0,{path_length}"
        elif direction == 'north':
            path_length = src_kernel_center_y - dst_kernel_center_y
            animation_path = f"M0,0 L0,{-path_length}"
        
        # Create animated circle
        animation_svg = f'<circle id="cascade_animation_{src_tile_index}_{dst_tile_index}" '\
                       f'cx="{src_kernel_center_x}" cy="{src_kernel_center_y}" r="4" fill="{color}">\n'\
                       f'  <animateMotion dur="{self._kanimate_duration}s" repeatCount="indefinite" '\
                       f'path="{animation_path}" />\n'\
                       f'</circle>\n'
        
        # Add the line and animation to the appropriate tile's SVG
        # We'll add it to the source tile's connections SVG
        src_tile.ic_connections_svg += line_svg
        src_tile.ic_animations_svg += animation_svg

    def _draw_ct2ct_data_movement(self, src, dst) -> None:
        """Display animation originating from CT and destination CT

        If the tiles are neighbor we display the animation using the
        crossbar.
        If they are not neighbors, we use the stream interconnect.
        """

        src_row = self._drawn_kernels[src['name']]['row']
        src_col = self._drawn_kernels[src['name']]['col']
        src_kcol = self._drawn_kernels[src['name']]['kcolor']
        if self._are_neighbors(src, dst):
            up, down = self._get_rel_neighbor_loc(src, dst)
            tile_index = self._get_tile_index(src_row-int(up), src_col)
            # Track that this tile and direction is used
            self._used_interconnect_tiles.add(tile_index)
            if up:
                self._track_tile_direction(tile_index, 'up_mem_to_aie')
            if down:
                self._track_tile_direction(tile_index, 'down_mem_to_aie')
            self._col_svg.aie_tiles[tile_index].add_mem_animation(
                    up_mem_to_aie=up,
                    down_mem_to_aie=down,
                    color=src_kcol,
                    duration=self._kanimate_duration)
        else:
            dst_row = self._drawn_kernels[dst['name']]['row']
            dst_col = self._drawn_kernels[dst['name']]['col']
            # For cross-column connections, use source column for the path
            if src_row > dst_row:
                for i in range(dst_row, src_row+1):
                    diagonal_to_tile = dst_row == i
                    diagonal_from_tile = src_row == i
                    tile_index = self._get_tile_index(i, src_col)
                    # Track that this tile and directions are used
                    self._used_interconnect_tiles.add(tile_index)
                    if diagonal_from_tile:
                        self._track_tile_direction(tile_index, 'diagonal_from')
                    if diagonal_to_tile:
                        self._track_tile_direction(tile_index, 'diagonal_to')
                    if not diagonal_from_tile:
                        self._track_tile_direction(tile_index, 'north')
                    self._col_svg.aie_tiles[tile_index].add_ic_animation(
                        diagonal_from_tile=diagonal_from_tile,
                        diagonal_to_tile=diagonal_to_tile,
                        north=not diagonal_from_tile,
                        duration=self._kanimate_duration/2,
                        color=src_kcol)
            else:
                for i in range(src_row, dst_row+1):
                    diagonal_to_tile = dst_row == i
                    diagonal_from_tile = src_row == i
                    tile_index = self._get_tile_index(i, src_col)
                    # Track that this tile and directions are used
                    self._used_interconnect_tiles.add(tile_index)
                    if diagonal_from_tile:
                        self._track_tile_direction(tile_index, 'diagonal_from')
                    if diagonal_to_tile:
                        self._track_tile_direction(tile_index, 'diagonal_to')
                    if not diagonal_to_tile:
                        self._track_tile_direction(tile_index, 'south')
                    self._col_svg.aie_tiles[tile_index].add_ic_animation(
                        diagonal_from_tile=diagonal_from_tile,
                        diagonal_to_tile=diagonal_to_tile,
                        south=not diagonal_to_tile,
                        duration=self._kanimate_duration/2,
                        color=src_kcol)

    def _are_neighbors(self, aie1, aie2) -> str:
        """ Return true if two aie tiles are neighbors """
        row_diff = abs(aie1['tloc'][1] - aie2['tloc'][1])
        return row_diff <= 1

    def _get_rel_neighbor_loc(self, aie1, aie2) -> Tuple[int, int]:
        if self._are_neighbors(aie1, aie2):
            row_diff = aie1['tloc'][1] - aie2['tloc'][1]
            return row_diff == -1, row_diff == +1

    def _parse_metadata(self, metadata) -> dict:
        """ parses and checks the incoming metadata """
        # metadata is either a filepath or a direct string of the json
        if isinstance(metadata, dict):
            md = metadata
        elif os.path.isfile(metadata):
            with open(metadata, "r") as fp:
                md = json.load(fp)
        else:
            try:
                md = json.load(metadata)
            except Exception as e:
                raise RuntimeError("Unable to parse input metadata for "
                                   "visualizing as either a "
                                   "file or string") from e
        
        # Check if this is the new tile-based format and convert it
        if 'tiles' in md and 'kernels' not in md:
            # Store original metadata for connections
            self._original_md = md.copy()
            # Store original tile metadata for detailed annotations
            self._tile_metadata = md.get('tiles', {})
            md = self._convert_tile_format_to_kernel_format(md)
        else:
            self._original_md = md
            self._tile_metadata = {}
            
        return md
    
    def _convert_tile_format_to_kernel_format(self, md):
        """Convert tile-based format to kernel-based format"""
        kernels = {}
        connections = {}
        
        # Create kernels for all tile types
        for tile_id, tile_data in md.get('tiles', {}).items():
            location = tile_data.get('location', [0, 0])
            tile_type = tile_data.get('type', 'UNKNOWN')
            
            # Map tile types to kernel types
            if tile_type == 'SHIM':
                kernel_type = 'IT'  # Interface Tile
            elif tile_type == 'MEM':
                kernel_type = 'MT'  # Memory Tile
            elif tile_type == 'COMPUTE':
                kernel_type = 'CT'  # Compute Tile
            else:
                continue  # Skip unknown types
            
            kernels[tile_id] = {
                'name': tile_id,
                'type': kernel_type,
                'tloc': location
            }
        
        # Convert connections with proper field names
        for conn_id, conn_data in md.get('connections', {}).items():
            source_tile = conn_data.get('source', {}).get('tile')
            dest_tile = conn_data.get('destination', {}).get('tile')
            source_port = conn_data.get('source', {}).get('port', 'DMA:0')
            dest_port = conn_data.get('destination', {}).get('port', 'DMA:0')
            connection_type = conn_data.get('type', 'stream')
            
            # Include all connections between valid tiles
            if source_tile in kernels and dest_tile in kernels:
                connections[conn_id] = {
                    'name': conn_id,
                    'srckernel': source_tile,
                    'sinkkernel': dest_tile,
                    'srcport': self._convert_port_name(source_port, kernels[source_tile]['type'], connection_type),
                    'sinkport': self._convert_port_name(dest_port, kernels[dest_tile]['type'], connection_type),
                    'type': connection_type
                }
        
        # Create the converted format
        converted = {
            'kernels': kernels,
            'connections': connections
        }
        
        # Copy over any other fields that might be useful
        for key in ['application', 'device']:
            if key in md:
                converted[key] = md[key]
        
        return converted
    
    def _convert_port_name(self, original_port, tile_type, connection_type='stream'):
        """Convert DMA port names to simplified format"""
        # Handle cascade connections specially
        if connection_type == 'cascade':
            if 'Cascade:Out' in original_port:
                return 'CascadeOut'
            elif 'Cascade:In' in original_port:
                return 'CascadeIn'
        
        if tile_type == 'IT':
            return 'ITout' if 'DMA' in original_port else original_port
        elif tile_type == 'MT':
            return 'MTout' if 'DMA' in original_port else original_port
        elif tile_type == 'CT':
            return 'CTout' if 'DMA' in original_port else original_port
        return original_port

    def make_unused_tiles_transparent(self, opacity=0.4):
        """Make unused tiles transparent only within the bounding rectangle of used tiles"""
        # Find all used tile coordinates (actual coordinates, not mapped indices)
        used_tile_coords = set()
        used_aie_coords = set()  # Compute tiles
        used_mem_coords = set()  # Memory tiles  
        used_if_coords = set()   # Interface tiles
        
        for kernel_name, kernel_info in self._drawn_kernels.items():
            # Get the kernel type from the original data
            kernel_data = next((k for k in self._md['kernels'].values() if k['name'] == kernel_name), None)
            if kernel_data and 'row' in kernel_info and 'col' in kernel_info:
                coord = (kernel_info['col'], kernel_info['row'])  # (col, row)
                used_tile_coords.add(coord)
                
                if kernel_data['type'] == 'CT':
                    used_aie_coords.add(coord)
                elif kernel_data['type'] == 'MT':
                    used_mem_coords.add(coord)
                elif kernel_data['type'] == 'IT':
                    used_if_coords.add(coord)
        
        if not used_tile_coords:
            return  # No tiles to process
            
        # Find bounding rectangle of all used tiles
        min_col = min(coord[0] for coord in used_tile_coords)
        max_col = max(coord[0] for coord in used_tile_coords)
        min_row = min(coord[1] for coord in used_tile_coords)
        max_row = max(coord[1] for coord in used_tile_coords)
        
        # Create sets of used columns and rows for each tile type within the bounding box
        used_aie_cols = {coord[0] for coord in used_aie_coords}
        used_mem_cols = {coord[0] for coord in used_mem_coords}
        used_if_cols = {coord[0] for coord in used_if_coords}
        
        # Only hide tiles within the bounding rectangle
        # Hide unused AIE tiles (compute tiles) - only within bounding box
        for i, tile in enumerate(self._col_svg.aie_tiles):
            # Get actual row and column from tile index using reverse mapping
            mapped_row = i // self._col_svg.cols  # Array row index
            mapped_col = i % self._col_svg.cols   # Array column index
            
            # Convert back to actual coordinates
            actual_col = None
            actual_row = None
            
            # Find actual column from mapping
            for orig_col, map_col in self._col_mapping.items():
                if map_col == mapped_col:
                    actual_col = orig_col
                    break
            
            # Find actual row from compute row mapping
            for orig_row, map_row in self._compute_row_mapping.items():
                if map_row == mapped_row:
                    actual_row = orig_row
                    break
            
            # Only process tiles within bounding rectangle
            if (actual_col is not None and actual_row is not None and
                min_col <= actual_col <= max_col and min_row <= actual_row <= max_row):
                if actual_col not in used_aie_cols:
                    tile.hide_tile(opacity=opacity)
        
        # Hide unused MEM tiles (memory tiles) - only within bounding box
        for i, tile in enumerate(self._col_svg.mem_tiles):
            mapped_col = i % self._col_svg.cols
            
            # Find actual column from mapping
            actual_col = None
            for orig_col, map_col in self._col_mapping.items():
                if map_col == mapped_col:
                    actual_col = orig_col
                    break
            
            # Memory tiles are typically at row 1, check if within bounding box
            if (actual_col is not None and 
                min_col <= actual_col <= max_col and min_row <= 1 <= max_row):
                if actual_col not in used_mem_cols:
                    tile.hide_tile(opacity=opacity)
                
        # Hide unused IF tiles (interface tiles) - only within bounding box
        for i, tile in enumerate(self._col_svg.if_tiles):
            mapped_col = i % self._col_svg.cols
            
            # Find actual column from mapping
            actual_col = None
            for orig_col, map_col in self._col_mapping.items():
                if map_col == mapped_col:
                    actual_col = orig_col
                    break
            
            # Interface tiles are typically at row 0, check if within bounding box
            if (actual_col is not None and 
                min_col <= actual_col <= max_col and min_row <= 0 <= max_row):
                if actual_col not in used_if_cols:
                    tile.hide_tile(opacity=opacity)
        
        # Hide connections for unused columns within bounding box
        self.make_unused_connections_transparent(used_if_cols, used_mem_cols, used_aie_cols, opacity)
    
    def make_unused_connections_transparent(self, used_if_cols, used_mem_cols, used_aie_cols, opacity=0.7):
        """Hide connections to/from unused tile columns"""
        # Check if any columns are completely unused (no IT, MT, or CT)
        all_used_cols = used_if_cols.union(used_mem_cols).union(used_aie_cols)
        total_cols = self._col_svg.cols
        unused_cols = set(range(total_cols)) - all_used_cols
        
        # Disable all blue memory connections (direct memory access lines)
        self._col_svg.disable_memory_connections()
        
        # Make NoC connections transparent for unused interface tiles
        if len(used_if_cols) < total_cols:
            self.hide_noc_connections(used_if_cols, opacity)
    
    def hide_noc_connections(self, used_if_cols, opacity=0.7):
        """Add CSS styling to make NoC connections transparent for unused columns"""
        unused_if_indices = []
        unused_mem_indices = []
        unused_aie_indices = []
        
        # Get used columns for each tile type
        used_mem_cols = set()
        used_aie_cols = set()
        for kernel_name, kernel_info in self._drawn_kernels.items():
            kernel_data = next((k for k in self._md['kernels'].values() if k['name'] == kernel_name), None)
            if kernel_data and 'col' in kernel_info:
                col = kernel_info['col']
                if kernel_data['type'] == 'MT':
                    used_mem_cols.add(col)
                elif kernel_data['type'] == 'CT':
                    used_aie_cols.add(col)
        
        # Calculate which tile indices correspond to unused columns
        for i, tile in enumerate(self._col_svg.if_tiles):
            col = i % self._col_svg.cols
            if col not in used_if_cols:
                unused_if_indices.append(tile.index)
        
        for i, tile in enumerate(self._col_svg.mem_tiles):
            col = i % self._col_svg.cols
            if col not in used_mem_cols:
                unused_mem_indices.append(tile.index)
                
        for i, tile in enumerate(self._col_svg.aie_tiles):
            col = i % self._col_svg.cols
            if col not in used_aie_cols:
                unused_aie_indices.append(tile.index)
        
        all_unused_indices = unused_if_indices + unused_mem_indices + unused_aie_indices
        
        if all_unused_indices:
            # Create CSS selectors for various connection types
            selectors = []
            
            # NoC connections (external memory connections)
            if unused_if_indices:
                selectors.extend([f"#south_mem_connection{idx}" for idx in unused_if_indices])
            
            # Vertical interconnect connections between tiles
            selectors.extend([f"#v_ic_connection{idx}" for idx in all_unused_indices])
            
            # Horizontal interconnect connections between columns for unused tiles
            for col in range(self._col_svg.cols):
                if col not in used_if_cols or col not in used_mem_cols or col not in used_aie_cols:
                    # Add horizontal connections for this column
                    selectors.extend([f"#h_ic_connection{col}"])
            
            # Diagonal connections for unused tiles
            selectors.extend([f"#diagonal{idx}" for idx in all_unused_indices])
            
            if selectors:
                selector_string = ", ".join(selectors)
                interconnect_style = f'\
        <style>\
            {selector_string} {{ \
                opacity: {opacity}; \
                stroke-dasharray: 4,4; \
            }}\
        </style>'
                
                # Add the styling to the SVG
                if not hasattr(self._col_svg, 'hide_noc_connections_svg'):
                    self._col_svg.hide_noc_connections_svg = ""
                self._col_svg.hide_noc_connections_svg += interconnect_style

        # Add specific unused inter-tile connections that should be dashed
        additional_unused_connections = []
        
        # Check for unused horizontal interconnect connections
        # These are red lines connecting tiles horizontally
        additional_unused_connections.extend([
            "#h_ic_connection0",  # horizontal red line between tiles (0,2) and (1,2) area
        ])
        
        # Check for unused vertical interconnect connections
        # These are red lines connecting tiles vertically
        additional_unused_connections.extend([
            "#v_ic_connection4",  # vertical red line between tiles (1,0) and (1,1)
        ])
        
        # Check for unused diagonal streaming connections
        # Only make diagonal lines dashed if they're actually unused
        # Use the actual SVG tile indices for diagonal connections
        all_diagonal_indices = set()
        used_svg_tile_indices = set()
        
        # Collect all possible SVG tile indices
        for col in range(getattr(self._col_svg, 'cols', 1)):
            for row in range(getattr(self._col_svg, 'rows', 1)):
                svg_tile_index = col * config.ROWS + row
                all_diagonal_indices.add(svg_tile_index)
        
        # Map our used interconnect tiles to SVG tile indices
        for kernel_name, kernel_info in self._drawn_kernels.items():
            kernel_data = next((k for k in self._md['kernels'].values() if k['name'] == kernel_name), None)
            if kernel_data and kernel_data['type'] == 'CT':  # Only compute tiles have diagonal connections
                row = kernel_info['row'] 
                col = kernel_info['col']
                our_tile_index = self._get_tile_index(row, col)
                svg_tile_index = col * config.ROWS + row
                if our_tile_index in self._used_interconnect_tiles:
                    used_svg_tile_indices.add(svg_tile_index)
        
        # Find which diagonal connections are actually unused
        unused_diagonal_indices = all_diagonal_indices - used_svg_tile_indices
        
        # Only add unused diagonal connections to the dashed list
        for idx in unused_diagonal_indices:
            additional_unused_connections.append(f"#diagonal{idx}")
        
        # Check for unused memory connections  
        # Blue memory connections are disabled entirely (see disable_memory_connections call)
        # So we don't need to add them to the dashed connections list anymore
        
        if additional_unused_connections:
            additional_selector_string = ", ".join(additional_unused_connections)
            additional_style = f'\
        <style>\
            {additional_selector_string} {{ \
                opacity: {opacity}; \
                stroke-dasharray: 4,4; \
            }}\
        </style>'
            
            # Add the styling to the SVG
            if not hasattr(self._col_svg, 'hide_noc_connections_svg'):
                self._col_svg.hide_noc_connections_svg = ""
            self._col_svg.hide_noc_connections_svg += additional_style

    def make_unused_interconnect_transparent(self, opacity: float = 0.7) -> None:
        """Make unused interconnect paths transparent by adding CSS styling"""
        
        # Skip all interconnect arrows inside tiles - they stay solid to show tile capabilities
        # Only make external connection paths (not tile arrows) dashed when unused
        selectors = []
        
        # We intentionally leave selectors empty to avoid changing tile arrows
        # The arrows inside tiles (ic_h_line*_*) will remain solid regardless of usage
        # This preserves them as visual indicators of each tile's interconnect capabilities
        
        # Add CSS styling for unused interconnect paths (currently none)
        if selectors:
            selector_string = ", ".join(selectors)
            interconnect_style = f'\
        <style>\
            {selector_string} {{ \
                opacity: {opacity}; \
                stroke-dasharray: 3,3; \
            }}\
        </style>'
            
            # Add the styling to the SVG
            if not hasattr(self._col_svg, 'hide_noc_connections_svg'):
                self._col_svg.hide_noc_connections_svg = ""
            self._col_svg.hide_noc_connections_svg += interconnect_style
            
        # Make unused external memory connections transparent
        self.make_unused_external_mem_transparent(opacity=opacity)

    def make_unused_external_mem_transparent(self, opacity: float = 0.7) -> None:
        """Make unused external memory connections (south_mem_connection) transparent"""
        
        # Get all possible external memory connection indices
        all_external_mem_indices = set()
        for col in range(getattr(self._col_svg, 'cols', 1)):
            all_external_mem_indices.add(col)
        
        # Find unused external memory connections
        unused_external_mem_indices = all_external_mem_indices - self._used_external_mem_connections
        
        # Create CSS selectors for unused external memory connections
        external_mem_selectors = []
        for idx in unused_external_mem_indices:
            external_mem_selectors.append(f"#south_mem_connection{idx}")
        
        # Add CSS styling for unused external memory connections
        if external_mem_selectors:
            selector_string = ", ".join(external_mem_selectors)
            external_mem_style = f'\
        <style>\
            {selector_string} {{ \
                opacity: {opacity}; \
                stroke-dasharray: 5,5; \
            }}\
        </style>'
            
            # Add the styling to the SVG
            if not hasattr(self._col_svg, 'hide_noc_connections_svg'):
                self._col_svg.hide_noc_connections_svg = ""
            self._col_svg.hide_noc_connections_svg += external_mem_style

    def _add_detailed_annotations(self):
        """Add detailed annotations to tiles including kernel names, buffer info, and locks"""
        if not hasattr(self, '_tile_metadata') or not self._tile_metadata:
            return
            
        for tile_id, tile_data in self._tile_metadata.items():
            # Find the corresponding kernel in drawn_kernels
            if tile_id not in self._drawn_kernels:
                continue
                
            kernel_info = self._drawn_kernels[tile_id]
            tile_index = self._get_tile_index(kernel_info['row'], kernel_info['col'])
            
            # Add annotations based on tile type
            tile_type = tile_data.get('type')
            
            if tile_type == 'COMPUTE':
                self._annotate_compute_tile(tile_index, tile_data, tile_id)
            elif tile_type == 'MEM':
                # Memory tiles are typically indexed by column, use 0 for single column designs
                mem_tile_index = self._get_mapped_col_index(kernel_info['col']) if hasattr(self._col_svg, 'cols') else 0
                self._annotate_memory_tile(mem_tile_index, tile_data, tile_id)
            elif tile_type == 'SHIM':
                # Interface tiles are typically indexed by column, use 0 for single column designs  
                if_tile_index = self._get_mapped_col_index(kernel_info['col']) if hasattr(self._col_svg, 'cols') else 0
                self._annotate_interface_tile(if_tile_index, tile_data, tile_id)
    
    def _annotate_compute_tile(self, tile_index, tile_data, tile_id):
        """Add detailed annotations to compute tiles"""
        if tile_index >= len(self._col_svg.aie_tiles):
            return
            
        tile = self._col_svg.aie_tiles[tile_index]
        
        # Get kernel information
        kernel_info = tile_data.get('kernel', {})
        kernel_name = kernel_info.get('name', 'Unknown')
        kernel_function = kernel_info.get('function', '')
        
        # Get buffer information
        buffers = tile_data.get('L1_memory', {}).get('buffers', [])
        buffer_info = []
        for buf in buffers:  # Show all buffers
            buf_name = buf.get('name', 'Unknown')
            buf_addr = buf.get('address', 0)
            buf_bank = buf.get('mem_bank', 0)
            buf_size = buf.get('size', 0)
            buf_type = buf.get('type', 'Unknown')
            
            # Extract dtype from type field (e.g., "memref<32x32xi32>" -> "i32")
            dtype = "Unknown"
            if 'x' in buf_type:
                # Find the part after the last 'x' and before '>'
                after_x = buf_type.split('x')[-1] if 'x' in buf_type else buf_type
                dtype = after_x.split('>')[0] if '>' in after_x else after_x
            
            # Format: name, size, dtype, address, bank
            buffer_info.append(f"{buf_name}, {buf_size}, {dtype}, {buf_addr}, {buf_bank}")
        
        # Get lock information
        locks = tile_data.get('locks', [])
        lock_info = []
        for lock in locks:  # Show all locks without limit
            lock_name = lock.get('name', 'Unknown')
            lock_id = lock.get('id', 0)
            lock_init = lock.get('init', 0)
            # Format: name, id, init - no character limit
            lock_info.append(f"{lock_name}, {lock_id}, {lock_init}")
        
        # Add custom text to the tile
        self._add_custom_text_to_aie_tile(tile, kernel_name, kernel_function, buffer_info, lock_info, tile_data, tile_id)
        
        # Add tile type and coordinate label
        tile_location = tile_data.get('location', [tile.col, tile.row])
        # AIE tiles always have content (kernels), so show coordinate
        self._add_tile_type_label(tile, "Compute", tile_location, True)
    
    def _annotate_memory_tile(self, tile_index, tile_data, tile_id):
        """Add detailed annotations to memory tiles"""
        if not hasattr(self._col_svg, 'mem_tiles') or tile_index >= len(self._col_svg.mem_tiles):
            return
            
        # Get buffer information
        buffers = tile_data.get('L2_memory', {}).get('buffers', [])
        buffer_info = []
        for buf in buffers:  # Show all buffers
            buf_name = buf.get('name', 'Unknown')
            buf_addr = buf.get('address', 0)
            buf_bank = buf.get('mem_bank', 0)
            buf_size = buf.get('size', 0)
            buf_type = buf.get('type', 'Unknown')
            
            # Extract dtype from type field (e.g., "memref<1024xi32>" -> "i32")
            dtype = "Unknown"
            if 'x' in buf_type:
                # Find the part after the last 'x' and before '>'
                after_x = buf_type.split('x')[-1] if 'x' in buf_type else buf_type
                dtype = after_x.split('>')[0] if '>' in after_x else after_x
            
            # Format: name|size|dtype|addr|bank (simple pipe-separated format)
            buffer_info.append(f"{buf_name}|{buf_size}|{dtype}|{buf_addr}|{buf_bank}")
        
        # Get lock information
        locks = tile_data.get('locks', [])
        lock_info = []
        for lock in locks:  # Show all locks without limit
            lock_name = lock.get('name', 'Unknown')
            lock_id = lock.get('id', 0)
            lock_init = lock.get('init', 0)
            # Format: Lock ID:init (name) - no character limit
            lock_info.append(f"Lock{lock_id}:{lock_init} ({lock_name})")
        
        # Add custom text for memory tile
        tile_name = tile_data.get('name', 'Memory Tile')
        total_size = tile_data.get('L2_memory', {}).get('total_size', 0)
        self._add_custom_text_to_mem_tile(self._col_svg.mem_tiles[tile_index], tile_id, total_size, buffer_info, lock_info)
        
        # Add tile type and coordinate label
        tile_location = tile_data.get('location', [self._col_svg.mem_tiles[tile_index].col, self._col_svg.mem_tiles[tile_index].row])
        # Only show coordinate label if tile has meaningful content (buffers, locks, or connections)
        has_content = bool(buffer_info or lock_info or 
                          self._get_outgoing_connections(tile_id) or
                          self._get_incoming_connections(tile_id))
        self._add_tile_type_label(self._col_svg.mem_tiles[tile_index], "Memory", tile_location, has_content)
    
    def _annotate_interface_tile(self, tile_index, tile_data, tile_id):
        """Add detailed annotations to interface tiles"""
        if not hasattr(self._col_svg, 'if_tiles') or tile_index >= len(self._col_svg.if_tiles):
            return
            
        # Get lock information
        locks = tile_data.get('locks', [])
        lock_info = []
        for lock in locks:  # Show all locks without limit
            lock_name = lock.get('name', 'Unknown')
            lock_id = lock.get('id', 0)
            lock_init = lock.get('init', 0)
            # Format: Lock ID:init (name) - no character limit
            lock_info.append(f"Lock{lock_id}:{lock_init} ({lock_name})")
        
        tile_name = tile_data.get('name', 'Interface Tile')
        controller_id = tile_data.get('controller_id', {}).get('pkt_id', 0)
        self._add_custom_text_to_if_tile(self._col_svg.if_tiles[tile_index], tile_id, controller_id, lock_info)
        
        # Add tile type and coordinate label
        tile_location = tile_data.get('location', [self._col_svg.if_tiles[tile_index].col, self._col_svg.if_tiles[tile_index].row])
        # Check if interface tile has meaningful content
        has_content = bool(lock_info or controller_id != 0 or
                          self._get_outgoing_connections(tile_id) or
                          self._get_incoming_connections(tile_id))
        self._add_tile_type_label(self._col_svg.if_tiles[tile_index], "Interface", tile_location, has_content)
    
    def _limit_content_for_space(self, sections, available_height, font_size, line_spacing):
        """Limit content to fit available space by truncating if necessary"""
        # Calculate maximum lines that can fit
        max_lines = int(available_height / line_spacing) - 2  # Leave some margin
        
        if max_lines <= 0:
            return []
        
        # Count current lines
        total_lines = 0
        for section_name, content in sections:
            total_lines += 1  # Header line
            if isinstance(content, list):
                total_lines += len(content)
            else:
                total_lines += 1
        
        if total_lines <= max_lines:
            return sections
        
        # Need to truncate - keep most important sections
        limited_sections = []
        lines_used = 0
        
        for section_name, content in sections:
            if lines_used >= max_lines:
                break
                
            # Always include header
            lines_used += 1
            
            if isinstance(content, list):
                # Calculate how many content lines we can include
                remaining_lines = max_lines - lines_used
                if remaining_lines > 0:
                    truncated_content = content[:remaining_lines]
                    if len(content) > remaining_lines:
                        # Add truncation indicator
                        if remaining_lines > 0:
                            truncated_content[-1] = truncated_content[-1] + "..."
                    limited_sections.append((section_name, truncated_content))
                    lines_used += len(truncated_content)
                else:
                    # No space for content, just add empty
                    limited_sections.append((section_name, []))
            else:
                if lines_used < max_lines:
                    limited_sections.append((section_name, content))
                    lines_used += 1
                else:
                    limited_sections.append((section_name, "..."))
                    lines_used += 1
        
        return limited_sections
    
    def _calculate_text_height(self, buffer_info, lock_info, outgoing_connections, incoming_connections):
        """Calculate the total height needed for all text sections"""
        line_spacing = 8  # Use smaller base spacing for calculation to allow tighter layout
        
        # Kernel section: header + content
        height = line_spacing * 2
        
        if buffer_info:
            # MEMORY header + buffer items
            height += line_spacing + len(buffer_info) * line_spacing
        
        if lock_info:
            # LOCKS header + lock items  
            height += line_spacing + len(lock_info) * line_spacing
            
        if outgoing_connections:
            # OUT CONNECTIONS header + properly count connection pairs
            conn_count = 0
            i = 0
            while i < len(outgoing_connections) and conn_count < 3:
                conn_info = outgoing_connections[i]
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    i += 1
                    continue
                
                # Count this connection
                conn_count += 1
                
                # Check if next item is flow info
                if i + 1 < len(outgoing_connections) and outgoing_connections[i + 1].startswith("flow:"):
                    height += line_spacing * 2  # connection line + flow line
                    i += 2
                else:
                    height += line_spacing  # just connection line
                    i += 1
            
            if conn_count > 0:
                height += line_spacing  # header
            
        if incoming_connections:
            # IN CONNECTIONS header + properly count connection pairs  
            conn_count = 0
            i = 0
            while i < len(incoming_connections) and conn_count < 3:
                conn_info = incoming_connections[i]
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    i += 1
                    continue
                
                # Count this connection
                conn_count += 1
                
                # Check if next item is flow info
                if i + 1 < len(incoming_connections) and incoming_connections[i + 1].startswith("flow:"):
                    height += line_spacing * 2  # connection line + flow line
                    i += 2
                else:
                    height += line_spacing  # just connection line
                    i += 1
            
            if conn_count > 0:
                height += line_spacing  # header
            
        return height

    def _estimate_text_width(self, text, font_size):
        """Estimate the width of text in pixels for a given font size"""
        # Rough estimation: average character width is about 0.6 * font_size for Arial
        # This is approximate but sufficient for layout checking
        char_width = font_size * 0.6
        return len(text) * char_width

    def _check_content_width(self, buffer_info, lock_info, outgoing_connections, incoming_connections, font_size):
        """Check if all content lines fit within the available width"""
        available_width = config.aie_container_width - 10  # 250px with some margin
        
        # Check all content lines
        all_content = []
        
        # Headers
        all_content.extend([
            "KERNEL [name]",
            "MEMORY [name|size|dtype|addr|bank]", 
            "LOCK [name|id|init]",
            "FLOW OUT [type|direction]",
            "FLOW IN [type|direction]"
        ])
        
        # Buffer info
        if buffer_info:
            all_content.extend(buffer_info)
            
        # Lock info  
        if lock_info:
            all_content.extend(lock_info)
            
        # Connection info
        if outgoing_connections:
            all_content.extend(outgoing_connections)
        if incoming_connections:
            all_content.extend(incoming_connections)
            
        # Check if any line is too wide
        for line in all_content:
            if line and self._estimate_text_width(line, font_size) > available_width:
                return False
                
        return True

    def _get_font_sizes(self, tile, buffer_info, lock_info, outgoing_connections, incoming_connections):
        """Dynamically determine optimal font size based on content height ratio and tile width"""
        text_area_y = tile.y + config.aie_container_offset_y + config.aie_container_height + 8
        total_text_height = self._calculate_text_height(buffer_info, lock_info, outgoing_connections, incoming_connections)
        
        # Use the correct available height - same as used in the text placement logic
        available_height = config.text_area_height - 40  # Leave some margin, matching the layout logic
        
        # Dynamic font sizing based on content-to-space ratio and tile width
        max_font_size = 16  # Increased back to take advantage of wider tiles
        min_font_size = 6   # Increased minimum for better readability
        
        # Calculate content density and adjust for wider tiles
        margin = 1.05  # Reduced margin to be less conservative
        content_ratio = (total_text_height * margin) / available_height
        
        # Bonus for wider tiles - memory tiles and expanded tiles can use larger fonts
        width_bonus = 0.0
        if config.tile_width >= 360:  # Our expanded tile width
            width_bonus = 0.25  # Increased bonus for wider tiles
        
        # Apply width bonus to make content appear less dense
        adjusted_content_ratio = content_ratio - width_bonus
        
        # More generous font size selection based on height
        if adjusted_content_ratio <= 0.5:
            # Light content - use maximum font size
            initial_font_size = max_font_size
        elif adjusted_content_ratio <= 0.7:
            # Moderate content - use large font
            initial_font_size = 14
        elif adjusted_content_ratio <= 0.9:
            # Dense content - use medium-large font
            initial_font_size = 12
        elif adjusted_content_ratio <= 1.1:
            # Very dense content - use medium font
            initial_font_size = 10
        elif content_ratio <= 1.3:
            # Packed content - use smaller font
            initial_font_size = 9
        elif content_ratio <= 1.5:
            # Overflowing content - use small font
            initial_font_size = 8
        elif content_ratio <= 1.8:
            # Heavily overflowing - use tiny font
            initial_font_size = 7
        else:
            # Maximum overflow - use minimum font
            initial_font_size = min_font_size
        
        # Always use 12px font size as requested
        font_size = 12
        
        return font_size, font_size  # Use same size for headers and content

    def _count_total_lines(self, buffer_info, lock_info, outgoing_connections, incoming_connections):
        """Count total lines that would be displayed"""
        total_lines = 0
        
        # Kernel header + content
        total_lines += 2
        
        # Memory section
        if buffer_info:
            total_lines += 1  # header
            total_lines += len(buffer_info)  # content lines
        
        # Lock section  
        if lock_info:
            total_lines += 1  # header
            total_lines += len(lock_info)  # content lines
            
        # Outgoing connections
        if outgoing_connections:
            total_lines += 1  # header
            # Count connection pairs properly
            i = 0
            while i < len(outgoing_connections):
                conn_info = outgoing_connections[i]
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    i += 1
                    continue
                
                # Count this connection
                total_lines += 1
                
                # Check if next item is flow info
                if i + 1 < len(outgoing_connections) and outgoing_connections[i + 1].startswith("flow:"):
                    total_lines += 1  # flow line
                    i += 2
                else:
                    i += 1
                    
        # Incoming connections
        if incoming_connections:
            total_lines += 1  # header
            # Count connection pairs properly
            i = 0
            while i < len(incoming_connections):
                conn_info = incoming_connections[i]
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    i += 1
                    continue
                
                # Count this connection
                total_lines += 1
                
                # Check if next item is flow info
                if i + 1 < len(incoming_connections) and incoming_connections[i + 1].startswith("flow:"):
                    total_lines += 1  # flow line
                    i += 2
                else:
                    i += 1
        
        return total_lines

    def _truncate_content_for_display(self, buffer_info, lock_info, outgoing_connections, incoming_connections, max_lines=19, is_memory_tile=False):
        """Truncate content to fit within max_lines and return truncated versions plus whether truncation occurred"""
        total_lines = self._count_total_lines(buffer_info, lock_info, outgoing_connections, incoming_connections)
        
        # For memory tiles, add 2 more lines before truncation
        effective_max_lines = max_lines + (2 if is_memory_tile else 0)
        
        if total_lines <= effective_max_lines:
            return buffer_info, lock_info, outgoing_connections, incoming_connections, False
        
        # Need to truncate - prioritize content in order: kernel > memory > FLOW IN > FLOW OUT > locks
        used_lines = 2  # kernel header + content
        remaining_lines = effective_max_lines - used_lines - 1  # -1 for truncation message
        
        # Truncate buffer info (highest priority after kernel)
        truncated_buffer_info = []
        if buffer_info and remaining_lines > 1:
            header_lines = 1
            available_for_content = min(remaining_lines - header_lines, len(buffer_info))
            truncated_buffer_info = buffer_info[:available_for_content]
            used_lines += header_lines + len(truncated_buffer_info)
            remaining_lines -= (header_lines + len(truncated_buffer_info))
        
        # Prioritize FLOW IN connections (higher priority than locks)
        truncated_incoming = []
        if incoming_connections and remaining_lines > 1:
            header_lines = 1
            # Allow more space for incoming connections - they're important for understanding data flow
            conn_count = min(4, remaining_lines - header_lines)  # header + up to 4 connections
            
            # Keep connection-flow pairs together during truncation
            i = 0
            connection_pairs = 0
            while i < len(incoming_connections) and connection_pairs < conn_count:
                # Add the connection
                truncated_incoming.append(incoming_connections[i])
                
                # Check if next item is a flow info, if so add it too
                if i + 1 < len(incoming_connections) and incoming_connections[i + 1].startswith("flow:"):
                    truncated_incoming.append(incoming_connections[i + 1])
                    i += 2  # Skip both connection and flow
                else:
                    i += 1  # Just skip connection
                    
                connection_pairs += 1
                
            used_lines += header_lines + len(truncated_incoming)
            remaining_lines -= (header_lines + len(truncated_incoming))
        
        # FLOW OUT connections (medium priority)
        truncated_outgoing = []
        if outgoing_connections and remaining_lines > 1:
            header_lines = 1
            conn_count = min(3, remaining_lines - header_lines)  # header + up to 3 connections
            
            # Keep connection-flow pairs together during truncation
            i = 0
            connection_pairs = 0
            while i < len(outgoing_connections) and connection_pairs < conn_count:
                # Add the connection
                truncated_outgoing.append(outgoing_connections[i])
                
                # Check if next item is a flow info, if so add it too
                if i + 1 < len(outgoing_connections) and outgoing_connections[i + 1].startswith("flow:"):
                    truncated_outgoing.append(outgoing_connections[i + 1])
                    i += 2  # Skip both connection and flow
                else:
                    i += 1  # Just skip connection
                    
                connection_pairs += 1
                
            used_lines += header_lines + len(truncated_outgoing)
            remaining_lines -= (header_lines + len(truncated_outgoing))
        
        # Truncate lock info (lowest priority - gets cut first)
        truncated_lock_info = []
        if lock_info and remaining_lines > 1:
            header_lines = 1
            available_for_content = min(remaining_lines - header_lines, len(lock_info))
            truncated_lock_info = lock_info[:available_for_content]
        
        return truncated_buffer_info, truncated_lock_info, truncated_outgoing, truncated_incoming, True

    def _add_custom_text_to_aie_tile(self, tile, kernel_name, kernel_function, buffer_info, lock_info, tile_data, tile_id):
        """Add custom text annotations to an AIE tile in the dedicated text area"""
        # Position text in the dedicated text area that matches the functional container position
        text_area_x = tile.x + config.aie_container_offset_x + 5  # Left margin within text area
        text_area_y = tile.y + config.aie_container_offset_y + config.aie_container_height + 8  # Right after functional container + margin
        
        # Get connections for font size calculation using the passed tile_id
        outgoing_connections = self._get_outgoing_connections(tile_id)
        incoming_connections = self._get_incoming_connections(tile_id)
        
        # print(f"DEBUG ORIGINAL OUTGOING for {tile_id}: {outgoing_connections}")
        
        # Check if content needs truncation for display
        truncated_buffer_info, truncated_lock_info, truncated_outgoing, truncated_incoming, was_truncated = \
            self._truncate_content_for_display(buffer_info, lock_info, outgoing_connections, incoming_connections, max_lines=19)
        
        # Use truncated content for font size calculation if truncated
        display_buffer_info = truncated_buffer_info if was_truncated else buffer_info
        display_lock_info = truncated_lock_info if was_truncated else lock_info
        display_outgoing = truncated_outgoing if was_truncated else outgoing_connections
        display_incoming = truncated_incoming if was_truncated else incoming_connections
        
        # Determine font sizes based on display content (after truncation)
        header_font_size, content_font_size = self._get_font_sizes(tile, display_buffer_info, display_lock_info, display_outgoing, display_incoming)
        
        # Set line spacing to 1.25x font size for better readability
        line_spacing = int(header_font_size * 1.25)  # Line spacing 1.25x font size for better spacing
        
        custom_text = f"""
<g id="custom_annotations_{tile.index}">
    <!-- Kernel info section -->
    <text x="{text_area_x}" y="{text_area_y + line_spacing}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        KERNEL [name]
    </text>
    <text x="{text_area_x}" y="{text_area_y + line_spacing * 2}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {kernel_name}
    </text>"""
        
        # Add memory/buffer information (using display content)
        y_offset = text_area_y + line_spacing * 3
        if display_buffer_info:
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        MEMORY [name|size|dtype|addr|bank]
    </text>"""
            
            for i, buf_info in enumerate(display_buffer_info):  # Use truncated content
                # Parse buffer info and format according to new structure
                parts = buf_info.split(', ')
                if len(parts) >= 5:
                    name = parts[0]
                    size = parts[1] if parts[1] != '0' else 'N/A'
                    dtype = parts[2].replace('1024i32', 'i32').replace('i32', 'i32')
                    addr = parts[3] if len(parts) > 3 else 'N/A'
                    bank = parts[4] if len(parts) > 4 else 'N/A'
                    formatted_info = f"{name} | {size} | {dtype} | {addr} | {bank}"
                elif len(parts) >= 3:
                    name = parts[0]
                    size = parts[1] if parts[1] != '0' else 'N/A'
                    dtype = parts[2].replace('1024i32', 'i32')
                    formatted_info = f"{name} | {size} | {dtype} | N/A | N/A"
                else:
                    formatted_info = f"{buf_info} | N/A | N/A | N/A | N/A"
                
                custom_text += f"""
    <text x="{text_area_x}" y="{y_offset + line_spacing + i*line_spacing}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_info}
    </text>"""
            y_offset += len(display_buffer_info) * line_spacing
        
        # Add connections IN first (using display content)
        if tile_id:
            if display_incoming:
                y_offset += line_spacing  # Add minimal spacing after MEMORY
                custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        FLOW IN [type|direction]
    </text>"""
                
                conn_y_offset = y_offset
                # Group connections with their flows
                i = 0
                connection_count = 0
                while i < len(display_incoming) and connection_count < 3:
                    conn_info = display_incoming[i]
                    
                    # Skip empty or whitespace-only connection entries
                    if not conn_info or not conn_info.strip():
                        i += 1
                        continue
                    
                    # If this is a flow line, skip it (it should be paired with previous connection)
                    if conn_info.startswith("flow:"):
                        i += 1
                        continue
                        
                    # This is a connection line, check if next item is its flow
                    flow_info = "N/A"
                    if i + 1 < len(display_incoming) and display_incoming[i + 1].startswith("flow:"):
                        flow_info = display_incoming[i + 1].replace("flow:", "").strip()
                        i += 2  # Skip both connection and flow
                    else:
                        i += 1  # Just skip connection
                    
                    # Parse and format connection info
                    conn_details = [conn_info.strip()]
                    # name removed
                    conn_type = conn_details[0] if len(conn_details) > 0 else "N/A"
                    
                    
                    # Only add if we have valid connection data
                    if conn_type != "N/A":
                        # Single line: type | flow_info
                        formatted_conn = f"{conn_type} | {flow_info}" if flow_info != "N/A" else f"{conn_type}"
                        conn_y_offset += line_spacing
                        custom_text += f"""
    <text x="{text_area_x}" y="{conn_y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
                        
                        connection_count += 1
                        
                y_offset = conn_y_offset
            
            # Add connections OUT second (using display content)
            if display_outgoing:
                y_offset += line_spacing  # Add minimal spacing after FLOW IN
                custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        FLOW OUT [type|direction]
    </text>"""
                
                conn_y_offset = y_offset
                # Group connections with their flows
                i = 0
                connection_count = 0
                # print(f"DEBUG OUTGOING for {tile_id}: {display_outgoing}")
                while i < len(display_outgoing) and connection_count < 3:
                    conn_info = display_outgoing[i]
                    
                    # Skip empty or whitespace-only connection entries
                    if not conn_info or not conn_info.strip():
                        i += 1
                        continue
                    
                    # If this is a flow line, skip it (it should be paired with previous connection)
                    if conn_info.startswith("flow:"):
                        i += 1
                        continue
                        
                    # This is a connection line, check if next item is its flow
                    flow_info = "N/A"
                    if i + 1 < len(display_outgoing) and display_outgoing[i + 1].startswith("flow:"):
                        flow_info = display_outgoing[i + 1].replace("flow:", "").strip()
                        i += 2  # Skip both connection and flow
                    else:
                        i += 1  # Just skip connection
                    
                    # Parse and format connection info
                    conn_details = [conn_info.strip()]
                    # name removed
                    conn_type = conn_details[0] if len(conn_details) > 0 else "N/A"
                    
                    
                    # Only add if we have valid connection data
                    if conn_type != "N/A":
                        # Single line: type | flow_info
                        formatted_conn = f"{conn_type} | {flow_info}" if flow_info != "N/A" else f"{conn_type}"
                        conn_y_offset += line_spacing
                        custom_text += f"""
    <text x="{text_area_x}" y="{conn_y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
                        
                        connection_count += 1
                
                y_offset = conn_y_offset
        
        # Add lock information last (using display content)
        if display_lock_info:
            y_offset += line_spacing  # Add minimal spacing after FLOW OUT
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        LOCK [name|id|init]
    </text>"""
            
            for i, lock_info_str in enumerate(display_lock_info):  # Use truncated locks
                # Parse lock info and format according to new structure
                parts = lock_info_str.split(', ')
                if len(parts) >= 3:
                    name = parts[0]  # No character limit
                    id_val = parts[1] if len(parts) > 1 else 'N/A'
                    init_val = parts[2] if len(parts) > 2 else 'N/A'
                    formatted_lock = f"{name} | {id_val} | {init_val}"
                else:
                    formatted_lock = f"{lock_info_str} | N/A | N/A"  # No character limit
                
                custom_text += f"""
    <text x="{text_area_x}" y="{y_offset + line_spacing + i*line_spacing}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_lock}
    </text>"""
            y_offset += len(display_lock_info) * line_spacing + line_spacing
        
        # Add truncation message if content was truncated
        if was_truncated:
            y_offset += line_spacing  # Add spacing before truncation message
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="red" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        truncated, see full details in .txt
    </text>"""
        
        custom_text += "\n</g>"
        
        # Add to the tile's additional SVG content
        if not hasattr(tile, 'custom_annotations'):
            tile.custom_annotations = ""
        tile.custom_annotations += custom_text
    
    def _add_custom_text_to_mem_tile(self, tile, tile_id, total_size, buffer_info, lock_info):
        """Add custom text annotations to a memory tile in the dedicated text area"""
        # Position text in the dedicated text area that matches the outer container position
        text_area_x = tile.x + config.aie_container_offset_x + 5  # Match outer container + margin
        text_area_y = tile.y + config.aie_container_offset_y + config.aie_container_height + 8  # Right after container + margin
        
        # Get tile row/col from tile object
        tile_row = getattr(tile, 'row', 1)  # Memory tiles are typically row 1
        
        # Get connections for truncation and font size calculation
        outgoing_connections = self._get_outgoing_connections(tile_id)
        incoming_connections = self._get_incoming_connections(tile_id)
        
        # Check if content needs truncation for display
        truncated_buffer_info, truncated_lock_info, truncated_outgoing, truncated_incoming, was_truncated = \
            self._truncate_content_for_display(buffer_info, lock_info, outgoing_connections, incoming_connections, max_lines=19, is_memory_tile=True)
        
        # Use truncated content for display
        display_buffer_info = truncated_buffer_info if was_truncated else buffer_info
        display_lock_info = truncated_lock_info if was_truncated else lock_info
        display_outgoing = truncated_outgoing if was_truncated else outgoing_connections
        display_incoming = truncated_incoming if was_truncated else incoming_connections
        
        # Determine font sizes based on display content (after truncation)
        header_font_size, content_font_size = self._get_font_sizes(tile, display_buffer_info, display_lock_info, display_outgoing, display_incoming)
        
        # Set line spacing to 1.25x font size for better readability
        line_spacing = int(header_font_size * 1.25)  # Line spacing 1.25x font size for better spacing
        
        custom_text = f"""
<g id="custom_mem_annotations_{tile.index}">
    <!-- MEMORY section -->
    <text x="{text_area_x}" y="{text_area_y + line_spacing}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        MEMORY [name|size|dtype|addr|bank]
    </text>"""
        
        # Add buffer information (using display content)
        y_offset = text_area_y + line_spacing
        if display_buffer_info:
            for i, buf_info in enumerate(display_buffer_info):  # Use truncated buffers
                y_offset += line_spacing
                # Parse buffer info - now using simple pipe format: name|size|dtype|addr|bank
                if '|' in buf_info:
                    # Direct pipe-separated format: name|size|dtype|addr|bank
                    parts = buf_info.split('|')
                    if len(parts) >= 5:
                        # Add spaces around pipes for better readability
                        formatted_buf = ' | '.join(parts)
                    else:
                        formatted_buf = f"{buf_info} | N/A | N/A | N/A | N/A"
                else:
                    # Fallback format
                    formatted_buf = f"{buf_info} | N/A | N/A | N/A | N/A"
                
                custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_buf}
    </text>"""
        
        # Add FLOW IN section BEFORE FLOW OUT (using display content)
        if display_incoming:
            y_offset += line_spacing  # Add one line spacing after MEMORY content
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        FLOW IN [type|direction]
    </text>"""
            
            # Process connections with flow info grouping - memory tile single-line format
            conn_y_offset = y_offset
            i = 0
            conn_count = 0
            while i < len(display_incoming) and conn_count < 3:
                conn_info = display_incoming[i]
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    i += 1
                    continue
                
                # This is a connection line, check if next item is its flow
                flow_info = "N/A"
                if i + 1 < len(display_incoming) and display_incoming[i + 1].startswith("flow:"):
                    flow_info = display_incoming[i + 1].replace("flow:", "").strip()
                    i += 2  # Skip both connection and flow
                else:
                    i += 1  # Just skip connection
                
                # Parse and format connection info
                conn_details = [conn_info.strip()]
                # name removed
                conn_type = conn_details[0] if len(conn_details) > 0 else "N/A"
                
                
                # Only add if we have valid connection data
                if conn_type != "N/A":
                    # Single line: type | flow_info
                    formatted_conn = f"{conn_type} | {flow_info}" if flow_info != "N/A" else f"{conn_type}"
                    conn_y_offset += line_spacing
                    custom_text += f"""
    <text x="{text_area_x}" y="{conn_y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
                    
                    conn_count += 1
            
            y_offset = conn_y_offset
        
        # Add FLOW OUT section AFTER FLOW IN (using display content)
        if display_outgoing:
            y_offset += line_spacing  # Add one line spacing after FLOW IN content
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        FLOW OUT [type|direction]
    </text>"""
            
            # Process connections with flow info grouping - memory tile single-line format
            conn_y_offset = y_offset
            i = 0
            conn_count = 0
            # print(f"DEBUG FLOW OUT processing for {tile_id}: display_outgoing = {display_outgoing}")
            while i < len(display_outgoing) and conn_count < 3:
                conn_info = display_outgoing[i]
                # print(f"DEBUG FLOW OUT step {i}: conn_info = '{conn_info}', remaining = {display_outgoing[i:]}")
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    # print(f"DEBUG FLOW OUT skipping at {i}: '{conn_info}'")
                    i += 1
                    continue
                
                # This is a connection line, check if next item is its flow
                flow_info = "N/A"
                if i + 1 < len(display_outgoing) and display_outgoing[i + 1].startswith("flow:"):
                    flow_info = display_outgoing[i + 1].replace("flow:", "").strip()
                    # print(f"DEBUG FLOW OUT found flow at {i+1}: '{flow_info}'")
                    i += 2  # Skip both connection and flow
                else:
                    # print(f"DEBUG FLOW OUT no flow found for {i}, next item: {display_outgoing[i + 1] if i + 1 < len(display_outgoing) else 'NONE'}")
                    i += 1  # Just skip connection
                
                # Parse and format connection info
                conn_details = [conn_info.strip()]
                # name removed
                conn_type = conn_details[0] if len(conn_details) > 0 else "N/A"
                
                
                # Only add if we have valid connection data
                if conn_type != "N/A":
                    # Single line: type | flow_info
                    formatted_conn = f"{conn_type} | {flow_info}" if flow_info != "N/A" else f"{conn_type}"
                    conn_y_offset += line_spacing
                    custom_text += f"""
    <text x="{text_area_x}" y="{conn_y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
                    
                    conn_count += 1
            
            y_offset = conn_y_offset
        
        # Add LOCKS section LAST (using display content)
        if display_lock_info:
            y_offset += line_spacing  # Add one line spacing after FLOW OUT content
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        LOCK [name|id|init]
    </text>"""
            for i, lock_text in enumerate(display_lock_info):  # Use truncated locks
                y_offset += line_spacing
                # Parse lock info and format with pipes for memory tile
                if ':' in lock_text and '(' in lock_text:
                    # Format: Lock0:2 (mem_input_) -> mem_input_ | 0 | 2
                    lock_parts = lock_text.split(' ')
                    if len(lock_parts) >= 2:
                        lock_id_init = lock_parts[0]  # Lock0:2
                        lock_name = lock_parts[1].strip('()') # mem_input_
                        if ':' in lock_id_init:
                            lock_id = lock_id_init.split(':')[0].replace('Lock', '')
                            lock_init = lock_id_init.split(':')[1]
                            formatted_lock = f"{lock_name} | {lock_id} | {lock_init}"
                        else:
                            formatted_lock = f"{lock_name} | N/A | N/A"
                    else:
                        formatted_lock = f"{lock_text} | N/A | N/A"
                else:
                    formatted_lock = f"{lock_text} | N/A | N/A"
                
                custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_lock}
    </text>"""
        
        # Add truncation message if content was truncated
        if was_truncated:
            y_offset += line_spacing  # Add spacing before truncation message
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="red" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        truncated, see full details in .txt
    </text>"""
        
        custom_text += "\n</g>"
        
        # Add to the tile's additional SVG content
        if not hasattr(tile, 'custom_annotations'):
            tile.custom_annotations = ""
        tile.custom_annotations += custom_text
    
    def _add_custom_text_to_if_tile(self, tile, tile_id, controller_id, lock_info):
        """Add custom text annotations to an interface tile in the dedicated text area"""
        # Position text in the dedicated text area that matches the outer container position
        text_area_x = tile.x + config.aie_container_offset_x + 5  # Match outer container + margin
        text_area_y = tile.y + config.aie_container_offset_y + config.aie_container_height + 8  # Right after container + margin
        
        # Get tile row/col from tile object
        tile_row = getattr(tile, 'row', 0)  # Interface tiles are typically row 0
        
        # Get connections for font size calculation
        outgoing_connections = self._get_outgoing_connections(tile_id)
        incoming_connections = self._get_incoming_connections(tile_id)
        
        # Determine font sizes based on content (same system as AIE tiles)
        header_font_size, content_font_size = self._get_font_sizes(tile, [], lock_info, outgoing_connections, incoming_connections)
        
        # Set line spacing to 1.25x font size for better readability
        line_spacing = int(header_font_size * 1.25)  # Line spacing 1.25x font size for better spacing
        
        custom_text = f"""
<g id="custom_if_annotations_{tile.index}">"""
        
        # Start with FLOW IN section first
        y_offset = text_area_y
        if incoming_connections:
            y_offset += line_spacing
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        FLOW IN [type|direction]
    </text>"""
            
            # Process connections with flow info grouping - interface tile single-line format
            conn_y_offset = y_offset
            i = 0
            conn_count = 0
            while i < len(incoming_connections) and conn_count < 3:
                conn_info = incoming_connections[i]
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    i += 1
                    continue
                
                # This is a connection line, check if next item is its flow
                flow_info = "N/A"
                if i + 1 < len(incoming_connections) and incoming_connections[i + 1].startswith("flow:"):
                    flow_info = incoming_connections[i + 1].replace("flow:", "").strip()
                    i += 2  # Skip both connection and flow
                else:
                    i += 1  # Just skip connection
                
                # Parse and format connection info
                conn_details = [conn_info.strip()]
                # name removed
                conn_type = conn_details[0] if len(conn_details) > 0 else "N/A"
                
                
                # Only add if we have valid connection data
                if conn_type != "N/A":
                    # Single line: type | flow_info
                    formatted_conn = f"{conn_type} | {flow_info}" if flow_info != "N/A" else f"{conn_type}"
                    conn_y_offset += line_spacing
                    custom_text += f"""
    <text x="{text_area_x}" y="{conn_y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
                    
                    conn_count += 1
            
            y_offset = conn_y_offset
        
        # Add FLOW OUT section second
        if outgoing_connections:
            y_offset += line_spacing
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        FLOW OUT [type|direction]
    </text>"""
            
            # Process connections with flow info grouping - interface tile single-line format
            conn_y_offset = y_offset
            i = 0
            conn_count = 0
            while i < len(outgoing_connections) and conn_count < 3:
                conn_info = outgoing_connections[i]
                if not conn_info or not conn_info.strip() or conn_info.startswith("flow:"):
                    i += 1
                    continue
                
                # This is a connection line, check if next item is its flow
                flow_info = "N/A"
                if i + 1 < len(outgoing_connections) and outgoing_connections[i + 1].startswith("flow:"):
                    flow_info = outgoing_connections[i + 1].replace("flow:", "").strip()
                    i += 2  # Skip both connection and flow
                else:
                    i += 1  # Just skip connection
                
                # Parse and format connection info
                conn_details = [conn_info.strip()]
                # name removed
                conn_type = conn_details[0] if len(conn_details) > 0 else "N/A"
                
                
                # Only add if we have valid connection data
                if conn_type != "N/A":
                    # Single line: type | flow_info
                    formatted_conn = f"{conn_type} | {flow_info}" if flow_info != "N/A" else f"{conn_type}"
                    conn_y_offset += line_spacing
                    custom_text += f"""
    <text x="{text_area_x}" y="{conn_y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
                    
                    conn_count += 1
            
            y_offset = conn_y_offset
        
        # Add LOCKS section last
        if lock_info:
            y_offset += line_spacing
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        LOCK [name|id|init]
    </text>"""
            for i, lock_text in enumerate(lock_info):  # Show all locks
                y_offset += line_spacing
                # Parse lock info and format with pipes for interface tile
                if ':' in lock_text and '(' in lock_text:
                    # Format: Lock0:1 (input_prod_l) -> input_prod_l | 0 | 1
                    lock_parts = lock_text.split(' ')
                    if len(lock_parts) >= 2:
                        lock_id_init = lock_parts[0]  # Lock0:1
                        lock_name = lock_parts[1].strip('()') # input_prod_l
                        if ':' in lock_id_init:
                            lock_id = lock_id_init.split(':')[0].replace('Lock', '')
                            lock_init = lock_id_init.split(':')[1]
                            formatted_lock = f"{lock_name} | {lock_id} | {lock_init}"
                        else:
                            formatted_lock = f"{lock_name} | N/A | N/A"
                    else:
                        formatted_lock = f"{lock_text} | N/A | N/A"
                else:
                    formatted_lock = f"{lock_text} | N/A | N/A"
                
                custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_lock}
    </text>"""
        
        custom_text += "\n</g>"
        
        # Add to the tile's additional SVG content
        if not hasattr(tile, 'custom_annotations'):
            tile.custom_annotations = ""
        tile.custom_annotations += custom_text

    def _add_tile_type_label(self, tile, tile_type_name, tile_location=None, has_content=True):
        """Add bold tile type and coordinate labels in the left bottom area"""
        # Position the label in the left bottom area of the tile
        label_x = tile.x + 10  # Left margin
        label_y = tile.y + config.tile_height - 30  # Bottom area
        
        # Use provided location or fall back to tile coordinates
        if tile_location:
            col, row = tile_location
        else:
            col, row = tile.col, tile.row
        
        # Only add coordinate labels for tiles with actual content
        coordinate_label = ""
        if has_content:
            coordinate_label = f"""
    <!-- Coordinate label -->
    <text x="{label_x}" y="{label_y + 20}" font-size="25" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        ({col}, {row})
    </text>"""
        
        label_text = f"""
<g id="tile_label_{tile.index}">
    <!-- Tile type label -->
    <text x="{label_x}" y="{label_y -12 }" font-size="17" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        {tile_type_name}
    </text>{coordinate_label}
</g>"""
        
        # Add to the tile's additional SVG content
        if not hasattr(tile, 'custom_annotations'):
            tile.custom_annotations = ""
        tile.custom_annotations += label_text

    def _format_port_name(self, port_name):
        """Format port names for display: TileControl : 0 -> Ctrl:0, South : 0 -> South:0"""
        if not port_name:
            return port_name
        
        # Remove extra spaces and format specific ports
        formatted = port_name.replace(" : ", ":")
        formatted = formatted.replace("TileControl:", "Ctrl:")
        formatted = formatted.replace("TileControl :", "Ctrl:")
        
        return formatted

    def _get_outgoing_connections(self, tile_id):
        """Get outgoing connections from a tile"""
        connections = []
        
        # Get tiles data from the metadata
        if hasattr(self, '_original_md') and 'tiles' in self._original_md:
            tiles_data = self._original_md['tiles']
        else:
            tiles_data = self._md.get('tiles', {})
        
        # Get connections data
        if hasattr(self, '_original_md') and 'connections' in self._original_md:
            connections_data = self._original_md['connections']
        else:
            connections_data = self._md.get('connections', {})
        
        for conn_name, conn_data in connections_data.items():
            source_tile = conn_data.get('source', {}).get('tile')
            
            # Match by tile_id (coordinate format like "(0, 0)")
            if source_tile == tile_id:
                conn_type = conn_data.get('type', 'unknown')
                src_port = conn_data.get('source', {}).get('port', 'unknown')
                dst_tile = conn_data.get('destination', {}).get('tile', 'unknown')
                dst_port = conn_data.get('destination', {}).get('port', 'unknown')
                
                # print(f"DEBUG: Found {conn_type} connection: {src_port} -> {dst_tile}:{dst_port}")
                
                # Get destination tile location from tiles section
                dst_tile_data = tiles_data.get(dst_tile, {})
                dst_location = dst_tile_data.get('location', [])
                if dst_location and len(dst_location) >= 2:
                    dst_loc_str = f"{dst_location[0]}, {dst_location[1]}"
                else:
                    dst_loc_str = dst_tile
                
                flow_info = f"flow: local {self._format_port_name(src_port)}→({dst_loc_str}) {self._format_port_name(dst_port)}"
                # print(f"DEBUG: Adding flow_info: {flow_info}")
                
                connections.append(f"{conn_type}")
                connections.append(flow_info)
        
        return connections
    
    def _get_incoming_connections(self, tile_id):
        """Get incoming connections to a tile"""
        connections = []
        
        # Get tiles data from the metadata
        if hasattr(self, '_original_md') and 'tiles' in self._original_md:
            tiles_data = self._original_md['tiles']
        else:
            tiles_data = self._md.get('tiles', {})
        
        # Get connections data
        if hasattr(self, '_original_md') and 'connections' in self._original_md:
            connections_data = self._original_md['connections']
        else:
            connections_data = self._md.get('connections', {})
        
        for conn_name, conn_data in connections_data.items():
            dest_tile = conn_data.get('destination', {}).get('tile')
            
            # Match by tile_id (coordinate format like "(0, 0)")
            if dest_tile == tile_id:
                conn_type = conn_data.get('type', 'unknown')
                src_tile = conn_data.get('source', {}).get('tile', 'unknown')
                src_port = conn_data.get('source', {}).get('port', 'unknown')
                dst_port = conn_data.get('destination', {}).get('port', 'unknown')
                
                # Get source tile location from tiles section
                src_tile_data = tiles_data.get(src_tile, {})
                src_location = src_tile_data.get('location', [])
                if src_location and len(src_location) >= 2:
                    src_loc_str = f"{src_location[0]}, {src_location[1]}"
                else:
                    src_loc_str = src_tile
                
                connections.append(f"{conn_type}")
                connections.append(f"flow: local {self._format_port_name(dst_port)}←({src_loc_str}) {self._format_port_name(src_port)}")
        return connections
    
    def _get_tile_location(self, tile_id):
        """Get location of a tile by its ID"""
        tile_data = self._tile_metadata.get(tile_id, {})
        return tile_data.get('location', None)

    def _generate_text_report(self, filename: str = None) -> None:
        """Generate a comprehensive text report with all tile information"""
        if filename is None:
            name = self._appname + '_report.txt'
        else:
            name = filename.replace('.svg', '_report.txt')
            
        with open(name, 'w') as f:
            f.write(f"AIE Design Report: {self._appname}\n")
            f.write("=" * 50 + "\n\n")
            
            # Use the original metadata that was passed in
            if hasattr(self, '_original_md'):
                tiles_data = self._original_md.get('tiles', {})
            else:
                tiles_data = self._md.get('tiles', {})
            
            # Process all tiles
            for tile_name, tile_data in tiles_data.items():
                tile_type = tile_data.get('type', 'UNKNOWN')
                location = tile_data.get('location', [0, 0])
                f.write(f"Tile: {tile_data.get('name', tile_name)} ({location[0]}, {location[1]}) - {tile_type}\n")
                f.write("-" * 40 + "\n")
                
                if tile_type == 'COMPUTE':
                    # Kernel info
                    if 'kernel' in tile_data:
                        kernel_info = tile_data['kernel']
                        f.write("KERNEL [name]\n")
                        f.write(f"  {kernel_info.get('name', 'unknown')}\n\n")
                    
                    # Memory info - compute tiles use L1_memory
                    if 'L1_memory' in tile_data:
                        mem_info = tile_data['L1_memory']
                        f.write("MEMORY [name|size|dtype|addr|bank]\n")
                        if 'buffers' in mem_info:
                            for buf_info in mem_info['buffers']:  # buffers is a list
                                name = buf_info.get('name', 'unknown')
                                size = buf_info.get('size', 0)
                                dtype = buf_info.get('type', 'unknown')
                                addr = buf_info.get('address', 0)
                                bank = buf_info.get('mem_bank', 0)
                                f.write(f"  {name} | {size} | {dtype} | {addr} | {bank}\n")
                        f.write("\n")
                
                elif tile_type == 'MEM':
                    # Memory tile info
                    if 'L2_memory' in tile_data:
                        mem_info = tile_data['L2_memory']
                        total_size = mem_info.get('total_size', 0)
                        f.write(f"L2 Memory: {total_size//1024}KB\n")
                        
                        if 'buffers' in mem_info:
                            f.write("MEMORY [name|size|dtype|addr|bank]\n")
                            for buf_info in mem_info['buffers']:  # buffers is a list
                                name = buf_info.get('name', 'unknown')
                                size = buf_info.get('size', 0)
                                dtype = buf_info.get('type', 'unknown')
                                addr = buf_info.get('address', 0)
                                bank = buf_info.get('mem_bank', 0)
                                f.write(f"  {name} | {size} | {dtype} | {addr} | {bank}\n")
                            f.write("\n")
                
                # Locks
                if 'locks' in tile_data and tile_data['locks']:
                    f.write("LOCK [name|id|init]\n")
                    for lock in tile_data['locks']:
                        lock_name = lock.get('name', 'Unknown')
                        lock_id = lock.get('id', 0)
                        lock_init = lock.get('init', 0)
                        f.write(f"  {lock_name} | {lock_id} | {lock_init}\n")
                    f.write("\n")
                
                # Connections - use the actual tile name instead of coordinate format
                outgoing = self._get_outgoing_connections(tile_name)
                incoming = self._get_incoming_connections(tile_name)
                
                if outgoing:
                    f.write("FLOW OUT [type|direction]\n")
                    for conn in outgoing:
                        f.write(f"  {conn}\n")
                    f.write("\n")
                
                if incoming:
                    f.write("FLOW IN [type|direction]\n")
                    for conn in incoming:
                        f.write(f"  {conn}\n")
                    f.write("\n")
                
                f.write("\n")
        
        print(f"Text report saved to: {name}")

    def save(self, filename: str = None) -> None:
        """saves animation to a file"""
        if filename is None:
            name = self._appname + '.svg'
        else:
            name = filename
            
        # Generate text report
        self._generate_text_report(name)
            
        # Use the correct generation method based on the SVG type
        if hasattr(self._col_svg, 'generate_svg_image'):
            # RyzenAiArray uses generate_svg_image
            self._col_svg.generate_svg_image(filename=name)
        else:
            # RyzenAiColumn uses generate_image
            self._col_svg.generate_image(filename=name)

    @property
    def show(self) -> None:
        import tempfile
        from pathlib import Path
        tmp_dir = tempfile.mkdtemp()
        _t = Path(tmp_dir) / f"_{self._appname}_viz.svg"
        
        # Use the correct generation method based on the SVG type
        if hasattr(self._col_svg, 'generate_svg_image'):
            # RyzenAiArray uses generate_svg_image
            self._col_svg.generate_svg_image(filename=_t)
        else:
            # RyzenAiColumn uses generate_image
            self._col_svg.generate_image(filename=_t)
            
        try:
            from IPython.core.display import SVG
            display(SVG(filename=_t))
        except ImportError:
            print(f"Generated visualization: {_t}")



