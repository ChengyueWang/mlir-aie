#!/usr/bin/env python3
"""
AIE to AppViz Pipeline

This tool automates the process of:
1. Applying necessary MLIR passes to AIE designs
2. Translating to AppViz-compatible JSON format using Python parser
3. Generating visualizations using AppViz

Usage:
    python3 aie_mlir_to_visual.py input.mlir [options]
    python3 aie_mlir_to_visual.py --help
"""

import argparse
import subprocess
import json
import sys
import os
import tempfile
from pathlib import Path

# Add the visual tools to the path
script_dir = Path(__file__).parent
visual_dir = script_dir / "visual_tool"
if visual_dir.exists():
    sys.path.insert(0, str(script_dir))

class AIEToAppVizPipeline:
    def __init__(self, mlir_opt_path="aie-opt"):
        self.mlir_opt_path = mlir_opt_path
        
    def find_mlir_tools(self):
        """Try to find MLIR tools in common locations"""
        # Common paths where MLIR tools might be installed
        common_paths = [
            "/scratch/chengyue/mlir-aie/build/bin",
            "/scratch/chengyue/mlir-aie/install/bin", 
            "/usr/local/bin",
            "/opt/mlir/bin",
            os.path.expanduser("~/mlir/bin")
        ]
        
        for path in common_paths:
            opt_path = os.path.join(path, "aie-opt")
            
            if os.path.exists(opt_path):
                self.mlir_opt_path = opt_path
                print(f"✓ Found AIE tools in: {path}")
                return True
        
        # Try to find in PATH
        try:
            subprocess.run([self.mlir_opt_path, "--help"], 
                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=True)
            print("✓ Found AIE tools in PATH")
            return True
        except (subprocess.CalledProcessError, FileNotFoundError):
            pass
            
        return False
    
    def check_if_processed(self, input_mlir):
        """
        Check if the MLIR file has already been processed with flow passes
        
        Args:
            input_mlir: Path to input MLIR file
            
        Returns:
            True if the file appears to have flows already processed
        """
        try:
            with open(input_mlir, 'r') as f:
                content = f.read()
                # Look for indicators that flows have been processed
                # These patterns suggest the file has been through flow passes
                flow_indicators = [
                    "aie.flow(",  # Flow operations
                    "aie.packet_flow(",  # Packet flow operations
                    "aie.connect<",  # Connection operations
                    "aie.wire(",  # Wire operations
                ]
                
                for indicator in flow_indicators:
                    if indicator in content:
                        return True
                        
                return False
        except Exception:
            # If we can't read the file, assume it needs processing
            return False
    
    def apply_aie_passes(self, input_mlir, output_mlir=None, extra_passes=None, force_passes=False):
        """
        Apply necessary passes to prepare AIE MLIR for flow analysis
        
        Args:
            input_mlir: Path to input MLIR file
            output_mlir: Path to output MLIR file (auto-generated if None)
            extra_passes: Additional passes to apply
            force_passes: Force application of passes even if file appears processed
        
        Returns:
            Path to processed MLIR file
        """
        # Check if the file has already been processed
        if not force_passes and self.check_if_processed(input_mlir):
            print("🔍 Input MLIR appears to already have flows processed")
            
            # If only applying extra passes, or no passes needed
            if not extra_passes:
                print("✓ Skipping standard passes - using input file directly")
                return input_mlir
            else:
                print("🔄 Applying only extra passes...")
                standard_passes = []
        else:
            print("🔄 Applying standard AIE flow passes...")
            # Standard AIE passes for flow preparation
            standard_passes = [
                "--aie-canonicalize-device",
                "--aie-create-pathfinder-flows", 
                "--aie-find-flows"
            ]
        
        if output_mlir is None:
            # Create temporary file for processed MLIR
            fd, output_mlir = tempfile.mkstemp(suffix=".mlir", prefix="processed_")
            os.close(fd)
        
        # Add any extra passes
        if extra_passes:
            standard_passes.extend(extra_passes)
        
        # If no passes to apply, just copy the file
        if not standard_passes:
            if input_mlir != output_mlir:
                import shutil
                shutil.copy2(input_mlir, output_mlir)
                print(f"✓ Copied input file to: {output_mlir}")
            return output_mlir
        
        cmd = [
            self.mlir_opt_path,
            input_mlir
        ] + standard_passes + [
            "-o", output_mlir
        ]
        
        print(f"🔄 Applying MLIR passes...")
        print(f"   Command: {' '.join(cmd)}")
        
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, check=True)
            print(f"✓ Successfully applied passes, output: {output_mlir}")
            return output_mlir
        except subprocess.CalledProcessError as e:
            print(f"✗ Error applying MLIR passes:")
            print(f"   stdout: {e.stdout}")
            print(f"   stderr: {e.stderr}")
            raise
    
    def translate_to_appviz(self, processed_mlir, output_json=None):
        """
        Translate processed MLIR to AppViz JSON format using Python parser
        
        Args:
            processed_mlir: Path to processed MLIR file
            output_json: Path to output JSON file (auto-generated if None)
        
        Returns:
            Path to AppViz JSON file
        """
        if output_json is None:
            # Generate output filename based on input
            base_name = os.path.splitext(os.path.basename(processed_mlir))[0]
            output_json = f"{base_name}_appviz.json"
        
        print(f"🔄 Translating to AppViz format using Python parser...")
        
        try:
            # Use our Python MLIR parser
            script_dir = Path(__file__).parent
            mlir_parser_path = script_dir / "mlir_to_json.py"
            
            if not mlir_parser_path.exists():
                raise FileNotFoundError(f"Python MLIR parser not found at: {mlir_parser_path}")
            
            cmd = [
                "python3",
                str(mlir_parser_path),
                processed_mlir,
                "-o", output_json
            ]
            
            print(f"   Command: {' '.join(cmd)}")
            result = subprocess.run(cmd, capture_output=True, text=True, check=True)
            print(f"✓ Successfully translated to AppViz format: {output_json}")
            return output_json
                
        except subprocess.CalledProcessError as e:
            print(f"✗ Error translating to AppViz format:")
            print(f"   stdout: {e.stdout}")
            print(f"   stderr: {e.stderr}")
            raise
        except FileNotFoundError as e:
            print(f"✗ Error: {e}")
            raise
    
    def create_visualization(self, appviz_json, output_svg=None, show_display=False):
        """
        Create visualization using AppViz
        
        Args:
            appviz_json: Path to AppViz JSON metadata file
            output_svg: Path to output SVG file (auto-generated if None)
            show_display: Whether to display the visualization (for Jupyter)
        
        Returns:
            Path to SVG file and AppViz instance
        """
        try:
            from visual_tool.appviz import AppViz
        except ImportError as e:
            print("✗ AppViz not available. This is expected outside of Jupyter environments.")
            print(f"   Import error: {e}")
            print("   You can still use the generated JSON file manually with:")
            print(f"   python3 -c \"from visual_tool.appviz import AppViz; AppViz('{appviz_json}').save('output.svg')\"")
            print("   (Make sure IPython/Jupyter is installed if you need AppViz)")
            return None, None
        
        if output_svg is None:
            # Generate output filename based on input
            base_name = os.path.splitext(os.path.basename(appviz_json))[0]
            output_svg = f"{base_name}_visualization.svg"
        
        print(f"🔄 Creating visualization with AppViz...")
        
        try:
            # Load the JSON metadata
            app_viz = AppViz(appviz_json)
            
            # Save as SVG
            app_viz.save(output_svg)
            print(f"✓ Successfully created visualization: {output_svg}")
            
            # Display info about the visualization
            with open(appviz_json, 'r') as f:
                metadata = json.load(f)
            
            print(f"📊 Visualization Summary:")
            print(f"   Application: {metadata.get('application', 'Unknown')}")
            
            # Handle both old and new formats
            if 'tiles' in metadata:
                print(f"   Tiles: {len(metadata.get('tiles', {}))}")
                tile_types = {}
                for tile in metadata.get('tiles', {}).values():
                    ttype = tile.get('type', 'Unknown')
                    tile_types[ttype] = tile_types.get(ttype, 0) + 1
                print(f"   Tile Types: {dict(tile_types)}")
            else:
                print(f"   Kernels: {len(metadata.get('kernels', {}))}")
                kernel_types = {}
                for kernel in metadata.get('kernels', {}).values():
                    ktype = kernel.get('type', 'Unknown')
                    kernel_types[ktype] = kernel_types.get(ktype, 0) + 1
                print(f"   Tile Types: {dict(kernel_types)}")
            
            print(f"   Connections: {len(metadata.get('connections', {}))}")
            
            # Show display if requested and in Jupyter
            if show_display:
                try:
                    app_viz.show()
                except:
                    print("   (Could not display inline - not in Jupyter environment)")
            
            return output_svg, app_viz
            
        except Exception as e:
            print(f"✗ Error creating visualization: {e}")
            return None, None
    
    def run_full_pipeline(self, input_mlir, output_dir=None, 
                         keep_intermediate=False, extra_passes=None,
                         show_display=False, force_passes=False):
        """
        Run the complete AIE to AppViz pipeline
        
        Args:
            input_mlir: Path to input AIE MLIR file
            output_dir: Directory for output files (current dir if None)
            keep_intermediate: Whether to keep intermediate files
            extra_passes: Additional MLIR passes to apply
            show_display: Whether to display visualization
            force_passes: Force application of standard passes even if file appears processed
        
        Returns:
            Dictionary with paths to generated files
        """
        print("🚀 Starting AIE to AppViz Pipeline")
        print("=" * 50)
        
        if not os.path.exists(input_mlir):
            raise FileNotFoundError(f"Input MLIR file not found: {input_mlir}")
        
        if not self.find_mlir_tools():
            raise RuntimeError("Could not find AIE tools (aie-opt)")
        
        # Setup output directory
        if output_dir is None:
            output_dir = os.path.dirname(input_mlir) or "."
        os.makedirs(output_dir, exist_ok=True)
        
        # Generate output filenames
        base_name = os.path.splitext(os.path.basename(input_mlir))[0]
        processed_mlir = os.path.join(output_dir, f"{base_name}_processed.mlir")
        appviz_json = os.path.join(output_dir, f"{base_name}_appviz.json")
        output_svg = os.path.join(output_dir, f"{base_name}_visualization.svg")
        
        results = {
            'input_mlir': input_mlir,
            'processed_mlir': None,
            'appviz_json': None,
            'output_svg': None,
            'success': False
        }
        
        try:
            # Step 1: Apply MLIR passes
            processed_mlir = self.apply_aie_passes(
                input_mlir, processed_mlir, extra_passes, force_passes
            )
            results['processed_mlir'] = processed_mlir
            
            # Step 2: Translate to AppViz format
            appviz_json = self.translate_to_appviz(processed_mlir, appviz_json)
            results['appviz_json'] = appviz_json
            
            # Step 3: Create visualization
            output_svg, app_viz = self.create_visualization(
                appviz_json, output_svg, show_display
            )
            results['output_svg'] = output_svg
            results['app_viz'] = app_viz
            
            results['success'] = True
            
            print("\n🎉 Pipeline completed successfully!")
            print("=" * 50)
            print(f"📁 Output files:")
            print(f"   Processed MLIR: {processed_mlir}")
            print(f"   AppViz JSON:    {appviz_json}")
            if output_svg:
                print(f"   Visualization:  {output_svg}")
            
        except Exception as e:
            print(f"\n💥 Pipeline failed: {e}")
            results['error'] = str(e)   
        return results

def main():
    parser = argparse.ArgumentParser(
        description="Convert AIE MLIR designs to AppViz visualizations",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Basic usage
  python3 aie_mlir_to_visual.py design.mlir
  
  # Specify output directory
  python3 aie_mlir_to_visual.py design.mlir --output-dir ./visualizations
  
  # Keep intermediate files and add extra passes
  python3 aie_mlir_to_visual.py design.mlir --keep-intermediate --extra-passes "--aie-assign-buffer-addresses"
  
  # Specify MLIR tool paths
  python3 aie_mlir_to_visual.py design.mlir --aie-opt /path/to/aie-opt
        """
    )
    
    parser.add_argument("input_mlir", help="Input AIE MLIR file")
    parser.add_argument("--output-dir", "-o", help="Output directory for generated files")
    parser.add_argument("--keep-intermediate", "-k", action="store_true", 
                       help="Keep intermediate processed MLIR file")
    parser.add_argument("--extra-passes", "-p", action="append",
                       help="Additional MLIR passes to apply (can be used multiple times)")
    parser.add_argument("--show-display", "-d", action="store_true",
                       help="Try to display visualization (for Jupyter environments)")
    parser.add_argument("--force-passes", "-f", action="store_true",
                       help="Force application of standard passes even if input appears already processed")
    parser.add_argument("--aie-opt", help="Path to aie-opt executable")
    
    args = parser.parse_args()
    
    # Create pipeline instance
    pipeline = AIEToAppVizPipeline(
        mlir_opt_path=args.aie_opt or "aie-opt"
    )
    
    # Run the pipeline
    try:
        results = pipeline.run_full_pipeline(
            input_mlir=args.input_mlir,
            output_dir=args.output_dir,
            keep_intermediate=args.keep_intermediate,
            extra_passes=args.extra_passes,
            show_display=args.show_display,
            force_passes=args.force_passes
        )
        
        if results['success']:
            sys.exit(0)
        else:
            sys.exit(1)
            
    except Exception as e:
        print(f"💥 Fatal error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
