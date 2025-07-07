module {
  aie.device(npu2_1col) {
    %shim_noc_tile_0_0 = aie.tile(0, 0)
    %mem_tile_0_1 = aie.tile(0, 1)
    %tile_0_2 = aie.tile(0, 2)
    aie.objectfifo @in0(%shim_noc_tile_0_0, {%mem_tile_0_1}, 2 : i32) : !aie.objectfifo<memref<24xi32>> 
    aie.objectfifo @in1(%mem_tile_0_1, {%tile_0_2}, 2 : i32) : !aie.objectfifo<memref<8xi32>> 
    aie.objectfifo.link [@in0] -> [@in1]([] [])
    aie.objectfifo @out0(%mem_tile_0_1, {%shim_noc_tile_0_0}, 2 : i32) : !aie.objectfifo<memref<24xi32>> 
    aie.objectfifo @out1(%tile_0_2, {%mem_tile_0_1}, 2 : i32) : !aie.objectfifo<memref<8xi32>> 
    aie.objectfifo.link [@out1] -> [@out0]([] [])
    %core_0_2 = aie.core(%tile_0_2) {
      %c0 = arith.constant 0 : index
      %c6 = arith.constant 6 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c6 step %c1 {
        %0 = aie.objectfifo.acquire @in1(Consume, 1) : !aie.objectfifosubview<memref<8xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<8xi32>> -> memref<8xi32>
        %2 = aie.objectfifo.acquire @out1(Produce, 1) : !aie.objectfifosubview<memref<8xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<8xi32>> -> memref<8xi32>
        %c0_0 = arith.constant 0 : index
        %c8 = arith.constant 8 : index
        %c1_1 = arith.constant 1 : index
        scf.for %arg1 = %c0_0 to %c8 step %c1_1 {
          %4 = memref.load %1[%arg1] : memref<8xi32>
          %c1_i32 = arith.constant 1 : i32
          %5 = arith.addi %4, %c1_i32 : i32
          memref.store %5, %3[%arg1] : memref<8xi32>
        }
        aie.objectfifo.release @in1(Consume, 1)
        aie.objectfifo.release @out1(Produce, 1)
      }
      aie.end
    }
    aiex.runtime_sequence @sequence(%arg0: memref<48xi32>, %arg1: memref<48xi32>, %arg2: memref<48xi32>) {
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 0][1, 1, 1, 48][0, 0, 0, 1]) {id = 1 : i64, metadata = @in0} : memref<48xi32>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 0][1, 1, 1, 48][0, 0, 0, 1]) {id = 0 : i64, metadata = @out0} : memref<48xi32>
      aiex.npu.dma_wait {symbol = @out0}
    }
  }
}

