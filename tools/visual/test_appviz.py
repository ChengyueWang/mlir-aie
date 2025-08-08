#!/usr/bin/env python3

import sys
import os

# Add the visual_tool directory to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'visual_tool'))

from appviz import AppViz

def main():
    if len(sys.argv) != 2:
        print("Usage: python test_appviz.py <json_file>")
        sys.exit(1)
    
    json_file = sys.argv[1]
    
    try:
        # Create visualization
        viz = AppViz(json_file)
        
        # Save SVG and report
        output_name = json_file.replace('.json', '_test_output')
        viz.save(output_name + '.svg')
        
        print(f"✓ Visualization saved to: {output_name}.svg")
        print(f"✓ Report saved to: {output_name}_report.txt")
        
    except Exception as e:
        print(f"✗ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
