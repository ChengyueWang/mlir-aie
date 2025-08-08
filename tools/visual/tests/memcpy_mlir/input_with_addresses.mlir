module {
  aie.device(npu2) {
    memref.global "public" @in0_0_fwd_cons : memref<1024xi32>
    memref.global "public" @in0_0_fwd : memref<1024xi32>
    memref.global "public" @in0_0_cons : memref<1024xi32>
    memref.global "public" @in0_0 : memref<1024xi32>
    %shim_noc_tile_0_0 = aie.tile(0, 0) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 15>}
    %mem_tile_0_1 = aie.tile(0, 1) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 26>}
    %in0_0_cons_buff_1 = aie.buffer(%mem_tile_0_1) {address = 0 : i32, mem_bank = 0 : i32, sym_name = "in0_0_cons_buff_1"} : memref<1024xi32> 
    %in0_0_cons_prod_lock_0 = aie.lock(%mem_tile_0_1, 0) {init = 2 : i32, sym_name = "in0_0_cons_prod_lock_0"}
    %in0_0_cons_cons_lock_0 = aie.lock(%mem_tile_0_1, 1) {init = 0 : i32, sym_name = "in0_0_cons_cons_lock_0"}
    %in0_0_fwd_cons_prod_lock_0 = aie.lock(%shim_noc_tile_0_0, 2) {init = 1 : i32, sym_name = "in0_0_fwd_cons_prod_lock_0"}
    %in0_0_fwd_cons_cons_lock_0 = aie.lock(%shim_noc_tile_0_0, 3) {init = 0 : i32, sym_name = "in0_0_fwd_cons_cons_lock_0"}
    %in0_0_cons_buff_0 = aie.buffer(%mem_tile_0_1) {address = 65536 : i32, mem_bank = 1 : i32, sym_name = "in0_0_cons_buff_0"} : memref<1024xi32> 
    aie.flow(%shim_noc_tile_0_0, DMA : 1, %mem_tile_0_1, DMA : 5)
    aie.flow(%mem_tile_0_1, DMA : 5, %shim_noc_tile_0_0, DMA : 1)
    %in0_0_prod_lock_0 = aie.lock(%shim_noc_tile_0_0, 0) {init = 1 : i32, sym_name = "in0_0_prod_lock_0"}
    %in0_0_cons_lock_0 = aie.lock(%shim_noc_tile_0_0, 1) {init = 0 : i32, sym_name = "in0_0_cons_lock_0"}
    aiex.runtime_sequence @sequence(%arg0: memref<16384xi32>, %arg1: memref<16384xi32>) {
      %0 = aiex.dma_configure_task_for @in0_0 {
        aie.dma_bd(%arg0 : memref<16384xi32>, 0, 16384, [<size = 1, stride = 0>, <size = 1, stride = 0>, <size = 1, stride = 0>, <size = 16384, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%0)
      %1 = aiex.dma_configure_task_for @in0_0_fwd {
        aie.dma_bd(%arg1 : memref<16384xi32>, 0, 16384, [<size = 1, stride = 0>, <size = 1, stride = 0>, <size = 1, stride = 0>, <size = 16384, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {issue_token = true}
      aiex.dma_start_task(%1)
      aiex.dma_await_task(%1)
      aiex.dma_free_task(%0)
    }
    aie.shim_dma_allocation @in0_0(MM2S, 1, 0)
    %memtile_dma_0_1 = aie.memtile_dma(%mem_tile_0_1) {
      %0 = aie.dma_start(S2MM, 5, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%in0_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_0_cons_buff_0 : memref<1024xi32>, 0, 1024) {bd_id = 24 : i32, next_bd_id = 25 : i32}
      aie.use_lock(%in0_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%in0_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_0_cons_buff_1 : memref<1024xi32>, 0, 1024) {bd_id = 25 : i32, next_bd_id = 24 : i32}
      aie.use_lock(%in0_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 5, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%in0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_0_cons_buff_0 : memref<1024xi32>, 0, 1024) {bd_id = 26 : i32, next_bd_id = 27 : i32}
      aie.use_lock(%in0_0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%in0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%in0_0_cons_buff_1 : memref<1024xi32>, 0, 1024) {bd_id = 27 : i32, next_bd_id = 26 : i32}
      aie.use_lock(%in0_0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      aie.end
    }
    aie.shim_dma_allocation @in0_0_fwd(S2MM, 1, 0)
    aie.packet_flow(15) {
      aie.packet_source<%shim_noc_tile_0_0, TileControl : 0>
      aie.packet_dest<%shim_noc_tile_0_0, South : 0>
    } {keep_pkt_header = true, priority_route = true}
  }
}
