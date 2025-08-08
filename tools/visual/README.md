# Visual Tool for AIE/MLIR-AIE Designs

This directory contains tools and scripts for visualizing and analyzing AIE/MLIR-AIE designs. It supports converting MLIR files to JSON, generating SVG visualizations, and producing detailed text reports for debugging and documentation.

## Directory Structure

- `aie_mlir_to_visual.py` / `mlir_to_json.py`: Scripts to convert MLIR files to JSON format for visualization.
- `test_appviz.py`: Main entry point for generating SVG and text reports from JSON design files.
- `visual_tool/`: Core visualization engine and utilities.
- `examples/`: Example JSON files for testing and demonstration.
- `tests/`: Collection of test cases and MLIR/JSON files for regression and validation.

## Typical Workflow

1. **Convert MLIR to JSON** (if starting from MLIR):
   ```sh
   python mlir_to_json.py <input.mlir>
   # Produces <input>.json
   ```
2. **Visualize JSON**:
   ```sh
   python test_appviz.py <input.json>
   # Produces <input>_test_output.svg and <input>_test_output_report.txt
   ```

## Batch Testing

A helper script `test.sh` is provided to run all examples under `tests/`, placing outputs in a dedicated `output/` subdirectory for each test case.

   ```sh
   ./test.sh
   ```

## Output Files

- `<name>_test_output.svg`: SVG visualization of the design
- `<name>_test_output_report.txt`: Detailed text report

## Requirements
- Python 3.7+
- No external dependencies required for basic usage

## Example

```sh
cd visual
python mlir_to_json.py tests/memcpy_mlir/input.mlir
python test_appviz.py tests/memcpy_mlir/input.json
```

## License
See the top-level repository for license information.
