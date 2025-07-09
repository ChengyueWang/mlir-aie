module {
  aie.device(npu2) {
    memref.global "public" @out1_cons : memref<8xi32>
    memref.global "public" @out1 : memref<8xi32>
    memref.global "public" @out0_cons : memref<8xi32>
    memref.global "public" @out0 : memref<8xi32>
    memref.global "public" @in1_cons : memref<8xi32>
    memref.global "public" @in1 : memref<8xi32>
    memref.global "public" @in0_cons : memref<96000xi32>
    memref.global "public" @in0 : memref<96000xi32>
    %shim_noc_tile_0_0 = aie.tile(0, 0)
    %mem_tile_1_1 = aie.tile(1, 1)
    %in0_cons_buff_1 = aie.buffer(%mem_tile_1_1) {sym_name = "in0_cons_buff_1"} : memref<96000xi32> 
    %in0_cons_prod_lock_0 = aie.lock(%mem_tile_1_1, 0) {init = 2 : i32, sym_name = "in0_cons_prod_lock_0"}
    %in0_cons_cons_lock_0 = aie.lock(%mem_tile_1_1, 1) {init = 0 : i32, sym_name = "in0_cons_cons_lock_0"}
    %mem_tile_0_1 = aie.tile(0, 1)
    %out1_cons_buff_1 = aie.buffer(%mem_tile_0_1) {sym_name = "out1_cons_buff_1"} : memref<8xi32> 
    %out1_cons_prod_lock_0 = aie.lock(%mem_tile_0_1, 0) {init = 2 : i32, sym_name = "out1_cons_prod_lock_0"}
    %out1_cons_cons_lock_0 = aie.lock(%mem_tile_0_1, 1) {init = 0 : i32, sym_name = "out1_cons_cons_lock_0"}
    %out1_cons_buff_0 = aie.buffer(%mem_tile_0_1) {sym_name = "out1_cons_buff_0"} : memref<8xi32> 
    %in0_cons_buff_0 = aie.buffer(%mem_tile_0_1) {sym_name = "in0_cons_buff_0"} : memref<96000xi32> 
    %tile_0_2 = aie.tile(0, 2)
    %out1_buff_1 = aie.buffer(%tile_0_2) {sym_name = "out1_buff_1"} : memref<8xi32> 
    %out1_prod_lock_0 = aie.lock(%tile_0_2, 2) {init = 2 : i32, sym_name = "out1_prod_lock_0"}
    %out1_cons_lock_0 = aie.lock(%tile_0_2, 3) {init = 0 : i32, sym_name = "out1_cons_lock_0"}
    %out1_buff_0 = aie.buffer(%tile_0_2) {sym_name = "out1_buff_0"} : memref<8xi32> 
    %in1_cons_buff_1 = aie.buffer(%tile_0_2) {sym_name = "in1_cons_buff_1"} : memref<8xi32> 
    %in1_cons_prod_lock_0 = aie.lock(%tile_0_2, 0) {init = 2 : i32, sym_name = "in1_cons_prod_lock_0"}
    %in1_cons_cons_lock_0 = aie.lock(%tile_0_2, 1) {init = 0 : i32, sym_name = "in1_cons_cons_lock_0"}
    %out0_cons_prod_lock_0 = aie.lock(%shim_noc_tile_0_0, 2) {init = 1 : i32, sym_name = "out0_cons_prod_lock_0"}
    %out0_cons_cons_lock_0 = aie.lock(%shim_noc_tile_0_0, 3) {init = 0 : i32, sym_name = "out0_cons_cons_lock_0"}
    %in1_cons_buff_0 = aie.buffer(%tile_0_2) {sym_name = "in1_cons_buff_0"} : memref<8xi32> 
    aie.flow(%shim_noc_tile_0_0, DMA : 0, %mem_tile_0_1, DMA : 0)
    aie.flow(%mem_tile_0_1, DMA : 0, %tile_0_2, DMA : 0)
    aie.flow(%mem_tile_0_1, DMA : 1, %shim_noc_tile_0_0, DMA : 0)
    aie.flow(%tile_0_2, DMA : 0, %mem_tile_0_1, DMA : 1)
    %in0_prod_lock_0 = aie.lock(%shim_noc_tile_0_0, 0) {init = 1 : i32, sym_name = "in0_prod_lock_0"}
    %in0_cons_lock_0 = aie.lock(%shim_noc_tile_0_0, 1) {init = 0 : i32, sym_name = "in0_cons_lock_0"}
    %core_0_2 = aie.core(%tile_0_2) {
      aie.use_lock(%out1_prod_lock_0, AcquireGreaterEqual, 1)
      %c0 = arith.constant 0 : index
      %c12000 = arith.constant 12000 : index
      %c1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      scf.for %arg0 = %c0 to %c12000 step %c2 {
        aie.use_lock(%in1_cons_cons_lock_0, AcquireGreaterEqual, 1)
        %c0_0 = arith.constant 0 : index
        %c8 = arith.constant 8 : index
        %c1_1 = arith.constant 1 : index
        scf.for %arg1 = %c0_0 to %c8 step %c1_1 {
          %0 = memref.load %in1_cons_buff_0[%arg1] : memref<8xi32>
          %c1_i32 = arith.constant 1 : i32
          %1 = arith.addi %0, %c1_i32 : i32
          memref.store %1, %out1_buff_0[%arg1] : memref<8xi32>
        }
        aie.use_lock(%in1_cons_prod_lock_0, Release, 1)
        aie.use_lock(%in1_cons_cons_lock_0, AcquireGreaterEqual, 1)
        %c0_2 = arith.constant 0 : index
        %c8_3 = arith.constant 8 : index
        %c1_4 = arith.constant 1 : index
        scf.for %arg1 = %c0_2 to %c8_3 step %c1_4 {
          %0 = memref.load %in1_cons_buff_1[%arg1] : memref<8xi32>
          %c1_i32 = arith.constant 1 : i32
          %1 = arith.addi %0, %c1_i32 : i32
          memref.store %1, %out1_buff_0[%arg1] : memref<8xi32>
        }
        aie.use_lock(%in1_cons_prod_lock_0, Release, 1)
      }
      aie.use_lock(%out1_cons_lock_0, Release, 1)
      aie.end
    }
    aiex.runtime_sequence @sequence(%arg0: memref<96000xi32>, %arg1: memref<96000xi32>, %arg2: memref<96000xi32>) {
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 0][1, 1, 1, 96000][0, 0, 0, 1]) {id = 1 : i64, metadata = @in0} : memref<96000xi32>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 0][1, 1, 1, 8][0, 0, 0, 1]) {id = 0 : i64, metadata = @out0} : memref<96000xi32>
      aiex.npu.dma_wait {symbol = @out0}
    }
    aie.shim_dma_allocation @in0(MM2S, 0, 0)
    %memtile_dma_0_1 = aie.memtile_dma(%mem_tile_0_1) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%in0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_cons_buff_0 : memref<96000xi32>, 0, 96000)
      aie.use_lock(%in0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%in0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_cons_buff_1 : memref<96000xi32>, 0, 96000)
      aie.use_lock(%in0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%in0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_cons_buff_0 : memref<96000xi32>, 0, 96000)
      aie.use_lock(%in0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%in0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_cons_buff_1 : memref<96000xi32>, 0, 96000)
      aie.use_lock(%in0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 1, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%out1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%out1_cons_buff_0 : memref<8xi32>, 0, 8)
      aie.use_lock(%out1_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%out1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%out1_cons_buff_1 : memref<8xi32>, 0, 8)
      aie.use_lock(%out1_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      %3 = aie.dma_start(S2MM, 1, ^bb10, ^bb12)
    ^bb10:  // 2 preds: ^bb9, ^bb11
      aie.use_lock(%out1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%out1_cons_buff_0 : memref<8xi32>, 0, 8)
      aie.use_lock(%out1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb11
    ^bb11:  // pred: ^bb10
      aie.use_lock(%out1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%out1_cons_buff_1 : memref<8xi32>, 0, 8)
      aie.use_lock(%out1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb10
    ^bb12:  // pred: ^bb9
      aie.end
    }
    %mem_0_2 = aie.mem(%tile_0_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%in1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in1_cons_buff_0 : memref<8xi32>, 0, 8)
      aie.use_lock(%in1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%in1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in1_cons_buff_1 : memref<8xi32>, 0, 8)
      aie.use_lock(%in1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%out1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%out1_buff_0 : memref<8xi32>, 0, 8)
      aie.use_lock(%out1_prod_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%out1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%out1_buff_1 : memref<8xi32>, 0, 8)
      aie.use_lock(%out1_prod_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      aie.end
    }
    aie.shim_dma_allocation @out0(S2MM, 0, 0)
  }
}

