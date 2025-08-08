#!/usr/bin/env python3
"""
MLIR to JSON converter for AIE visualization
Converts AIE MLIR files to the tile-based JSON format expected by the visualization system
"""

import re
import json
import sys
import argparse
from typing import Dict, List, Any, Optional, Tuple


class MLIRParser:
    def __init__(self):
        self.tiles = {}
        self.connections = {}
        self.buffers = {}
        self.locks = {}
        self.flows = {}
        self.packet_flows = {}
        
    def parse_mlir_file(self, file_path: str) -> Dict[str, Any]:
        """Parse MLIR file and extract AIE structure"""
        with open(file_path, 'r') as f:
            content = f.read()
            
        # Parse tiles
        self._parse_tiles(content)
        
        # Parse buffers
        self._parse_buffers(content)
        
        # Parse locks
        self._parse_locks(content)
        
        # Parse flows and connections
        self._parse_flows(content)
        self._parse_packet_flows(content)
        
        # Build the JSON structure
        return self._build_json_structure()
    
    def _parse_tiles(self, content: str):
        """Parse aie.tile declarations"""
        # Pattern for tile declarations: %tile_name = aie.tile(col, row) [optional attributes]
        tile_pattern = r'%([a-zA-Z_0-9]+)\s*=\s*aie\.tile\((\d+),\s*(\d+)\)\s*(\{[^}]*\})?'
        
        for match in re.finditer(tile_pattern, content):
            tile_name = match.group(1)
            col = int(match.group(2))
            row = int(match.group(3))
            attributes = match.group(4) if match.group(4) else "{}"
            
            # Determine tile type based on row
            if row == 0:
                tile_type = "SHIM"
            elif row == 1:
                tile_type = "MEM"
            else:
                tile_type = "COMPUTE"
            
            # Parse controller_id if present
            controller_id = {"pkt_id": 0}
            if "controller_id" in attributes:
                controller_match = re.search(r'pkt_id\s*=\s*(\d+)', attributes)
                if controller_match:
                    controller_id["pkt_id"] = int(controller_match.group(1))
            
            self.tiles[tile_name] = {
                "tile_id": f"({col}, {row})",
                "name": tile_name,
                "type": tile_type,
                "location": [col, row],
                "controller_id": controller_id
            }
            
            # Initialize memory and lock sections
            if tile_type == "COMPUTE":
                self.tiles[tile_name]["kernel"] = {
                    "name": f"kernel_{col}_{row}",
                    "function": ""
                }
                self.tiles[tile_name]["L1_memory"] = {
                    "total_size": 32768,  # Default L1 size
                    "buffers": []
                }
                self.tiles[tile_name]["locks"] = []
            elif tile_type == "MEM":
                self.tiles[tile_name]["L2_memory"] = {
                    "total_size": 262144,  # Default L2 size
                    "buffers": []
                }
                self.tiles[tile_name]["locks"] = []
            elif tile_type == "SHIM":
                self.tiles[tile_name]["locks"] = []
    
    def _parse_buffers(self, content: str):
        """Parse aie.buffer declarations"""
        # Pattern: %buffer_name = aie.buffer(%tile) {attributes} : memref<size x type>
        buffer_pattern = r'%([a-zA-Z_0-9]+)\s*=\s*aie\.buffer\((%[a-zA-Z_0-9]+)\)\s*\{([^}]*)\}\s*:\s*memref<([^>]+)>'
        
        for match in re.finditer(buffer_pattern, content):
            buffer_name = match.group(1)
            tile_ref = match.group(2)
            attributes = match.group(3)
            memref_type = match.group(4)
            
            # Parse attributes
            address = 0
            mem_bank = 0
            sym_name = buffer_name
            
            address_match = re.search(r'address\s*=\s*(\d+)', attributes)
            if address_match:
                address = int(address_match.group(1))
                
            bank_match = re.search(r'mem_bank\s*=\s*(\d+)', attributes)
            if bank_match:
                mem_bank = int(bank_match.group(1))
                
            sym_match = re.search(r'sym_name\s*=\s*"([^"]*)"', attributes)
            if sym_match:
                sym_name = sym_match.group(1)
            
            # Parse memref type (e.g., "1024xi32" -> size=1024, type="i32")
            type_match = re.match(r'(\d+)x([a-zA-Z0-9]+)', memref_type)
            if type_match:
                size = int(type_match.group(1))
                dtype = type_match.group(2)
            else:
                size = 0
                dtype = "unknown"
            
            buffer_info = {
                "name": sym_name,
                "size": size,
                "type": f"memref<{memref_type}>",
                "address": address,
                "mem_bank": mem_bank
            }
            
            # Find the tile this buffer belongs to
            for tile_name, tile_data in self.tiles.items():
                if tile_ref == f"%{tile_name}":
                    if tile_data["type"] == "COMPUTE":
                        tile_data["L1_memory"]["buffers"].append(buffer_info)
                    elif tile_data["type"] == "MEM":
                        tile_data["L2_memory"]["buffers"].append(buffer_info)
                    break
    
    def _parse_locks(self, content: str):
        """Parse aie.lock declarations"""
        # Pattern: %lock_name = aie.lock(%tile, id) {attributes}
        lock_pattern = r'%([a-zA-Z_0-9]+)\s*=\s*aie\.lock\((%[a-zA-Z_0-9]+),\s*(\d+)\)\s*\{([^}]*)\}'
        
        for match in re.finditer(lock_pattern, content):
            lock_name = match.group(1)
            tile_ref = match.group(2)
            lock_id = int(match.group(3))
            attributes = match.group(4)
            
            # Parse attributes
            init_value = 0
            sym_name = lock_name
            
            init_match = re.search(r'init\s*=\s*(\d+)', attributes)
            if init_match:
                init_value = int(init_match.group(1))
                
            sym_match = re.search(r'sym_name\s*=\s*"([^"]*)"', attributes)
            if sym_match:
                sym_name = sym_match.group(1)
            
            lock_info = {
                "name": sym_name,
                "id": lock_id,
                "init": init_value
            }
            
            # Find the tile this lock belongs to
            for tile_name, tile_data in self.tiles.items():
                if tile_ref == f"%{tile_name}":
                    tile_data["locks"].append(lock_info)
                    break
    
    def _parse_flows(self, content: str):
        """Parse aie.flow declarations"""
        # Pattern: aie.flow(%src_tile, direction : port, %dst_tile, direction : port)
        flow_pattern = r'aie\.flow\((%[a-zA-Z_0-9]+),\s*([a-zA-Z]+)\s*:\s*(\d+),\s*(%[a-zA-Z_0-9]+),\s*([a-zA-Z]+)\s*:\s*(\d+)\)'
        
        for match in re.finditer(flow_pattern, content):
            src_tile_ref = match.group(1)
            src_direction = match.group(2)
            src_port = int(match.group(3))
            dst_tile_ref = match.group(4)
            dst_direction = match.group(5)
            dst_port = int(match.group(6))
            
            # Find tile names
            src_tile = self._find_tile_by_ref(src_tile_ref)
            dst_tile = self._find_tile_by_ref(dst_tile_ref)
            
            if src_tile and dst_tile:
                connection_id = f"flow_{len(self.connections)}"
                self.connections[connection_id] = {
                    "type": "stream",
                    "source": {
                        "tile": src_tile,
                        "port": f"{src_direction}:{src_port}"
                    },
                    "destination": {
                        "tile": dst_tile,
                        "port": f"{dst_direction}:{dst_port}"
                    }
                }
    
    def _parse_packet_flows(self, content: str):
        """Parse aie.packet_flow declarations"""
        # Pattern: aie.packet_flow(id) { aie.packet_source<%tile, port> aie.packet_dest<%tile, port> }
        packet_flow_pattern = r'aie\.packet_flow\((\d+)\)\s*\{([^}]+)\}'
        
        for match in re.finditer(packet_flow_pattern, content):
            flow_id = int(match.group(1))
            flow_content = match.group(2)
            
            # Parse source
            src_match = re.search(r'aie\.packet_source<(%[a-zA-Z_0-9]+),\s*([^>]+)>', flow_content)
            # Parse destination  
            dst_match = re.search(r'aie\.packet_dest<(%[a-zA-Z_0-9]+),\s*([^>]+)>', flow_content)
            
            if src_match and dst_match:
                src_tile_ref = src_match.group(1)
                src_port = src_match.group(2).strip()
                dst_tile_ref = dst_match.group(1)
                dst_port = dst_match.group(2).strip()
                
                # Find tile names
                src_tile = self._find_tile_by_ref(src_tile_ref)
                dst_tile = self._find_tile_by_ref(dst_tile_ref)
                
                if src_tile and dst_tile:
                    connection_id = f"packet_flow_{flow_id}"
                    self.connections[connection_id] = {
                        "type": "packet",
                        "source": {
                            "tile": src_tile,
                            "port": src_port
                        },
                        "destination": {
                            "tile": dst_tile,
                            "port": dst_port
                        }
                    }
    
    def _find_tile_by_ref(self, tile_ref: str) -> Optional[str]:
        """Find tile name by reference (e.g., %shim_noc_tile_0_0 -> shim_noc_tile_0_0)"""
        tile_name = tile_ref.lstrip('%')
        if tile_name in self.tiles:
            return self.tiles[tile_name]["tile_id"]
        return None
    
    def _build_json_structure(self) -> Dict[str, Any]:
        """Build the final JSON structure"""
        # Convert tiles to use tile_id as key
        tiles_by_id = {}
        for tile_name, tile_data in self.tiles.items():
            tile_id = tile_data["tile_id"]
            tiles_by_id[tile_id] = tile_data.copy()
            # Remove the redundant tile_id field from the data
            if "tile_id" in tiles_by_id[tile_id]:
                del tiles_by_id[tile_id]["tile_id"]
        
        return {
            "application": "aie_design",
            "device": "npu2",
            "tiles": tiles_by_id,
            "connections": self.connections
        }


def main():
    parser = argparse.ArgumentParser(description='Convert AIE MLIR to visualization JSON format')
    parser.add_argument('input_file', help='Input MLIR file path')
    parser.add_argument('-o', '--output', help='Output JSON file path (default: input_file.json)')
    
    args = parser.parse_args()
    
    # Determine output file path
    if args.output:
        output_file = args.output
    else:
        # Replace .mlir extension with .json
        if args.input_file.endswith('.mlir'):
            output_file = args.input_file[:-5] + '.json'
        else:
            output_file = args.input_file + '.json'
    
    try:
        # Parse MLIR file
        parser = MLIRParser()
        json_data = parser.parse_mlir_file(args.input_file)
        
        # Write JSON output
        with open(output_file, 'w') as f:
            json.dump(json_data, f, indent=2)
        
        print(f"Successfully converted {args.input_file} to {output_file}")
        
        # Print summary
        tiles = json_data.get('tiles', {})
        connections = json_data.get('connections', {})
        
        print(f"Summary:")
        print(f"  Tiles: {len(tiles)}")
        for tile_id, tile_data in tiles.items():
            tile_type = tile_data.get('type', 'UNKNOWN')
            print(f"    {tile_id}: {tile_type}")
        print(f"  Connections: {len(connections)}")
        for conn_id, conn_data in connections.items():
            conn_type = conn_data.get('type', 'unknown')
            src = conn_data.get('source', {}).get('tile', 'unknown')
            dst = conn_data.get('destination', {}).get('tile', 'unknown')
            print(f"    {conn_id}: {conn_type} from {src} to {dst}")
            
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
