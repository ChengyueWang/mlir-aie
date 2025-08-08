    def _add_custom_text_to_if_tile(self, tile, tile_name, controller_id, lock_info):
        """Add custom text annotations to an interface tile in the dedicated text area"""
        # Position text in the dedicated text area that matches the outer container position
        text_area_x = tile.x + config.aie_container_offset_x + 5  # Match outer container + margin
        text_area_y = tile.y + config.aie_container_offset_y + config.aie_container_height + 8  # Right after container + margin
        
        # Get tile row/col from tile object
        tile_row = getattr(tile, 'row', 0)  # Interface tiles are typically row 0
        tile_col = getattr(tile, 'col', tile.index)
        tile_id = f"({tile_col}, {tile_row})"
        
        # Get connections for font size calculation
        outgoing_connections = self._get_outgoing_connections(tile_id)
        incoming_connections = self._get_incoming_connections(tile_id)
        
        # Determine font sizes based on content (same system as AIE tiles)
        header_font_size, content_font_size = self._get_font_sizes(tile, [], lock_info, outgoing_connections, incoming_connections)
        
        # Set line spacing proportional to font size
        line_spacing = header_font_size + 1  # Just 1px more than font size for tight but readable spacing
        
        custom_text = f"""
<g id="custom_if_annotations_{tile.index}">
    <!-- INTERFACE section -->
    <text x="{text_area_x}" y="{text_area_y + line_spacing}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        INTERFACE [controller]
    </text>"""
        
        # Add controller information
        y_offset = text_area_y + line_spacing
        if controller_id:
            y_offset += line_spacing
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        controller_{controller_id}
    </text>"""
        
        # Add LOCKS section
        if lock_info:
            y_offset += int(line_spacing * 1.5)
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        LOCKS [name|ID|init]
    </text>"""
            for i, lock_text in enumerate(lock_info):  # Show up to 3 locks
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
        
        # Add CONNECTIONS OUT section
        if outgoing_connections:
            y_offset += int(line_spacing * 1.5)
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        OUT CONNECTIONS [name|type|width|flow]
    </text>"""
            
            # Process connections with flow info grouping - interface tile pipe format
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
                
                # Parse and format connection info with pipes
                conn_details = conn_info.split(", ")
                name = conn_details[0].replace("_", " ") if len(conn_details) > 0 else "N/A"
                conn_type = conn_details[1][:12] if len(conn_details) > 1 else "N/A"
                width = conn_details[2] if len(conn_details) > 2 and conn_details[2] != '0' else "N/A"
                
                # Only add if we have valid connection data
                if name != "N/A" or conn_type != "N/A":
                    conn_count += 1
                    y_offset += line_spacing
                    formatted_conn = f"{name} | {conn_type} | {width} | {flow_info}"
                    custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
        
        # Add CONNECTIONS IN section  
        if incoming_connections:
            y_offset += int(line_spacing * 1.5)
            custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{header_font_size}" fill="black" font-weight="bold" font-family="Arial, Helvetica, sans-serif">
        IN CONNECTIONS [name|type|width|flow]
    </text>"""
            
            # Process connections with flow info grouping - interface tile pipe format
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
                
                # Parse and format connection info with pipes
                conn_details = conn_info.split(", ")
                name = conn_details[0].replace("_", " ") if len(conn_details) > 0 else "N/A"
                conn_type = conn_details[1][:12] if len(conn_details) > 1 else "N/A"
                width = conn_details[2] if len(conn_details) > 2 and conn_details[2] != '0' else "N/A"
                
                # Only add if we have valid connection data
                if name != "N/A" or conn_type != "N/A":
                    conn_count += 1
                    y_offset += line_spacing
                    formatted_conn = f"{name} | {conn_type} | {width} | {flow_info}"
                    custom_text += f"""
    <text x="{text_area_x}" y="{y_offset}" font-size="{content_font_size}" fill="black" font-family="Arial, Helvetica, sans-serif">
        {formatted_conn}
    </text>"""
        
        custom_text += "\n</g>"
        
        # Add to the tile's additional SVG content
        if not hasattr(tile, 'custom_annotations'):
            tile.custom_annotations = ""
        tile.custom_annotations += custom_text
