module {
  aie.device(npu1_1col) {
    %shim_noc_tile_0_0 = aie.tile(0, 0)
    %mem_tile_0_1 = aie.tile(0, 1)
    %tile_0_2 = aie.tile(0, 2)
    %tile_0_3 = aie.tile(0, 3)
    aie.objectfifo @in(%shim_noc_tile_0_0, {%mem_tile_0_1}, 1 : i32) : !aie.objectfifo<memref<36xi32>> 
    aie.objectfifo @in2(%mem_tile_0_1, {%tile_0_2}, 2 : i32) {repeat_count = 1 : i32} : !aie.objectfifo<memref<18xi32>> 
    aie.objectfifo @in3(%mem_tile_0_1, {%tile_0_3}, 2 : i32) {repeat_count = 1 : i32} : !aie.objectfifo<memref<18xi32>> 
    aie.objectfifo.link [@in] -> [@in2, @in3]([] [0, 18])
    aie.objectfifo @out2(%tile_0_2, {%mem_tile_0_1}, 2 : i32) : !aie.objectfifo<memref<18xi32>> 
    aie.objectfifo @out3(%tile_0_3, {%mem_tile_0_1}, 2 : i32) : !aie.objectfifo<memref<18xi32>> 
    aie.objectfifo @out(%mem_tile_0_1, {%shim_noc_tile_0_0}, 1 : i32) : !aie.objectfifo<memref<36xi32>> 
    aie.objectfifo.link [@out2, @out3] -> [@out]([0, 18] [])
    %core_0_2 = aie.core(%tile_0_2) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @out2(Produce, 1) : !aie.objectfifosubview<memref<18xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<18xi32>> -> memref<18xi32>
        %2 = aie.objectfifo.acquire @in2(Consume, 1) : !aie.objectfifosubview<memref<18xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<18xi32>> -> memref<18xi32>
        %c0_0 = arith.constant 0 : index
        %c18 = arith.constant 18 : index
        %c1_1 = arith.constant 1 : index
        scf.for %arg1 = %c0_0 to %c18 step %c1_1 {
          %4 = memref.load %3[%arg1] : memref<18xi32>
          %c1_i32 = arith.constant 1 : i32
          %5 = arith.addi %4, %c1_i32 : i32
          memref.store %5, %1[%arg1] : memref<18xi32>
        }
        aie.objectfifo.release @in2(Consume, 1)
        aie.objectfifo.release @out2(Produce, 1)
      }
      aie.end
    }
    %core_0_3 = aie.core(%tile_0_3) {
      %c0 = arith.constant 0 : index
      %c9223372036854775807 = arith.constant 9223372036854775807 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c9223372036854775807 step %c1 {
        %0 = aie.objectfifo.acquire @out3(Produce, 1) : !aie.objectfifosubview<memref<18xi32>>
        %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<18xi32>> -> memref<18xi32>
        %2 = aie.objectfifo.acquire @in3(Consume, 1) : !aie.objectfifosubview<memref<18xi32>>
        %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<18xi32>> -> memref<18xi32>
        %c0_0 = arith.constant 0 : index
        %c18 = arith.constant 18 : index
        %c1_1 = arith.constant 1 : index
        scf.for %arg1 = %c0_0 to %c18 step %c1_1 {
          %4 = memref.load %3[%arg1] : memref<18xi32>
          %c2_i32 = arith.constant 2 : i32
          %5 = arith.addi %4, %c2_i32 : i32
          memref.store %5, %1[%arg1] : memref<18xi32>
        }
        aie.objectfifo.release @in3(Consume, 1)
        aie.objectfifo.release @out3(Produce, 1)
      }
      aie.end
    }
    aiex.runtime_sequence @sequence(%arg0: memref<36xi32>, %arg1: memref<36xi32>, %arg2: memref<36xi32>) {
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 0][1, 1, 1, 36][0, 0, 0, 1]) {id = 1 : i64, metadata = @in} : memref<36xi32>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 0][1, 1, 1, 36][0, 0, 0, 1]) {id = 0 : i64, metadata = @out} : memref<36xi32>
      aiex.npu.dma_wait {symbol = @out}
    }
  }
}

