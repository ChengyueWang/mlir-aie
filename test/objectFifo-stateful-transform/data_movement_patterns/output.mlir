module @broadcast {
  aie.device(xcvc1902) {
    memref.global "public" @broadcast_of_0_cons : memref<16xi32>
    memref.global "public" @broadcast_of_1_cons : memref<16xi32>
    memref.global "public" @broadcast_of_2_cons : memref<16xi32>
    memref.global "public" @broadcast_of_3_cons : memref<16xi32>
    memref.global "public" @broadcast_of : memref<16xi32>
    %tile_1_2 = aie.tile(1, 2)
    %tile_1_3 = aie.tile(1, 3)
    %tile_1_4 = aie.tile(1, 4)
    %tile_3_2 = aie.tile(3, 2)
    %tile_3_3 = aie.tile(3, 3)
    %broadcast_of_0_cons_buff_0 = aie.buffer(%tile_1_2) {sym_name = "broadcast_of_0_cons_buff_0"} : memref<16xi32> 
    %broadcast_of_0_cons_buff_1 = aie.buffer(%tile_1_2) {sym_name = "broadcast_of_0_cons_buff_1"} : memref<16xi32> 
    %broadcast_of_0_cons_lock_0 = aie.lock(%tile_1_2, 0) {init = 0 : i32, sym_name = "broadcast_of_0_cons_lock_0"}
    %broadcast_of_0_cons_lock_1 = aie.lock(%tile_1_2, 1) {init = 0 : i32, sym_name = "broadcast_of_0_cons_lock_1"}
    %broadcast_of_1_cons_buff_0 = aie.buffer(%tile_1_4) {sym_name = "broadcast_of_1_cons_buff_0"} : memref<16xi32> 
    %broadcast_of_1_cons_buff_1 = aie.buffer(%tile_1_4) {sym_name = "broadcast_of_1_cons_buff_1"} : memref<16xi32> 
    %broadcast_of_1_cons_buff_2 = aie.buffer(%tile_1_4) {sym_name = "broadcast_of_1_cons_buff_2"} : memref<16xi32> 
    %broadcast_of_1_cons_lock_0 = aie.lock(%tile_1_4, 0) {init = 0 : i32, sym_name = "broadcast_of_1_cons_lock_0"}
    %broadcast_of_1_cons_lock_1 = aie.lock(%tile_1_4, 1) {init = 0 : i32, sym_name = "broadcast_of_1_cons_lock_1"}
    %broadcast_of_1_cons_lock_2 = aie.lock(%tile_1_4, 2) {init = 0 : i32, sym_name = "broadcast_of_1_cons_lock_2"}
    %broadcast_of_2_cons_buff_0 = aie.buffer(%tile_3_2) {sym_name = "broadcast_of_2_cons_buff_0"} : memref<16xi32> 
    %broadcast_of_2_cons_buff_1 = aie.buffer(%tile_3_2) {sym_name = "broadcast_of_2_cons_buff_1"} : memref<16xi32> 
    %broadcast_of_2_cons_buff_2 = aie.buffer(%tile_3_2) {sym_name = "broadcast_of_2_cons_buff_2"} : memref<16xi32> 
    %broadcast_of_2_cons_buff_3 = aie.buffer(%tile_3_2) {sym_name = "broadcast_of_2_cons_buff_3"} : memref<16xi32> 
    %broadcast_of_2_cons_lock_0 = aie.lock(%tile_3_2, 0) {init = 0 : i32, sym_name = "broadcast_of_2_cons_lock_0"}
    %broadcast_of_2_cons_lock_1 = aie.lock(%tile_3_2, 1) {init = 0 : i32, sym_name = "broadcast_of_2_cons_lock_1"}
    %broadcast_of_2_cons_lock_2 = aie.lock(%tile_3_2, 2) {init = 0 : i32, sym_name = "broadcast_of_2_cons_lock_2"}
    %broadcast_of_2_cons_lock_3 = aie.lock(%tile_3_2, 3) {init = 0 : i32, sym_name = "broadcast_of_2_cons_lock_3"}
    %broadcast_of_3_cons_buff_0 = aie.buffer(%tile_3_3) {sym_name = "broadcast_of_3_cons_buff_0"} : memref<16xi32> 
    %broadcast_of_3_cons_buff_1 = aie.buffer(%tile_3_3) {sym_name = "broadcast_of_3_cons_buff_1"} : memref<16xi32> 
    %broadcast_of_3_cons_buff_2 = aie.buffer(%tile_3_3) {sym_name = "broadcast_of_3_cons_buff_2"} : memref<16xi32> 
    %broadcast_of_3_cons_lock_0 = aie.lock(%tile_3_3, 0) {init = 0 : i32, sym_name = "broadcast_of_3_cons_lock_0"}
    %broadcast_of_3_cons_lock_1 = aie.lock(%tile_3_3, 1) {init = 0 : i32, sym_name = "broadcast_of_3_cons_lock_1"}
    %broadcast_of_3_cons_lock_2 = aie.lock(%tile_3_3, 2) {init = 0 : i32, sym_name = "broadcast_of_3_cons_lock_2"}
    %broadcast_of_buff_0 = aie.buffer(%tile_1_3) {sym_name = "broadcast_of_buff_0"} : memref<16xi32> 
    %broadcast_of_buff_1 = aie.buffer(%tile_1_3) {sym_name = "broadcast_of_buff_1"} : memref<16xi32> 
    %broadcast_of_lock_0 = aie.lock(%tile_1_3, 0) {init = 0 : i32, sym_name = "broadcast_of_lock_0"}
    %broadcast_of_lock_1 = aie.lock(%tile_1_3, 1) {init = 0 : i32, sym_name = "broadcast_of_lock_1"}
    aie.flow(%tile_1_3, DMA : 0, %tile_3_3, DMA : 0)
    aie.flow(%tile_1_3, DMA : 0, %tile_3_2, DMA : 0)
    aie.flow(%tile_1_3, DMA : 0, %tile_1_4, DMA : 0)
    aie.flow(%tile_1_3, DMA : 0, %tile_1_2, DMA : 0)
    func.func @some_work(%arg0: memref<16xi32>) {
      return
    }
    %core_1_3 = aie.core(%tile_1_3) {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c12 = arith.constant 12 : index
      %c2 = arith.constant 2 : index
      scf.for %arg0 = %c0 to %c12 step %c2 {
        aie.use_lock(%broadcast_of_lock_0, Acquire, 0)
        func.call @some_work(%broadcast_of_buff_0) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_lock_0, Release, 1)
        aie.use_lock(%broadcast_of_lock_1, Acquire, 0)
        func.call @some_work(%broadcast_of_buff_1) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_lock_1, Release, 1)
      }
      aie.end
    }
    %core_1_2 = aie.core(%tile_1_2) {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c12 = arith.constant 12 : index
      %c2 = arith.constant 2 : index
      scf.for %arg0 = %c0 to %c12 step %c2 {
        aie.use_lock(%broadcast_of_0_cons_lock_0, Acquire, 1)
        func.call @some_work(%broadcast_of_0_cons_buff_0) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_0_cons_lock_0, Release, 0)
        aie.use_lock(%broadcast_of_0_cons_lock_1, Acquire, 1)
        func.call @some_work(%broadcast_of_0_cons_buff_1) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_0_cons_lock_1, Release, 0)
      }
      aie.end
    }
    %core_1_4 = aie.core(%tile_1_4) {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c12 = arith.constant 12 : index
      %c3 = arith.constant 3 : index
      scf.for %arg0 = %c0 to %c12 step %c3 {
        aie.use_lock(%broadcast_of_1_cons_lock_0, Acquire, 1)
        aie.use_lock(%broadcast_of_1_cons_lock_1, Acquire, 1)
        func.call @some_work(%broadcast_of_1_cons_buff_0) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_1_cons_buff_1) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_1_cons_lock_0, Release, 0)
        aie.use_lock(%broadcast_of_1_cons_lock_1, Release, 0)
        aie.use_lock(%broadcast_of_1_cons_lock_2, Acquire, 1)
        aie.use_lock(%broadcast_of_1_cons_lock_0, Acquire, 1)
        func.call @some_work(%broadcast_of_1_cons_buff_2) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_1_cons_buff_0) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_1_cons_lock_2, Release, 0)
        aie.use_lock(%broadcast_of_1_cons_lock_0, Release, 0)
        aie.use_lock(%broadcast_of_1_cons_lock_1, Acquire, 1)
        aie.use_lock(%broadcast_of_1_cons_lock_2, Acquire, 1)
        func.call @some_work(%broadcast_of_1_cons_buff_1) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_1_cons_buff_2) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_1_cons_lock_1, Release, 0)
        aie.use_lock(%broadcast_of_1_cons_lock_2, Release, 0)
      }
      aie.end
    }
    %core_3_2 = aie.core(%tile_3_2) {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c12 = arith.constant 12 : index
      %c4 = arith.constant 4 : index
      scf.for %arg0 = %c0 to %c12 step %c4 {
        aie.use_lock(%broadcast_of_2_cons_lock_0, Acquire, 1)
        aie.use_lock(%broadcast_of_2_cons_lock_1, Acquire, 1)
        aie.use_lock(%broadcast_of_2_cons_lock_2, Acquire, 1)
        func.call @some_work(%broadcast_of_2_cons_buff_0) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_1) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_2) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_2_cons_lock_0, Release, 0)
        aie.use_lock(%broadcast_of_2_cons_lock_3, Acquire, 1)
        func.call @some_work(%broadcast_of_2_cons_buff_1) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_2) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_3) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_2_cons_lock_1, Release, 0)
        aie.use_lock(%broadcast_of_2_cons_lock_0, Acquire, 1)
        func.call @some_work(%broadcast_of_2_cons_buff_2) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_3) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_0) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_2_cons_lock_2, Release, 0)
        aie.use_lock(%broadcast_of_2_cons_lock_1, Acquire, 1)
        func.call @some_work(%broadcast_of_2_cons_buff_3) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_0) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_2_cons_buff_1) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_2_cons_lock_3, Release, 0)
      }
      aie.end
    }
    %core_3_3 = aie.core(%tile_3_3) {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c12 = arith.constant 12 : index
      %c3 = arith.constant 3 : index
      scf.for %arg0 = %c0 to %c12 step %c3 {
        aie.use_lock(%broadcast_of_3_cons_lock_0, Acquire, 1)
        aie.use_lock(%broadcast_of_3_cons_lock_1, Acquire, 1)
        func.call @some_work(%broadcast_of_3_cons_buff_0) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_3_cons_buff_1) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_3_cons_lock_0, Release, 0)
        aie.use_lock(%broadcast_of_3_cons_lock_2, Acquire, 1)
        func.call @some_work(%broadcast_of_3_cons_buff_1) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_3_cons_buff_2) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_3_cons_lock_1, Release, 0)
        aie.use_lock(%broadcast_of_3_cons_lock_0, Acquire, 1)
        func.call @some_work(%broadcast_of_3_cons_buff_2) : (memref<16xi32>) -> ()
        func.call @some_work(%broadcast_of_3_cons_buff_0) : (memref<16xi32>) -> ()
        aie.use_lock(%broadcast_of_3_cons_lock_2, Release, 0)
      }
      aie.end
    }
    %mem_1_3 = aie.mem(%tile_1_3) {
      %0 = aie.dma_start(MM2S, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%broadcast_of_lock_0, Acquire, 1)
      aie.dma_bd(%broadcast_of_buff_0 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_lock_0, Release, 0)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%broadcast_of_lock_1, Acquire, 1)
      aie.dma_bd(%broadcast_of_buff_1 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_lock_1, Release, 0)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      aie.end
    }
    %mem_1_2 = aie.mem(%tile_1_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%broadcast_of_0_cons_lock_0, Acquire, 0)
      aie.dma_bd(%broadcast_of_0_cons_buff_0 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_0_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%broadcast_of_0_cons_lock_1, Acquire, 0)
      aie.dma_bd(%broadcast_of_0_cons_buff_1 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_0_cons_lock_1, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      aie.end
    }
    %mem_1_4 = aie.mem(%tile_1_4) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb4)
    ^bb1:  // 2 preds: ^bb0, ^bb3
      aie.use_lock(%broadcast_of_1_cons_lock_0, Acquire, 0)
      aie.dma_bd(%broadcast_of_1_cons_buff_0 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_1_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%broadcast_of_1_cons_lock_1, Acquire, 0)
      aie.dma_bd(%broadcast_of_1_cons_buff_1 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_1_cons_lock_1, Release, 1)
      aie.next_bd ^bb3
    ^bb3:  // pred: ^bb2
      aie.use_lock(%broadcast_of_1_cons_lock_2, Acquire, 0)
      aie.dma_bd(%broadcast_of_1_cons_buff_2 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_1_cons_lock_2, Release, 1)
      aie.next_bd ^bb1
    ^bb4:  // pred: ^bb0
      aie.end
    }
    %mem_3_2 = aie.mem(%tile_3_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb5)
    ^bb1:  // 2 preds: ^bb0, ^bb4
      aie.use_lock(%broadcast_of_2_cons_lock_0, Acquire, 0)
      aie.dma_bd(%broadcast_of_2_cons_buff_0 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_2_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%broadcast_of_2_cons_lock_1, Acquire, 0)
      aie.dma_bd(%broadcast_of_2_cons_buff_1 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_2_cons_lock_1, Release, 1)
      aie.next_bd ^bb3
    ^bb3:  // pred: ^bb2
      aie.use_lock(%broadcast_of_2_cons_lock_2, Acquire, 0)
      aie.dma_bd(%broadcast_of_2_cons_buff_2 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_2_cons_lock_2, Release, 1)
      aie.next_bd ^bb4
    ^bb4:  // pred: ^bb3
      aie.use_lock(%broadcast_of_2_cons_lock_3, Acquire, 0)
      aie.dma_bd(%broadcast_of_2_cons_buff_3 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_2_cons_lock_3, Release, 1)
      aie.next_bd ^bb1
    ^bb5:  // pred: ^bb0
      aie.end
    }
    %mem_3_3 = aie.mem(%tile_3_3) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb4)
    ^bb1:  // 2 preds: ^bb0, ^bb3
      aie.use_lock(%broadcast_of_3_cons_lock_0, Acquire, 0)
      aie.dma_bd(%broadcast_of_3_cons_buff_0 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_3_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%broadcast_of_3_cons_lock_1, Acquire, 0)
      aie.dma_bd(%broadcast_of_3_cons_buff_1 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_3_cons_lock_1, Release, 1)
      aie.next_bd ^bb3
    ^bb3:  // pred: ^bb2
      aie.use_lock(%broadcast_of_3_cons_lock_2, Acquire, 0)
      aie.dma_bd(%broadcast_of_3_cons_buff_2 : memref<16xi32>, 0, 16)
      aie.use_lock(%broadcast_of_3_cons_lock_2, Release, 1)
      aie.next_bd ^bb1
    ^bb4:  // pred: ^bb0
      aie.end
    }
  }
}

