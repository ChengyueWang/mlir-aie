# make run use_chess=1 

env use_placed=1 use_chess=1  make run
make trace


# utils/parse_trace.py --input trace.txt --mlir build/aie_trace.mlir --output trace_4b.json

# 	${srcdir}/../../../utils/parse_trace.py --input trace.txt --mlir ${trace_mlir_target} --output trace_mm.json

# utils/get_trace_summary.py --input trace_4b.json


# aie-opt --aie-objectFifo-stateful-transform aie_128x128x128_64x64x64.mlir -o a.mlir

# aie-opt --aie-assign-bd-ids aie_128x128x128_64x64x64.mlir -o a.mlir
# aie-opt --aie-lower-cascade-flows aie_128x128x128_64x64x64.mlir -o a.mlir
# aie-opt --aie-lower-broadcast-packet aie_128x128x128_64x64x64.mlir -o a.mlir
# aie-opt --aie-lower-multicast aie_128x128x128_64x64x64.mlir -o a.mlir
# aie-opt --aie-assign-tile-controller-ids aie_128x128x128_64x64x64.mlir -o a.mlir
# aie-opt --aie-generate-column-control-overlay aie_128x128x128_64x64x64.mlir -o a.mlir
# aie-opt --aie-assign-buffer-addresses aie_128x128x128_64x64x64.mlir -o a.mlir

