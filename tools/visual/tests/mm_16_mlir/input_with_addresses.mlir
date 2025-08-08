module {
  aie.device(npu2) {
    memref.global "public" @C_L2L3_3_cons : memref<4096xi32>
    memref.global "public" @C_L2L3_3 : memref<4096xi32>
    memref.global "public" @C_L1L2_3_3_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_3_3 : memref<32x32xi32>
    memref.global "public" @C_L1L2_3_2_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_3_2 : memref<32x32xi32>
    memref.global "public" @C_L1L2_3_1_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_3_1 : memref<32x32xi32>
    memref.global "public" @C_L1L2_3_0_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_3_0 : memref<32x32xi32>
    memref.global "public" @C_L2L3_2_cons : memref<4096xi32>
    memref.global "public" @C_L2L3_2 : memref<4096xi32>
    memref.global "public" @C_L1L2_2_3_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_2_3 : memref<32x32xi32>
    memref.global "public" @C_L1L2_2_2_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_2_2 : memref<32x32xi32>
    memref.global "public" @C_L1L2_2_1_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_2_1 : memref<32x32xi32>
    memref.global "public" @C_L1L2_2_0_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_2_0 : memref<32x32xi32>
    memref.global "public" @C_L2L3_1_cons : memref<4096xi32>
    memref.global "public" @C_L2L3_1 : memref<4096xi32>
    memref.global "public" @C_L1L2_1_3_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_1_3 : memref<32x32xi32>
    memref.global "public" @C_L1L2_1_2_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_1_2 : memref<32x32xi32>
    memref.global "public" @C_L1L2_1_1_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_1_1 : memref<32x32xi32>
    memref.global "public" @C_L1L2_1_0_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_1_0 : memref<32x32xi32>
    memref.global "public" @C_L2L3_0_cons : memref<4096xi32>
    memref.global "public" @C_L2L3_0 : memref<4096xi32>
    memref.global "public" @C_L1L2_0_3_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_0_3 : memref<32x32xi32>
    memref.global "public" @C_L1L2_0_2_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_0_2 : memref<32x32xi32>
    memref.global "public" @C_L1L2_0_1_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_0_1 : memref<32x32xi32>
    memref.global "public" @C_L1L2_0_0_cons : memref<32x32xi32>
    memref.global "public" @C_L1L2_0_0 : memref<32x32xi32>
    memref.global "public" @B_L2L1_3_0_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_3_1_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_3_2_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_3_3_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_3 : memref<32x32xi16>
    memref.global "public" @B_L3L2_3_cons : memref<1024xi16>
    memref.global "public" @B_L3L2_3 : memref<1024xi16>
    memref.global "public" @B_L2L1_2_0_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_2_1_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_2_2_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_2_3_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_2 : memref<32x32xi16>
    memref.global "public" @B_L3L2_2_cons : memref<1024xi16>
    memref.global "public" @B_L3L2_2 : memref<1024xi16>
    memref.global "public" @B_L2L1_1_0_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_1_1_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_1_2_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_1_3_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_1 : memref<32x32xi16>
    memref.global "public" @B_L3L2_1_cons : memref<1024xi16>
    memref.global "public" @B_L3L2_1 : memref<1024xi16>
    memref.global "public" @B_L2L1_0_0_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_0_1_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_0_2_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_0_3_cons : memref<32x32xi16>
    memref.global "public" @B_L2L1_0 : memref<32x32xi16>
    memref.global "public" @B_L3L2_0_cons : memref<1024xi16>
    memref.global "public" @B_L3L2_0 : memref<1024xi16>
    memref.global "public" @A_L2L1_3_0_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_3_1_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_3_2_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_3_3_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_3 : memref<32x32xi16>
    memref.global "public" @A_L2L1_2_0_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_2_1_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_2_2_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_2_3_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_2 : memref<32x32xi16>
    memref.global "public" @A_L2L1_1_0_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_1_1_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_1_2_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_1_3_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_1 : memref<32x32xi16>
    memref.global "public" @A_L2L1_0_0_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_0_1_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_0_2_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_0_3_cons : memref<32x32xi16>
    memref.global "public" @A_L2L1_0 : memref<32x32xi16>
    memref.global "public" @A_L3L2_3_cons : memref<1024xi16>
    memref.global "public" @A_L3L2_3 : memref<1024xi16>
    memref.global "public" @A_L3L2_2_cons : memref<1024xi16>
    memref.global "public" @A_L3L2_2 : memref<1024xi16>
    memref.global "public" @A_L3L2_1_cons : memref<1024xi16>
    memref.global "public" @A_L3L2_1 : memref<1024xi16>
    memref.global "public" @A_L3L2_0_cons : memref<1024xi16>
    memref.global "public" @A_L3L2_0 : memref<1024xi16>
    func.func private @zero_i32(memref<32x32xi32>)
    func.func private @matmul_i16_i32(memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>)
    %shim_noc_tile_0_0 = aie.tile(0, 0) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 15>}
    %shim_noc_tile_1_0 = aie.tile(1, 0) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 15>}
    %shim_noc_tile_2_0 = aie.tile(2, 0) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 15>}
    %shim_noc_tile_3_0 = aie.tile(3, 0) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 15>}
    %mem_tile_0_1 = aie.tile(0, 1) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 26>}
    %mem_tile_1_1 = aie.tile(1, 1) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 26>}
    %mem_tile_2_1 = aie.tile(2, 1) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 26>}
    %mem_tile_3_1 = aie.tile(3, 1) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 26>}
    %tile_0_2 = aie.tile(0, 2) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 27>}
    %tile_1_2 = aie.tile(1, 2) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 27>}
    %tile_2_2 = aie.tile(2, 2) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 27>}
    %tile_3_2 = aie.tile(3, 2) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 27>}
    %tile_0_3 = aie.tile(0, 3) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 29>}
    %tile_1_3 = aie.tile(1, 3) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 29>}
    %tile_2_3 = aie.tile(2, 3) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 29>}
    %tile_3_3 = aie.tile(3, 3) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 29>}
    %tile_0_4 = aie.tile(0, 4) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 30>}
    %tile_1_4 = aie.tile(1, 4) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 30>}
    %tile_2_4 = aie.tile(2, 4) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 30>}
    %tile_3_4 = aie.tile(3, 4) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 30>}
    %tile_0_5 = aie.tile(0, 5) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 31>}
    %tile_1_5 = aie.tile(1, 5) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 31>}
    %tile_2_5 = aie.tile(2, 5) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 31>}
    %tile_3_5 = aie.tile(3, 5) {controller_id = #aie.packet_info<pkt_type = 0, pkt_id = 31>}
    %C_L2L3_3_cons_prod_lock_0 = aie.lock(%shim_noc_tile_3_0, 4) {init = 1 : i32, sym_name = "C_L2L3_3_cons_prod_lock_0"}
    %C_L2L3_3_cons_cons_lock_0 = aie.lock(%shim_noc_tile_3_0, 5) {init = 0 : i32, sym_name = "C_L2L3_3_cons_cons_lock_0"}
    %C_L2L3_3_buff_0 = aie.buffer(%mem_tile_3_1) {address = 0 : i32, sym_name = "C_L2L3_3_buff_0"} : memref<4096xi32> 
    %C_L2L3_3_buff_1 = aie.buffer(%mem_tile_3_1) {address = 16384 : i32, sym_name = "C_L2L3_3_buff_1"} : memref<4096xi32> 
    %C_L2L3_3_prod_lock_0 = aie.lock(%mem_tile_3_1, 4) {init = 2 : i32, sym_name = "C_L2L3_3_prod_lock_0"}
    %C_L2L3_3_cons_lock_0 = aie.lock(%mem_tile_3_1, 5) {init = 0 : i32, sym_name = "C_L2L3_3_cons_lock_0"}
    %C_L2L3_3_prod_lock_1 = aie.lock(%mem_tile_3_1, 6) {init = 2 : i32, sym_name = "C_L2L3_3_prod_lock_1"}
    %C_L2L3_3_cons_lock_1 = aie.lock(%mem_tile_3_1, 7) {init = 0 : i32, sym_name = "C_L2L3_3_cons_lock_1"}
    %C_L2L3_3_prod_lock_2 = aie.lock(%mem_tile_3_1, 8) {init = 2 : i32, sym_name = "C_L2L3_3_prod_lock_2"}
    %C_L2L3_3_cons_lock_2 = aie.lock(%mem_tile_3_1, 9) {init = 0 : i32, sym_name = "C_L2L3_3_cons_lock_2"}
    %C_L2L3_3_prod_lock_3 = aie.lock(%mem_tile_3_1, 10) {init = 2 : i32, sym_name = "C_L2L3_3_prod_lock_3"}
    %C_L2L3_3_cons_lock_3 = aie.lock(%mem_tile_3_1, 11) {init = 0 : i32, sym_name = "C_L2L3_3_cons_lock_3"}
    %C_L1L2_3_3_buff_0 = aie.buffer(%tile_3_5) {address = 3328 : i32, sym_name = "C_L1L2_3_3_buff_0"} : memref<32x32xi32> 
    %C_L1L2_3_3_buff_1 = aie.buffer(%tile_3_5) {address = 7424 : i32, sym_name = "C_L1L2_3_3_buff_1"} : memref<32x32xi32> 
    %C_L1L2_3_3_prod_lock_0 = aie.lock(%tile_3_5, 4) {init = 2 : i32, sym_name = "C_L1L2_3_3_prod_lock_0"}
    %C_L1L2_3_3_cons_lock_0 = aie.lock(%tile_3_5, 5) {init = 0 : i32, sym_name = "C_L1L2_3_3_cons_lock_0"}
    %C_L1L2_3_2_buff_0 = aie.buffer(%tile_3_4) {address = 3328 : i32, sym_name = "C_L1L2_3_2_buff_0"} : memref<32x32xi32> 
    %C_L1L2_3_2_buff_1 = aie.buffer(%tile_3_4) {address = 7424 : i32, sym_name = "C_L1L2_3_2_buff_1"} : memref<32x32xi32> 
    %C_L1L2_3_2_prod_lock_0 = aie.lock(%tile_3_4, 4) {init = 2 : i32, sym_name = "C_L1L2_3_2_prod_lock_0"}
    %C_L1L2_3_2_cons_lock_0 = aie.lock(%tile_3_4, 5) {init = 0 : i32, sym_name = "C_L1L2_3_2_cons_lock_0"}
    %C_L1L2_3_1_buff_0 = aie.buffer(%tile_3_3) {address = 3328 : i32, sym_name = "C_L1L2_3_1_buff_0"} : memref<32x32xi32> 
    %C_L1L2_3_1_buff_1 = aie.buffer(%tile_3_3) {address = 7424 : i32, sym_name = "C_L1L2_3_1_buff_1"} : memref<32x32xi32> 
    %C_L1L2_3_1_prod_lock_0 = aie.lock(%tile_3_3, 4) {init = 2 : i32, sym_name = "C_L1L2_3_1_prod_lock_0"}
    %C_L1L2_3_1_cons_lock_0 = aie.lock(%tile_3_3, 5) {init = 0 : i32, sym_name = "C_L1L2_3_1_cons_lock_0"}
    %C_L1L2_3_0_buff_0 = aie.buffer(%tile_3_2) {address = 3328 : i32, sym_name = "C_L1L2_3_0_buff_0"} : memref<32x32xi32> 
    %C_L1L2_3_0_buff_1 = aie.buffer(%tile_3_2) {address = 7424 : i32, sym_name = "C_L1L2_3_0_buff_1"} : memref<32x32xi32> 
    %C_L1L2_3_0_prod_lock_0 = aie.lock(%tile_3_2, 4) {init = 2 : i32, sym_name = "C_L1L2_3_0_prod_lock_0"}
    %C_L1L2_3_0_cons_lock_0 = aie.lock(%tile_3_2, 5) {init = 0 : i32, sym_name = "C_L1L2_3_0_cons_lock_0"}
    %C_L2L3_2_cons_prod_lock_0 = aie.lock(%shim_noc_tile_2_0, 4) {init = 1 : i32, sym_name = "C_L2L3_2_cons_prod_lock_0"}
    %C_L2L3_2_cons_cons_lock_0 = aie.lock(%shim_noc_tile_2_0, 5) {init = 0 : i32, sym_name = "C_L2L3_2_cons_cons_lock_0"}
    %C_L2L3_2_buff_0 = aie.buffer(%mem_tile_2_1) {address = 0 : i32, sym_name = "C_L2L3_2_buff_0"} : memref<4096xi32> 
    %C_L2L3_2_buff_1 = aie.buffer(%mem_tile_2_1) {address = 16384 : i32, sym_name = "C_L2L3_2_buff_1"} : memref<4096xi32> 
    %C_L2L3_2_prod_lock_0 = aie.lock(%mem_tile_2_1, 4) {init = 2 : i32, sym_name = "C_L2L3_2_prod_lock_0"}
    %C_L2L3_2_cons_lock_0 = aie.lock(%mem_tile_2_1, 5) {init = 0 : i32, sym_name = "C_L2L3_2_cons_lock_0"}
    %C_L2L3_2_prod_lock_1 = aie.lock(%mem_tile_2_1, 6) {init = 2 : i32, sym_name = "C_L2L3_2_prod_lock_1"}
    %C_L2L3_2_cons_lock_1 = aie.lock(%mem_tile_2_1, 7) {init = 0 : i32, sym_name = "C_L2L3_2_cons_lock_1"}
    %C_L2L3_2_prod_lock_2 = aie.lock(%mem_tile_2_1, 8) {init = 2 : i32, sym_name = "C_L2L3_2_prod_lock_2"}
    %C_L2L3_2_cons_lock_2 = aie.lock(%mem_tile_2_1, 9) {init = 0 : i32, sym_name = "C_L2L3_2_cons_lock_2"}
    %C_L2L3_2_prod_lock_3 = aie.lock(%mem_tile_2_1, 10) {init = 2 : i32, sym_name = "C_L2L3_2_prod_lock_3"}
    %C_L2L3_2_cons_lock_3 = aie.lock(%mem_tile_2_1, 11) {init = 0 : i32, sym_name = "C_L2L3_2_cons_lock_3"}
    %C_L1L2_2_3_buff_0 = aie.buffer(%tile_2_5) {address = 3328 : i32, sym_name = "C_L1L2_2_3_buff_0"} : memref<32x32xi32> 
    %C_L1L2_2_3_buff_1 = aie.buffer(%tile_2_5) {address = 7424 : i32, sym_name = "C_L1L2_2_3_buff_1"} : memref<32x32xi32> 
    %C_L1L2_2_3_prod_lock_0 = aie.lock(%tile_2_5, 4) {init = 2 : i32, sym_name = "C_L1L2_2_3_prod_lock_0"}
    %C_L1L2_2_3_cons_lock_0 = aie.lock(%tile_2_5, 5) {init = 0 : i32, sym_name = "C_L1L2_2_3_cons_lock_0"}
    %C_L1L2_2_2_buff_0 = aie.buffer(%tile_2_4) {address = 3328 : i32, sym_name = "C_L1L2_2_2_buff_0"} : memref<32x32xi32> 
    %C_L1L2_2_2_buff_1 = aie.buffer(%tile_2_4) {address = 7424 : i32, sym_name = "C_L1L2_2_2_buff_1"} : memref<32x32xi32> 
    %C_L1L2_2_2_prod_lock_0 = aie.lock(%tile_2_4, 4) {init = 2 : i32, sym_name = "C_L1L2_2_2_prod_lock_0"}
    %C_L1L2_2_2_cons_lock_0 = aie.lock(%tile_2_4, 5) {init = 0 : i32, sym_name = "C_L1L2_2_2_cons_lock_0"}
    %C_L1L2_2_1_buff_0 = aie.buffer(%tile_2_3) {address = 3328 : i32, sym_name = "C_L1L2_2_1_buff_0"} : memref<32x32xi32> 
    %C_L1L2_2_1_buff_1 = aie.buffer(%tile_2_3) {address = 7424 : i32, sym_name = "C_L1L2_2_1_buff_1"} : memref<32x32xi32> 
    %C_L1L2_2_1_prod_lock_0 = aie.lock(%tile_2_3, 4) {init = 2 : i32, sym_name = "C_L1L2_2_1_prod_lock_0"}
    %C_L1L2_2_1_cons_lock_0 = aie.lock(%tile_2_3, 5) {init = 0 : i32, sym_name = "C_L1L2_2_1_cons_lock_0"}
    %C_L1L2_2_0_buff_0 = aie.buffer(%tile_2_2) {address = 3328 : i32, sym_name = "C_L1L2_2_0_buff_0"} : memref<32x32xi32> 
    %C_L1L2_2_0_buff_1 = aie.buffer(%tile_2_2) {address = 7424 : i32, sym_name = "C_L1L2_2_0_buff_1"} : memref<32x32xi32> 
    %C_L1L2_2_0_prod_lock_0 = aie.lock(%tile_2_2, 4) {init = 2 : i32, sym_name = "C_L1L2_2_0_prod_lock_0"}
    %C_L1L2_2_0_cons_lock_0 = aie.lock(%tile_2_2, 5) {init = 0 : i32, sym_name = "C_L1L2_2_0_cons_lock_0"}
    %C_L2L3_1_cons_prod_lock_0 = aie.lock(%shim_noc_tile_1_0, 4) {init = 1 : i32, sym_name = "C_L2L3_1_cons_prod_lock_0"}
    %C_L2L3_1_cons_cons_lock_0 = aie.lock(%shim_noc_tile_1_0, 5) {init = 0 : i32, sym_name = "C_L2L3_1_cons_cons_lock_0"}
    %C_L2L3_1_buff_0 = aie.buffer(%mem_tile_1_1) {address = 0 : i32, sym_name = "C_L2L3_1_buff_0"} : memref<4096xi32> 
    %C_L2L3_1_buff_1 = aie.buffer(%mem_tile_1_1) {address = 16384 : i32, sym_name = "C_L2L3_1_buff_1"} : memref<4096xi32> 
    %C_L2L3_1_prod_lock_0 = aie.lock(%mem_tile_1_1, 4) {init = 2 : i32, sym_name = "C_L2L3_1_prod_lock_0"}
    %C_L2L3_1_cons_lock_0 = aie.lock(%mem_tile_1_1, 5) {init = 0 : i32, sym_name = "C_L2L3_1_cons_lock_0"}
    %C_L2L3_1_prod_lock_1 = aie.lock(%mem_tile_1_1, 6) {init = 2 : i32, sym_name = "C_L2L3_1_prod_lock_1"}
    %C_L2L3_1_cons_lock_1 = aie.lock(%mem_tile_1_1, 7) {init = 0 : i32, sym_name = "C_L2L3_1_cons_lock_1"}
    %C_L2L3_1_prod_lock_2 = aie.lock(%mem_tile_1_1, 8) {init = 2 : i32, sym_name = "C_L2L3_1_prod_lock_2"}
    %C_L2L3_1_cons_lock_2 = aie.lock(%mem_tile_1_1, 9) {init = 0 : i32, sym_name = "C_L2L3_1_cons_lock_2"}
    %C_L2L3_1_prod_lock_3 = aie.lock(%mem_tile_1_1, 10) {init = 2 : i32, sym_name = "C_L2L3_1_prod_lock_3"}
    %C_L2L3_1_cons_lock_3 = aie.lock(%mem_tile_1_1, 11) {init = 0 : i32, sym_name = "C_L2L3_1_cons_lock_3"}
    %C_L1L2_1_3_buff_0 = aie.buffer(%tile_1_5) {address = 3328 : i32, sym_name = "C_L1L2_1_3_buff_0"} : memref<32x32xi32> 
    %C_L1L2_1_3_buff_1 = aie.buffer(%tile_1_5) {address = 7424 : i32, sym_name = "C_L1L2_1_3_buff_1"} : memref<32x32xi32> 
    %C_L1L2_1_3_prod_lock_0 = aie.lock(%tile_1_5, 4) {init = 2 : i32, sym_name = "C_L1L2_1_3_prod_lock_0"}
    %C_L1L2_1_3_cons_lock_0 = aie.lock(%tile_1_5, 5) {init = 0 : i32, sym_name = "C_L1L2_1_3_cons_lock_0"}
    %C_L1L2_1_2_buff_0 = aie.buffer(%tile_1_4) {address = 3328 : i32, sym_name = "C_L1L2_1_2_buff_0"} : memref<32x32xi32> 
    %C_L1L2_1_2_buff_1 = aie.buffer(%tile_1_4) {address = 7424 : i32, sym_name = "C_L1L2_1_2_buff_1"} : memref<32x32xi32> 
    %C_L1L2_1_2_prod_lock_0 = aie.lock(%tile_1_4, 4) {init = 2 : i32, sym_name = "C_L1L2_1_2_prod_lock_0"}
    %C_L1L2_1_2_cons_lock_0 = aie.lock(%tile_1_4, 5) {init = 0 : i32, sym_name = "C_L1L2_1_2_cons_lock_0"}
    %C_L1L2_1_1_buff_0 = aie.buffer(%tile_1_3) {address = 3328 : i32, sym_name = "C_L1L2_1_1_buff_0"} : memref<32x32xi32> 
    %C_L1L2_1_1_buff_1 = aie.buffer(%tile_1_3) {address = 7424 : i32, sym_name = "C_L1L2_1_1_buff_1"} : memref<32x32xi32> 
    %C_L1L2_1_1_prod_lock_0 = aie.lock(%tile_1_3, 4) {init = 2 : i32, sym_name = "C_L1L2_1_1_prod_lock_0"}
    %C_L1L2_1_1_cons_lock_0 = aie.lock(%tile_1_3, 5) {init = 0 : i32, sym_name = "C_L1L2_1_1_cons_lock_0"}
    %C_L1L2_1_0_buff_0 = aie.buffer(%tile_1_2) {address = 3328 : i32, sym_name = "C_L1L2_1_0_buff_0"} : memref<32x32xi32> 
    %C_L1L2_1_0_buff_1 = aie.buffer(%tile_1_2) {address = 7424 : i32, sym_name = "C_L1L2_1_0_buff_1"} : memref<32x32xi32> 
    %C_L1L2_1_0_prod_lock_0 = aie.lock(%tile_1_2, 4) {init = 2 : i32, sym_name = "C_L1L2_1_0_prod_lock_0"}
    %C_L1L2_1_0_cons_lock_0 = aie.lock(%tile_1_2, 5) {init = 0 : i32, sym_name = "C_L1L2_1_0_cons_lock_0"}
    %C_L2L3_0_cons_prod_lock_0 = aie.lock(%shim_noc_tile_0_0, 4) {init = 1 : i32, sym_name = "C_L2L3_0_cons_prod_lock_0"}
    %C_L2L3_0_cons_cons_lock_0 = aie.lock(%shim_noc_tile_0_0, 5) {init = 0 : i32, sym_name = "C_L2L3_0_cons_cons_lock_0"}
    %C_L2L3_0_buff_0 = aie.buffer(%mem_tile_0_1) {address = 0 : i32, sym_name = "C_L2L3_0_buff_0"} : memref<4096xi32> 
    %C_L2L3_0_buff_1 = aie.buffer(%mem_tile_0_1) {address = 16384 : i32, sym_name = "C_L2L3_0_buff_1"} : memref<4096xi32> 
    %C_L2L3_0_prod_lock_0 = aie.lock(%mem_tile_0_1, 4) {init = 2 : i32, sym_name = "C_L2L3_0_prod_lock_0"}
    %C_L2L3_0_cons_lock_0 = aie.lock(%mem_tile_0_1, 5) {init = 0 : i32, sym_name = "C_L2L3_0_cons_lock_0"}
    %C_L2L3_0_prod_lock_1 = aie.lock(%mem_tile_0_1, 6) {init = 2 : i32, sym_name = "C_L2L3_0_prod_lock_1"}
    %C_L2L3_0_cons_lock_1 = aie.lock(%mem_tile_0_1, 7) {init = 0 : i32, sym_name = "C_L2L3_0_cons_lock_1"}
    %C_L2L3_0_prod_lock_2 = aie.lock(%mem_tile_0_1, 8) {init = 2 : i32, sym_name = "C_L2L3_0_prod_lock_2"}
    %C_L2L3_0_cons_lock_2 = aie.lock(%mem_tile_0_1, 9) {init = 0 : i32, sym_name = "C_L2L3_0_cons_lock_2"}
    %C_L2L3_0_prod_lock_3 = aie.lock(%mem_tile_0_1, 10) {init = 2 : i32, sym_name = "C_L2L3_0_prod_lock_3"}
    %C_L2L3_0_cons_lock_3 = aie.lock(%mem_tile_0_1, 11) {init = 0 : i32, sym_name = "C_L2L3_0_cons_lock_3"}
    %C_L1L2_0_3_buff_0 = aie.buffer(%tile_0_5) {address = 3328 : i32, sym_name = "C_L1L2_0_3_buff_0"} : memref<32x32xi32> 
    %C_L1L2_0_3_buff_1 = aie.buffer(%tile_0_5) {address = 7424 : i32, sym_name = "C_L1L2_0_3_buff_1"} : memref<32x32xi32> 
    %C_L1L2_0_3_prod_lock_0 = aie.lock(%tile_0_5, 4) {init = 2 : i32, sym_name = "C_L1L2_0_3_prod_lock_0"}
    %C_L1L2_0_3_cons_lock_0 = aie.lock(%tile_0_5, 5) {init = 0 : i32, sym_name = "C_L1L2_0_3_cons_lock_0"}
    %C_L1L2_0_2_buff_0 = aie.buffer(%tile_0_4) {address = 3328 : i32, sym_name = "C_L1L2_0_2_buff_0"} : memref<32x32xi32> 
    %C_L1L2_0_2_buff_1 = aie.buffer(%tile_0_4) {address = 7424 : i32, sym_name = "C_L1L2_0_2_buff_1"} : memref<32x32xi32> 
    %C_L1L2_0_2_prod_lock_0 = aie.lock(%tile_0_4, 4) {init = 2 : i32, sym_name = "C_L1L2_0_2_prod_lock_0"}
    %C_L1L2_0_2_cons_lock_0 = aie.lock(%tile_0_4, 5) {init = 0 : i32, sym_name = "C_L1L2_0_2_cons_lock_0"}
    %C_L1L2_0_1_buff_0 = aie.buffer(%tile_0_3) {address = 3328 : i32, sym_name = "C_L1L2_0_1_buff_0"} : memref<32x32xi32> 
    %C_L1L2_0_1_buff_1 = aie.buffer(%tile_0_3) {address = 7424 : i32, sym_name = "C_L1L2_0_1_buff_1"} : memref<32x32xi32> 
    %C_L1L2_0_1_prod_lock_0 = aie.lock(%tile_0_3, 4) {init = 2 : i32, sym_name = "C_L1L2_0_1_prod_lock_0"}
    %C_L1L2_0_1_cons_lock_0 = aie.lock(%tile_0_3, 5) {init = 0 : i32, sym_name = "C_L1L2_0_1_cons_lock_0"}
    %C_L1L2_0_0_buff_0 = aie.buffer(%tile_0_2) {address = 3328 : i32, sym_name = "C_L1L2_0_0_buff_0"} : memref<32x32xi32> 
    %C_L1L2_0_0_buff_1 = aie.buffer(%tile_0_2) {address = 7424 : i32, sym_name = "C_L1L2_0_0_buff_1"} : memref<32x32xi32> 
    %C_L1L2_0_0_prod_lock_0 = aie.lock(%tile_0_2, 4) {init = 2 : i32, sym_name = "C_L1L2_0_0_prod_lock_0"}
    %C_L1L2_0_0_cons_lock_0 = aie.lock(%tile_0_2, 5) {init = 0 : i32, sym_name = "C_L1L2_0_0_cons_lock_0"}
    %B_L2L1_3_0_cons_buff_0 = aie.buffer(%tile_3_2) {address = 11520 : i32, sym_name = "B_L2L1_3_0_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_3_0_cons_buff_1 = aie.buffer(%tile_3_2) {address = 13568 : i32, sym_name = "B_L2L1_3_0_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_3_0_cons_prod_lock_0 = aie.lock(%tile_3_2, 2) {init = 2 : i32, sym_name = "B_L2L1_3_0_cons_prod_lock_0"}
    %B_L2L1_3_0_cons_cons_lock_0 = aie.lock(%tile_3_2, 3) {init = 0 : i32, sym_name = "B_L2L1_3_0_cons_cons_lock_0"}
    %B_L2L1_3_1_cons_buff_0 = aie.buffer(%tile_3_3) {address = 11520 : i32, sym_name = "B_L2L1_3_1_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_3_1_cons_buff_1 = aie.buffer(%tile_3_3) {address = 13568 : i32, sym_name = "B_L2L1_3_1_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_3_1_cons_prod_lock_0 = aie.lock(%tile_3_3, 2) {init = 2 : i32, sym_name = "B_L2L1_3_1_cons_prod_lock_0"}
    %B_L2L1_3_1_cons_cons_lock_0 = aie.lock(%tile_3_3, 3) {init = 0 : i32, sym_name = "B_L2L1_3_1_cons_cons_lock_0"}
    %B_L2L1_3_2_cons_buff_0 = aie.buffer(%tile_3_4) {address = 11520 : i32, sym_name = "B_L2L1_3_2_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_3_2_cons_buff_1 = aie.buffer(%tile_3_4) {address = 13568 : i32, sym_name = "B_L2L1_3_2_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_3_2_cons_prod_lock_0 = aie.lock(%tile_3_4, 2) {init = 2 : i32, sym_name = "B_L2L1_3_2_cons_prod_lock_0"}
    %B_L2L1_3_2_cons_cons_lock_0 = aie.lock(%tile_3_4, 3) {init = 0 : i32, sym_name = "B_L2L1_3_2_cons_cons_lock_0"}
    %B_L2L1_3_3_cons_buff_0 = aie.buffer(%tile_3_5) {address = 11520 : i32, sym_name = "B_L2L1_3_3_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_3_3_cons_buff_1 = aie.buffer(%tile_3_5) {address = 13568 : i32, sym_name = "B_L2L1_3_3_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_3_3_cons_prod_lock_0 = aie.lock(%tile_3_5, 2) {init = 2 : i32, sym_name = "B_L2L1_3_3_cons_prod_lock_0"}
    %B_L2L1_3_3_cons_cons_lock_0 = aie.lock(%tile_3_5, 3) {init = 0 : i32, sym_name = "B_L2L1_3_3_cons_cons_lock_0"}
    %B_L3L2_3_cons_buff_0 = aie.buffer(%mem_tile_3_1) {address = 32768 : i32, sym_name = "B_L3L2_3_cons_buff_0"} : memref<1024xi16> 
    %B_L3L2_3_cons_buff_1 = aie.buffer(%mem_tile_3_1) {address = 34816 : i32, sym_name = "B_L3L2_3_cons_buff_1"} : memref<1024xi16> 
    %B_L3L2_3_cons_prod_lock_0 = aie.lock(%mem_tile_3_1, 2) {init = 2 : i32, sym_name = "B_L3L2_3_cons_prod_lock_0"}
    %B_L3L2_3_cons_cons_lock_0 = aie.lock(%mem_tile_3_1, 3) {init = 0 : i32, sym_name = "B_L3L2_3_cons_cons_lock_0"}
    %B_L3L2_3_prod_lock_0 = aie.lock(%shim_noc_tile_3_0, 2) {init = 1 : i32, sym_name = "B_L3L2_3_prod_lock_0"}
    %B_L3L2_3_cons_lock_0 = aie.lock(%shim_noc_tile_3_0, 3) {init = 0 : i32, sym_name = "B_L3L2_3_cons_lock_0"}
    %B_L2L1_2_0_cons_buff_0 = aie.buffer(%tile_2_2) {address = 11520 : i32, sym_name = "B_L2L1_2_0_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_2_0_cons_buff_1 = aie.buffer(%tile_2_2) {address = 13568 : i32, sym_name = "B_L2L1_2_0_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_2_0_cons_prod_lock_0 = aie.lock(%tile_2_2, 2) {init = 2 : i32, sym_name = "B_L2L1_2_0_cons_prod_lock_0"}
    %B_L2L1_2_0_cons_cons_lock_0 = aie.lock(%tile_2_2, 3) {init = 0 : i32, sym_name = "B_L2L1_2_0_cons_cons_lock_0"}
    %B_L2L1_2_1_cons_buff_0 = aie.buffer(%tile_2_3) {address = 11520 : i32, sym_name = "B_L2L1_2_1_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_2_1_cons_buff_1 = aie.buffer(%tile_2_3) {address = 13568 : i32, sym_name = "B_L2L1_2_1_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_2_1_cons_prod_lock_0 = aie.lock(%tile_2_3, 2) {init = 2 : i32, sym_name = "B_L2L1_2_1_cons_prod_lock_0"}
    %B_L2L1_2_1_cons_cons_lock_0 = aie.lock(%tile_2_3, 3) {init = 0 : i32, sym_name = "B_L2L1_2_1_cons_cons_lock_0"}
    %B_L2L1_2_2_cons_buff_0 = aie.buffer(%tile_2_4) {address = 11520 : i32, sym_name = "B_L2L1_2_2_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_2_2_cons_buff_1 = aie.buffer(%tile_2_4) {address = 13568 : i32, sym_name = "B_L2L1_2_2_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_2_2_cons_prod_lock_0 = aie.lock(%tile_2_4, 2) {init = 2 : i32, sym_name = "B_L2L1_2_2_cons_prod_lock_0"}
    %B_L2L1_2_2_cons_cons_lock_0 = aie.lock(%tile_2_4, 3) {init = 0 : i32, sym_name = "B_L2L1_2_2_cons_cons_lock_0"}
    %B_L2L1_2_3_cons_buff_0 = aie.buffer(%tile_2_5) {address = 11520 : i32, sym_name = "B_L2L1_2_3_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_2_3_cons_buff_1 = aie.buffer(%tile_2_5) {address = 13568 : i32, sym_name = "B_L2L1_2_3_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_2_3_cons_prod_lock_0 = aie.lock(%tile_2_5, 2) {init = 2 : i32, sym_name = "B_L2L1_2_3_cons_prod_lock_0"}
    %B_L2L1_2_3_cons_cons_lock_0 = aie.lock(%tile_2_5, 3) {init = 0 : i32, sym_name = "B_L2L1_2_3_cons_cons_lock_0"}
    %B_L3L2_2_cons_buff_0 = aie.buffer(%mem_tile_2_1) {address = 32768 : i32, sym_name = "B_L3L2_2_cons_buff_0"} : memref<1024xi16> 
    %B_L3L2_2_cons_buff_1 = aie.buffer(%mem_tile_2_1) {address = 34816 : i32, sym_name = "B_L3L2_2_cons_buff_1"} : memref<1024xi16> 
    %B_L3L2_2_cons_prod_lock_0 = aie.lock(%mem_tile_2_1, 2) {init = 2 : i32, sym_name = "B_L3L2_2_cons_prod_lock_0"}
    %B_L3L2_2_cons_cons_lock_0 = aie.lock(%mem_tile_2_1, 3) {init = 0 : i32, sym_name = "B_L3L2_2_cons_cons_lock_0"}
    %B_L3L2_2_prod_lock_0 = aie.lock(%shim_noc_tile_2_0, 2) {init = 1 : i32, sym_name = "B_L3L2_2_prod_lock_0"}
    %B_L3L2_2_cons_lock_0 = aie.lock(%shim_noc_tile_2_0, 3) {init = 0 : i32, sym_name = "B_L3L2_2_cons_lock_0"}
    %B_L2L1_1_0_cons_buff_0 = aie.buffer(%tile_1_2) {address = 11520 : i32, sym_name = "B_L2L1_1_0_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_1_0_cons_buff_1 = aie.buffer(%tile_1_2) {address = 13568 : i32, sym_name = "B_L2L1_1_0_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_1_0_cons_prod_lock_0 = aie.lock(%tile_1_2, 2) {init = 2 : i32, sym_name = "B_L2L1_1_0_cons_prod_lock_0"}
    %B_L2L1_1_0_cons_cons_lock_0 = aie.lock(%tile_1_2, 3) {init = 0 : i32, sym_name = "B_L2L1_1_0_cons_cons_lock_0"}
    %B_L2L1_1_1_cons_buff_0 = aie.buffer(%tile_1_3) {address = 11520 : i32, sym_name = "B_L2L1_1_1_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_1_1_cons_buff_1 = aie.buffer(%tile_1_3) {address = 13568 : i32, sym_name = "B_L2L1_1_1_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_1_1_cons_prod_lock_0 = aie.lock(%tile_1_3, 2) {init = 2 : i32, sym_name = "B_L2L1_1_1_cons_prod_lock_0"}
    %B_L2L1_1_1_cons_cons_lock_0 = aie.lock(%tile_1_3, 3) {init = 0 : i32, sym_name = "B_L2L1_1_1_cons_cons_lock_0"}
    %B_L2L1_1_2_cons_buff_0 = aie.buffer(%tile_1_4) {address = 11520 : i32, sym_name = "B_L2L1_1_2_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_1_2_cons_buff_1 = aie.buffer(%tile_1_4) {address = 13568 : i32, sym_name = "B_L2L1_1_2_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_1_2_cons_prod_lock_0 = aie.lock(%tile_1_4, 2) {init = 2 : i32, sym_name = "B_L2L1_1_2_cons_prod_lock_0"}
    %B_L2L1_1_2_cons_cons_lock_0 = aie.lock(%tile_1_4, 3) {init = 0 : i32, sym_name = "B_L2L1_1_2_cons_cons_lock_0"}
    %B_L2L1_1_3_cons_buff_0 = aie.buffer(%tile_1_5) {address = 11520 : i32, sym_name = "B_L2L1_1_3_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_1_3_cons_buff_1 = aie.buffer(%tile_1_5) {address = 13568 : i32, sym_name = "B_L2L1_1_3_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_1_3_cons_prod_lock_0 = aie.lock(%tile_1_5, 2) {init = 2 : i32, sym_name = "B_L2L1_1_3_cons_prod_lock_0"}
    %B_L2L1_1_3_cons_cons_lock_0 = aie.lock(%tile_1_5, 3) {init = 0 : i32, sym_name = "B_L2L1_1_3_cons_cons_lock_0"}
    %B_L3L2_1_cons_buff_0 = aie.buffer(%mem_tile_1_1) {address = 32768 : i32, sym_name = "B_L3L2_1_cons_buff_0"} : memref<1024xi16> 
    %B_L3L2_1_cons_buff_1 = aie.buffer(%mem_tile_1_1) {address = 34816 : i32, sym_name = "B_L3L2_1_cons_buff_1"} : memref<1024xi16> 
    %B_L3L2_1_cons_prod_lock_0 = aie.lock(%mem_tile_1_1, 2) {init = 2 : i32, sym_name = "B_L3L2_1_cons_prod_lock_0"}
    %B_L3L2_1_cons_cons_lock_0 = aie.lock(%mem_tile_1_1, 3) {init = 0 : i32, sym_name = "B_L3L2_1_cons_cons_lock_0"}
    %B_L3L2_1_prod_lock_0 = aie.lock(%shim_noc_tile_1_0, 2) {init = 1 : i32, sym_name = "B_L3L2_1_prod_lock_0"}
    %B_L3L2_1_cons_lock_0 = aie.lock(%shim_noc_tile_1_0, 3) {init = 0 : i32, sym_name = "B_L3L2_1_cons_lock_0"}
    %B_L2L1_0_0_cons_buff_0 = aie.buffer(%tile_0_2) {address = 11520 : i32, sym_name = "B_L2L1_0_0_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_0_0_cons_buff_1 = aie.buffer(%tile_0_2) {address = 13568 : i32, sym_name = "B_L2L1_0_0_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_0_0_cons_prod_lock_0 = aie.lock(%tile_0_2, 2) {init = 2 : i32, sym_name = "B_L2L1_0_0_cons_prod_lock_0"}
    %B_L2L1_0_0_cons_cons_lock_0 = aie.lock(%tile_0_2, 3) {init = 0 : i32, sym_name = "B_L2L1_0_0_cons_cons_lock_0"}
    %B_L2L1_0_1_cons_buff_0 = aie.buffer(%tile_0_3) {address = 11520 : i32, sym_name = "B_L2L1_0_1_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_0_1_cons_buff_1 = aie.buffer(%tile_0_3) {address = 13568 : i32, sym_name = "B_L2L1_0_1_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_0_1_cons_prod_lock_0 = aie.lock(%tile_0_3, 2) {init = 2 : i32, sym_name = "B_L2L1_0_1_cons_prod_lock_0"}
    %B_L2L1_0_1_cons_cons_lock_0 = aie.lock(%tile_0_3, 3) {init = 0 : i32, sym_name = "B_L2L1_0_1_cons_cons_lock_0"}
    %B_L2L1_0_2_cons_buff_0 = aie.buffer(%tile_0_4) {address = 11520 : i32, sym_name = "B_L2L1_0_2_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_0_2_cons_buff_1 = aie.buffer(%tile_0_4) {address = 13568 : i32, sym_name = "B_L2L1_0_2_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_0_2_cons_prod_lock_0 = aie.lock(%tile_0_4, 2) {init = 2 : i32, sym_name = "B_L2L1_0_2_cons_prod_lock_0"}
    %B_L2L1_0_2_cons_cons_lock_0 = aie.lock(%tile_0_4, 3) {init = 0 : i32, sym_name = "B_L2L1_0_2_cons_cons_lock_0"}
    %B_L2L1_0_3_cons_buff_0 = aie.buffer(%tile_0_5) {address = 11520 : i32, sym_name = "B_L2L1_0_3_cons_buff_0"} : memref<32x32xi16> 
    %B_L2L1_0_3_cons_buff_1 = aie.buffer(%tile_0_5) {address = 13568 : i32, sym_name = "B_L2L1_0_3_cons_buff_1"} : memref<32x32xi16> 
    %B_L2L1_0_3_cons_prod_lock_0 = aie.lock(%tile_0_5, 2) {init = 2 : i32, sym_name = "B_L2L1_0_3_cons_prod_lock_0"}
    %B_L2L1_0_3_cons_cons_lock_0 = aie.lock(%tile_0_5, 3) {init = 0 : i32, sym_name = "B_L2L1_0_3_cons_cons_lock_0"}
    %B_L3L2_0_cons_buff_0 = aie.buffer(%mem_tile_0_1) {address = 32768 : i32, sym_name = "B_L3L2_0_cons_buff_0"} : memref<1024xi16> 
    %B_L3L2_0_cons_buff_1 = aie.buffer(%mem_tile_0_1) {address = 34816 : i32, sym_name = "B_L3L2_0_cons_buff_1"} : memref<1024xi16> 
    %B_L3L2_0_cons_prod_lock_0 = aie.lock(%mem_tile_0_1, 2) {init = 2 : i32, sym_name = "B_L3L2_0_cons_prod_lock_0"}
    %B_L3L2_0_cons_cons_lock_0 = aie.lock(%mem_tile_0_1, 3) {init = 0 : i32, sym_name = "B_L3L2_0_cons_cons_lock_0"}
    %B_L3L2_0_prod_lock_0 = aie.lock(%shim_noc_tile_0_0, 2) {init = 1 : i32, sym_name = "B_L3L2_0_prod_lock_0"}
    %B_L3L2_0_cons_lock_0 = aie.lock(%shim_noc_tile_0_0, 3) {init = 0 : i32, sym_name = "B_L3L2_0_cons_lock_0"}
    %A_L2L1_3_0_cons_buff_0 = aie.buffer(%tile_0_5) {address = 15616 : i32, sym_name = "A_L2L1_3_0_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_3_0_cons_buff_1 = aie.buffer(%tile_0_5) {address = 17664 : i32, sym_name = "A_L2L1_3_0_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_3_0_cons_prod_lock_0 = aie.lock(%tile_0_5, 0) {init = 2 : i32, sym_name = "A_L2L1_3_0_cons_prod_lock_0"}
    %A_L2L1_3_0_cons_cons_lock_0 = aie.lock(%tile_0_5, 1) {init = 0 : i32, sym_name = "A_L2L1_3_0_cons_cons_lock_0"}
    %A_L2L1_3_1_cons_buff_0 = aie.buffer(%tile_1_5) {address = 15616 : i32, sym_name = "A_L2L1_3_1_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_3_1_cons_buff_1 = aie.buffer(%tile_1_5) {address = 17664 : i32, sym_name = "A_L2L1_3_1_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_3_1_cons_prod_lock_0 = aie.lock(%tile_1_5, 0) {init = 2 : i32, sym_name = "A_L2L1_3_1_cons_prod_lock_0"}
    %A_L2L1_3_1_cons_cons_lock_0 = aie.lock(%tile_1_5, 1) {init = 0 : i32, sym_name = "A_L2L1_3_1_cons_cons_lock_0"}
    %A_L2L1_3_2_cons_buff_0 = aie.buffer(%tile_2_5) {address = 15616 : i32, sym_name = "A_L2L1_3_2_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_3_2_cons_buff_1 = aie.buffer(%tile_2_5) {address = 17664 : i32, sym_name = "A_L2L1_3_2_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_3_2_cons_prod_lock_0 = aie.lock(%tile_2_5, 0) {init = 2 : i32, sym_name = "A_L2L1_3_2_cons_prod_lock_0"}
    %A_L2L1_3_2_cons_cons_lock_0 = aie.lock(%tile_2_5, 1) {init = 0 : i32, sym_name = "A_L2L1_3_2_cons_cons_lock_0"}
    %A_L2L1_3_3_cons_buff_0 = aie.buffer(%tile_3_5) {address = 15616 : i32, sym_name = "A_L2L1_3_3_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_3_3_cons_buff_1 = aie.buffer(%tile_3_5) {address = 17664 : i32, sym_name = "A_L2L1_3_3_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_3_3_cons_prod_lock_0 = aie.lock(%tile_3_5, 0) {init = 2 : i32, sym_name = "A_L2L1_3_3_cons_prod_lock_0"}
    %A_L2L1_3_3_cons_cons_lock_0 = aie.lock(%tile_3_5, 1) {init = 0 : i32, sym_name = "A_L2L1_3_3_cons_cons_lock_0"}
    %A_L2L1_2_0_cons_buff_0 = aie.buffer(%tile_0_4) {address = 15616 : i32, sym_name = "A_L2L1_2_0_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_2_0_cons_buff_1 = aie.buffer(%tile_0_4) {address = 17664 : i32, sym_name = "A_L2L1_2_0_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_2_0_cons_prod_lock_0 = aie.lock(%tile_0_4, 0) {init = 2 : i32, sym_name = "A_L2L1_2_0_cons_prod_lock_0"}
    %A_L2L1_2_0_cons_cons_lock_0 = aie.lock(%tile_0_4, 1) {init = 0 : i32, sym_name = "A_L2L1_2_0_cons_cons_lock_0"}
    %A_L2L1_2_1_cons_buff_0 = aie.buffer(%tile_1_4) {address = 15616 : i32, sym_name = "A_L2L1_2_1_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_2_1_cons_buff_1 = aie.buffer(%tile_1_4) {address = 17664 : i32, sym_name = "A_L2L1_2_1_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_2_1_cons_prod_lock_0 = aie.lock(%tile_1_4, 0) {init = 2 : i32, sym_name = "A_L2L1_2_1_cons_prod_lock_0"}
    %A_L2L1_2_1_cons_cons_lock_0 = aie.lock(%tile_1_4, 1) {init = 0 : i32, sym_name = "A_L2L1_2_1_cons_cons_lock_0"}
    %A_L2L1_2_2_cons_buff_0 = aie.buffer(%tile_2_4) {address = 15616 : i32, sym_name = "A_L2L1_2_2_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_2_2_cons_buff_1 = aie.buffer(%tile_2_4) {address = 17664 : i32, sym_name = "A_L2L1_2_2_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_2_2_cons_prod_lock_0 = aie.lock(%tile_2_4, 0) {init = 2 : i32, sym_name = "A_L2L1_2_2_cons_prod_lock_0"}
    %A_L2L1_2_2_cons_cons_lock_0 = aie.lock(%tile_2_4, 1) {init = 0 : i32, sym_name = "A_L2L1_2_2_cons_cons_lock_0"}
    %A_L2L1_2_3_cons_buff_0 = aie.buffer(%tile_3_4) {address = 15616 : i32, sym_name = "A_L2L1_2_3_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_2_3_cons_buff_1 = aie.buffer(%tile_3_4) {address = 17664 : i32, sym_name = "A_L2L1_2_3_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_2_3_cons_prod_lock_0 = aie.lock(%tile_3_4, 0) {init = 2 : i32, sym_name = "A_L2L1_2_3_cons_prod_lock_0"}
    %A_L2L1_2_3_cons_cons_lock_0 = aie.lock(%tile_3_4, 1) {init = 0 : i32, sym_name = "A_L2L1_2_3_cons_cons_lock_0"}
    %A_L2L1_1_0_cons_buff_0 = aie.buffer(%tile_0_3) {address = 15616 : i32, sym_name = "A_L2L1_1_0_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_1_0_cons_buff_1 = aie.buffer(%tile_0_3) {address = 17664 : i32, sym_name = "A_L2L1_1_0_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_1_0_cons_prod_lock_0 = aie.lock(%tile_0_3, 0) {init = 2 : i32, sym_name = "A_L2L1_1_0_cons_prod_lock_0"}
    %A_L2L1_1_0_cons_cons_lock_0 = aie.lock(%tile_0_3, 1) {init = 0 : i32, sym_name = "A_L2L1_1_0_cons_cons_lock_0"}
    %A_L2L1_1_1_cons_buff_0 = aie.buffer(%tile_1_3) {address = 15616 : i32, sym_name = "A_L2L1_1_1_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_1_1_cons_buff_1 = aie.buffer(%tile_1_3) {address = 17664 : i32, sym_name = "A_L2L1_1_1_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_1_1_cons_prod_lock_0 = aie.lock(%tile_1_3, 0) {init = 2 : i32, sym_name = "A_L2L1_1_1_cons_prod_lock_0"}
    %A_L2L1_1_1_cons_cons_lock_0 = aie.lock(%tile_1_3, 1) {init = 0 : i32, sym_name = "A_L2L1_1_1_cons_cons_lock_0"}
    %A_L2L1_1_2_cons_buff_0 = aie.buffer(%tile_2_3) {address = 15616 : i32, sym_name = "A_L2L1_1_2_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_1_2_cons_buff_1 = aie.buffer(%tile_2_3) {address = 17664 : i32, sym_name = "A_L2L1_1_2_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_1_2_cons_prod_lock_0 = aie.lock(%tile_2_3, 0) {init = 2 : i32, sym_name = "A_L2L1_1_2_cons_prod_lock_0"}
    %A_L2L1_1_2_cons_cons_lock_0 = aie.lock(%tile_2_3, 1) {init = 0 : i32, sym_name = "A_L2L1_1_2_cons_cons_lock_0"}
    %A_L2L1_1_3_cons_buff_0 = aie.buffer(%tile_3_3) {address = 15616 : i32, sym_name = "A_L2L1_1_3_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_1_3_cons_buff_1 = aie.buffer(%tile_3_3) {address = 17664 : i32, sym_name = "A_L2L1_1_3_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_1_3_cons_prod_lock_0 = aie.lock(%tile_3_3, 0) {init = 2 : i32, sym_name = "A_L2L1_1_3_cons_prod_lock_0"}
    %A_L2L1_1_3_cons_cons_lock_0 = aie.lock(%tile_3_3, 1) {init = 0 : i32, sym_name = "A_L2L1_1_3_cons_cons_lock_0"}
    %A_L2L1_0_0_cons_buff_0 = aie.buffer(%tile_0_2) {address = 15616 : i32, sym_name = "A_L2L1_0_0_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_0_0_cons_buff_1 = aie.buffer(%tile_0_2) {address = 17664 : i32, sym_name = "A_L2L1_0_0_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_0_0_cons_prod_lock_0 = aie.lock(%tile_0_2, 0) {init = 2 : i32, sym_name = "A_L2L1_0_0_cons_prod_lock_0"}
    %A_L2L1_0_0_cons_cons_lock_0 = aie.lock(%tile_0_2, 1) {init = 0 : i32, sym_name = "A_L2L1_0_0_cons_cons_lock_0"}
    %A_L2L1_0_1_cons_buff_0 = aie.buffer(%tile_1_2) {address = 15616 : i32, sym_name = "A_L2L1_0_1_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_0_1_cons_buff_1 = aie.buffer(%tile_1_2) {address = 17664 : i32, sym_name = "A_L2L1_0_1_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_0_1_cons_prod_lock_0 = aie.lock(%tile_1_2, 0) {init = 2 : i32, sym_name = "A_L2L1_0_1_cons_prod_lock_0"}
    %A_L2L1_0_1_cons_cons_lock_0 = aie.lock(%tile_1_2, 1) {init = 0 : i32, sym_name = "A_L2L1_0_1_cons_cons_lock_0"}
    %A_L2L1_0_2_cons_buff_0 = aie.buffer(%tile_2_2) {address = 15616 : i32, sym_name = "A_L2L1_0_2_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_0_2_cons_buff_1 = aie.buffer(%tile_2_2) {address = 17664 : i32, sym_name = "A_L2L1_0_2_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_0_2_cons_prod_lock_0 = aie.lock(%tile_2_2, 0) {init = 2 : i32, sym_name = "A_L2L1_0_2_cons_prod_lock_0"}
    %A_L2L1_0_2_cons_cons_lock_0 = aie.lock(%tile_2_2, 1) {init = 0 : i32, sym_name = "A_L2L1_0_2_cons_cons_lock_0"}
    %A_L2L1_0_3_cons_buff_0 = aie.buffer(%tile_3_2) {address = 15616 : i32, sym_name = "A_L2L1_0_3_cons_buff_0"} : memref<32x32xi16> 
    %A_L2L1_0_3_cons_buff_1 = aie.buffer(%tile_3_2) {address = 17664 : i32, sym_name = "A_L2L1_0_3_cons_buff_1"} : memref<32x32xi16> 
    %A_L2L1_0_3_cons_prod_lock_0 = aie.lock(%tile_3_2, 0) {init = 2 : i32, sym_name = "A_L2L1_0_3_cons_prod_lock_0"}
    %A_L2L1_0_3_cons_cons_lock_0 = aie.lock(%tile_3_2, 1) {init = 0 : i32, sym_name = "A_L2L1_0_3_cons_cons_lock_0"}
    %A_L3L2_3_cons_buff_0 = aie.buffer(%mem_tile_3_1) {address = 36864 : i32, sym_name = "A_L3L2_3_cons_buff_0"} : memref<1024xi16> 
    %A_L3L2_3_cons_buff_1 = aie.buffer(%mem_tile_3_1) {address = 38912 : i32, sym_name = "A_L3L2_3_cons_buff_1"} : memref<1024xi16> 
    %A_L3L2_3_cons_prod_lock_0 = aie.lock(%mem_tile_3_1, 0) {init = 2 : i32, sym_name = "A_L3L2_3_cons_prod_lock_0"}
    %A_L3L2_3_cons_cons_lock_0 = aie.lock(%mem_tile_3_1, 1) {init = 0 : i32, sym_name = "A_L3L2_3_cons_cons_lock_0"}
    %A_L3L2_3_prod_lock_0 = aie.lock(%shim_noc_tile_3_0, 0) {init = 1 : i32, sym_name = "A_L3L2_3_prod_lock_0"}
    %A_L3L2_3_cons_lock_0 = aie.lock(%shim_noc_tile_3_0, 1) {init = 0 : i32, sym_name = "A_L3L2_3_cons_lock_0"}
    %A_L3L2_2_cons_buff_0 = aie.buffer(%mem_tile_2_1) {address = 36864 : i32, sym_name = "A_L3L2_2_cons_buff_0"} : memref<1024xi16> 
    %A_L3L2_2_cons_buff_1 = aie.buffer(%mem_tile_2_1) {address = 38912 : i32, sym_name = "A_L3L2_2_cons_buff_1"} : memref<1024xi16> 
    %A_L3L2_2_cons_prod_lock_0 = aie.lock(%mem_tile_2_1, 0) {init = 2 : i32, sym_name = "A_L3L2_2_cons_prod_lock_0"}
    %A_L3L2_2_cons_cons_lock_0 = aie.lock(%mem_tile_2_1, 1) {init = 0 : i32, sym_name = "A_L3L2_2_cons_cons_lock_0"}
    %A_L3L2_2_prod_lock_0 = aie.lock(%shim_noc_tile_2_0, 0) {init = 1 : i32, sym_name = "A_L3L2_2_prod_lock_0"}
    %A_L3L2_2_cons_lock_0 = aie.lock(%shim_noc_tile_2_0, 1) {init = 0 : i32, sym_name = "A_L3L2_2_cons_lock_0"}
    %A_L3L2_1_cons_buff_0 = aie.buffer(%mem_tile_1_1) {address = 36864 : i32, sym_name = "A_L3L2_1_cons_buff_0"} : memref<1024xi16> 
    %A_L3L2_1_cons_buff_1 = aie.buffer(%mem_tile_1_1) {address = 38912 : i32, sym_name = "A_L3L2_1_cons_buff_1"} : memref<1024xi16> 
    %A_L3L2_1_cons_prod_lock_0 = aie.lock(%mem_tile_1_1, 0) {init = 2 : i32, sym_name = "A_L3L2_1_cons_prod_lock_0"}
    %A_L3L2_1_cons_cons_lock_0 = aie.lock(%mem_tile_1_1, 1) {init = 0 : i32, sym_name = "A_L3L2_1_cons_cons_lock_0"}
    %A_L3L2_1_prod_lock_0 = aie.lock(%shim_noc_tile_1_0, 0) {init = 1 : i32, sym_name = "A_L3L2_1_prod_lock_0"}
    %A_L3L2_1_cons_lock_0 = aie.lock(%shim_noc_tile_1_0, 1) {init = 0 : i32, sym_name = "A_L3L2_1_cons_lock_0"}
    %A_L3L2_0_cons_buff_0 = aie.buffer(%mem_tile_0_1) {address = 36864 : i32, sym_name = "A_L3L2_0_cons_buff_0"} : memref<1024xi16> 
    %A_L3L2_0_cons_buff_1 = aie.buffer(%mem_tile_0_1) {address = 38912 : i32, sym_name = "A_L3L2_0_cons_buff_1"} : memref<1024xi16> 
    %A_L3L2_0_cons_prod_lock_0 = aie.lock(%mem_tile_0_1, 0) {init = 2 : i32, sym_name = "A_L3L2_0_cons_prod_lock_0"}
    %A_L3L2_0_cons_cons_lock_0 = aie.lock(%mem_tile_0_1, 1) {init = 0 : i32, sym_name = "A_L3L2_0_cons_cons_lock_0"}
    %A_L3L2_0_prod_lock_0 = aie.lock(%shim_noc_tile_0_0, 0) {init = 1 : i32, sym_name = "A_L3L2_0_prod_lock_0"}
    %A_L3L2_0_cons_lock_0 = aie.lock(%shim_noc_tile_0_0, 1) {init = 0 : i32, sym_name = "A_L3L2_0_cons_lock_0"}
    aie.flow(%shim_noc_tile_0_0, DMA : 0, %mem_tile_0_1, DMA : 0)
    aie.flow(%shim_noc_tile_1_0, DMA : 0, %mem_tile_1_1, DMA : 0)
    aie.flow(%shim_noc_tile_2_0, DMA : 0, %mem_tile_2_1, DMA : 0)
    aie.flow(%shim_noc_tile_3_0, DMA : 0, %mem_tile_3_1, DMA : 0)
    aie.flow(%mem_tile_0_1, DMA : 0, %tile_3_2, DMA : 0)
    aie.flow(%mem_tile_0_1, DMA : 0, %tile_2_2, DMA : 0)
    aie.flow(%mem_tile_0_1, DMA : 0, %tile_1_2, DMA : 0)
    aie.flow(%mem_tile_0_1, DMA : 0, %tile_0_2, DMA : 0)
    aie.flow(%mem_tile_1_1, DMA : 0, %tile_3_3, DMA : 0)
    aie.flow(%mem_tile_1_1, DMA : 0, %tile_2_3, DMA : 0)
    aie.flow(%mem_tile_1_1, DMA : 0, %tile_1_3, DMA : 0)
    aie.flow(%mem_tile_1_1, DMA : 0, %tile_0_3, DMA : 0)
    aie.flow(%mem_tile_2_1, DMA : 0, %tile_3_4, DMA : 0)
    aie.flow(%mem_tile_2_1, DMA : 0, %tile_2_4, DMA : 0)
    aie.flow(%mem_tile_2_1, DMA : 0, %tile_1_4, DMA : 0)
    aie.flow(%mem_tile_2_1, DMA : 0, %tile_0_4, DMA : 0)
    aie.flow(%mem_tile_3_1, DMA : 0, %tile_3_5, DMA : 0)
    aie.flow(%mem_tile_3_1, DMA : 0, %tile_2_5, DMA : 0)
    aie.flow(%mem_tile_3_1, DMA : 0, %tile_1_5, DMA : 0)
    aie.flow(%mem_tile_3_1, DMA : 0, %tile_0_5, DMA : 0)
    aie.flow(%shim_noc_tile_0_0, DMA : 1, %mem_tile_0_1, DMA : 1)
    aie.flow(%mem_tile_0_1, DMA : 1, %tile_0_5, DMA : 1)
    aie.flow(%mem_tile_0_1, DMA : 1, %tile_0_4, DMA : 1)
    aie.flow(%mem_tile_0_1, DMA : 1, %tile_0_3, DMA : 1)
    aie.flow(%mem_tile_0_1, DMA : 1, %tile_0_2, DMA : 1)
    aie.flow(%shim_noc_tile_1_0, DMA : 1, %mem_tile_1_1, DMA : 1)
    aie.flow(%mem_tile_1_1, DMA : 1, %tile_1_5, DMA : 1)
    aie.flow(%mem_tile_1_1, DMA : 1, %tile_1_4, DMA : 1)
    aie.flow(%mem_tile_1_1, DMA : 1, %tile_1_3, DMA : 1)
    aie.flow(%mem_tile_1_1, DMA : 1, %tile_1_2, DMA : 1)
    aie.flow(%shim_noc_tile_2_0, DMA : 1, %mem_tile_2_1, DMA : 1)
    aie.flow(%mem_tile_2_1, DMA : 1, %tile_2_5, DMA : 1)
    aie.flow(%mem_tile_2_1, DMA : 1, %tile_2_4, DMA : 1)
    aie.flow(%mem_tile_2_1, DMA : 1, %tile_2_3, DMA : 1)
    aie.flow(%mem_tile_2_1, DMA : 1, %tile_2_2, DMA : 1)
    aie.flow(%shim_noc_tile_3_0, DMA : 1, %mem_tile_3_1, DMA : 1)
    aie.flow(%mem_tile_3_1, DMA : 1, %tile_3_5, DMA : 1)
    aie.flow(%mem_tile_3_1, DMA : 1, %tile_3_4, DMA : 1)
    aie.flow(%mem_tile_3_1, DMA : 1, %tile_3_3, DMA : 1)
    aie.flow(%mem_tile_3_1, DMA : 1, %tile_3_2, DMA : 1)
    aie.flow(%tile_0_2, DMA : 0, %mem_tile_0_1, DMA : 2)
    aie.flow(%tile_0_3, DMA : 0, %mem_tile_0_1, DMA : 3)
    aie.flow(%tile_0_4, DMA : 0, %mem_tile_0_1, DMA : 4)
    aie.flow(%tile_0_5, DMA : 0, %mem_tile_0_1, DMA : 5)
    aie.flow(%mem_tile_0_1, DMA : 2, %shim_noc_tile_0_0, DMA : 0)
    aie.flow(%tile_1_2, DMA : 0, %mem_tile_1_1, DMA : 2)
    aie.flow(%tile_1_3, DMA : 0, %mem_tile_1_1, DMA : 3)
    aie.flow(%tile_1_4, DMA : 0, %mem_tile_1_1, DMA : 4)
    aie.flow(%tile_1_5, DMA : 0, %mem_tile_1_1, DMA : 5)
    aie.flow(%mem_tile_1_1, DMA : 2, %shim_noc_tile_1_0, DMA : 0)
    aie.flow(%tile_2_2, DMA : 0, %mem_tile_2_1, DMA : 2)
    aie.flow(%tile_2_3, DMA : 0, %mem_tile_2_1, DMA : 3)
    aie.flow(%tile_2_4, DMA : 0, %mem_tile_2_1, DMA : 4)
    aie.flow(%tile_2_5, DMA : 0, %mem_tile_2_1, DMA : 5)
    aie.flow(%mem_tile_2_1, DMA : 2, %shim_noc_tile_2_0, DMA : 0)
    aie.flow(%tile_3_2, DMA : 0, %mem_tile_3_1, DMA : 2)
    aie.flow(%tile_3_3, DMA : 0, %mem_tile_3_1, DMA : 3)
    aie.flow(%tile_3_4, DMA : 0, %mem_tile_3_1, DMA : 4)
    aie.flow(%tile_3_5, DMA : 0, %mem_tile_3_1, DMA : 5)
    aie.flow(%mem_tile_3_1, DMA : 2, %shim_noc_tile_3_0, DMA : 0)
    %core_0_2 = aie.core(%tile_0_2) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_0_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_0_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_0_cons_buff_0, %B_L2L1_0_0_cons_buff_0, %C_L1L2_0_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_0_cons_buff_1, %B_L2L1_0_0_cons_buff_1, %C_L1L2_0_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_0_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_0_0_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_0_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_0_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_0_cons_buff_0, %B_L2L1_0_0_cons_buff_0, %C_L1L2_0_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_0_cons_buff_1, %B_L2L1_0_0_cons_buff_1, %C_L1L2_0_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_0_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_0_0_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_1_2 = aie.core(%tile_1_2) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_1_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_0_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_1_cons_buff_0, %B_L2L1_1_0_cons_buff_0, %C_L1L2_1_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_1_cons_buff_1, %B_L2L1_1_0_cons_buff_1, %C_L1L2_1_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_0_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_1_0_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_1_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_0_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_1_cons_buff_0, %B_L2L1_1_0_cons_buff_0, %C_L1L2_1_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_1_cons_buff_1, %B_L2L1_1_0_cons_buff_1, %C_L1L2_1_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_0_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_1_0_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_2_2 = aie.core(%tile_2_2) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_2_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_0_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_2_cons_buff_0, %B_L2L1_2_0_cons_buff_0, %C_L1L2_2_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_2_cons_buff_1, %B_L2L1_2_0_cons_buff_1, %C_L1L2_2_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_0_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_2_0_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_2_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_0_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_2_cons_buff_0, %B_L2L1_2_0_cons_buff_0, %C_L1L2_2_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_2_cons_buff_1, %B_L2L1_2_0_cons_buff_1, %C_L1L2_2_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_0_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_2_0_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_3_2 = aie.core(%tile_3_2) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_3_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_0_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_3_cons_buff_0, %B_L2L1_3_0_cons_buff_0, %C_L1L2_3_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_3_cons_buff_1, %B_L2L1_3_0_cons_buff_1, %C_L1L2_3_0_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_0_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_3_0_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_3_0_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_0_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_3_cons_buff_0, %B_L2L1_3_0_cons_buff_0, %C_L1L2_3_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_0_3_cons_buff_1, %B_L2L1_3_0_cons_buff_1, %C_L1L2_3_0_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_0_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_0_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_3_0_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_0_3 = aie.core(%tile_0_3) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_0_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_1_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_0_cons_buff_0, %B_L2L1_0_1_cons_buff_0, %C_L1L2_0_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_0_cons_buff_1, %B_L2L1_0_1_cons_buff_1, %C_L1L2_0_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_1_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_0_1_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_0_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_1_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_0_cons_buff_0, %B_L2L1_0_1_cons_buff_0, %C_L1L2_0_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_0_cons_buff_1, %B_L2L1_0_1_cons_buff_1, %C_L1L2_0_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_1_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_0_1_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_1_3 = aie.core(%tile_1_3) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_1_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_1_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_1_cons_buff_0, %B_L2L1_1_1_cons_buff_0, %C_L1L2_1_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_1_cons_buff_1, %B_L2L1_1_1_cons_buff_1, %C_L1L2_1_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_1_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_1_1_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_1_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_1_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_1_cons_buff_0, %B_L2L1_1_1_cons_buff_0, %C_L1L2_1_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_1_cons_buff_1, %B_L2L1_1_1_cons_buff_1, %C_L1L2_1_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_1_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_1_1_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_2_3 = aie.core(%tile_2_3) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_2_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_1_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_2_cons_buff_0, %B_L2L1_2_1_cons_buff_0, %C_L1L2_2_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_2_cons_buff_1, %B_L2L1_2_1_cons_buff_1, %C_L1L2_2_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_1_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_2_1_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_2_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_1_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_2_cons_buff_0, %B_L2L1_2_1_cons_buff_0, %C_L1L2_2_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_2_cons_buff_1, %B_L2L1_2_1_cons_buff_1, %C_L1L2_2_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_1_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_2_1_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_3_3 = aie.core(%tile_3_3) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_3_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_1_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_3_cons_buff_0, %B_L2L1_3_1_cons_buff_0, %C_L1L2_3_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_3_cons_buff_1, %B_L2L1_3_1_cons_buff_1, %C_L1L2_3_1_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_1_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_3_1_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_3_1_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_1_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_3_cons_buff_0, %B_L2L1_3_1_cons_buff_0, %C_L1L2_3_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_1_3_cons_buff_1, %B_L2L1_3_1_cons_buff_1, %C_L1L2_3_1_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_1_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_1_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_3_1_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_0_4 = aie.core(%tile_0_4) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_0_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_2_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_0_cons_buff_0, %B_L2L1_0_2_cons_buff_0, %C_L1L2_0_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_0_cons_buff_1, %B_L2L1_0_2_cons_buff_1, %C_L1L2_0_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_2_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_0_2_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_0_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_2_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_0_cons_buff_0, %B_L2L1_0_2_cons_buff_0, %C_L1L2_0_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_0_cons_buff_1, %B_L2L1_0_2_cons_buff_1, %C_L1L2_0_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_2_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_0_2_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_1_4 = aie.core(%tile_1_4) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_1_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_2_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_1_cons_buff_0, %B_L2L1_1_2_cons_buff_0, %C_L1L2_1_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_1_cons_buff_1, %B_L2L1_1_2_cons_buff_1, %C_L1L2_1_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_2_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_1_2_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_1_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_2_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_1_cons_buff_0, %B_L2L1_1_2_cons_buff_0, %C_L1L2_1_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_1_cons_buff_1, %B_L2L1_1_2_cons_buff_1, %C_L1L2_1_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_2_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_1_2_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_2_4 = aie.core(%tile_2_4) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_2_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_2_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_2_cons_buff_0, %B_L2L1_2_2_cons_buff_0, %C_L1L2_2_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_2_cons_buff_1, %B_L2L1_2_2_cons_buff_1, %C_L1L2_2_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_2_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_2_2_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_2_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_2_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_2_cons_buff_0, %B_L2L1_2_2_cons_buff_0, %C_L1L2_2_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_2_cons_buff_1, %B_L2L1_2_2_cons_buff_1, %C_L1L2_2_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_2_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_2_2_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_3_4 = aie.core(%tile_3_4) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_3_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_2_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_3_cons_buff_0, %B_L2L1_3_2_cons_buff_0, %C_L1L2_3_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_3_cons_buff_1, %B_L2L1_3_2_cons_buff_1, %C_L1L2_3_2_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_2_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_3_2_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_3_2_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_2_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_3_cons_buff_0, %B_L2L1_3_2_cons_buff_0, %C_L1L2_3_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_2_3_cons_buff_1, %B_L2L1_3_2_cons_buff_1, %C_L1L2_3_2_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_2_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_2_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_3_2_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_0_5 = aie.core(%tile_0_5) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_0_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_3_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_0_cons_buff_0, %B_L2L1_0_3_cons_buff_0, %C_L1L2_0_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_0_cons_buff_1, %B_L2L1_0_3_cons_buff_1, %C_L1L2_0_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_3_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_0_3_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_0_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_0_3_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_0_cons_buff_0, %B_L2L1_0_3_cons_buff_0, %C_L1L2_0_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_0_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_0_cons_buff_1, %B_L2L1_0_3_cons_buff_1, %C_L1L2_0_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_0_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_0_3_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_0_3_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_1_5 = aie.core(%tile_1_5) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_1_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_3_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_1_cons_buff_0, %B_L2L1_1_3_cons_buff_0, %C_L1L2_1_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_1_cons_buff_1, %B_L2L1_1_3_cons_buff_1, %C_L1L2_1_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_3_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_1_3_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_1_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_1_3_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_1_cons_buff_0, %B_L2L1_1_3_cons_buff_0, %C_L1L2_1_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_1_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_1_cons_buff_1, %B_L2L1_1_3_cons_buff_1, %C_L1L2_1_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_1_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_1_3_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_1_3_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_2_5 = aie.core(%tile_2_5) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_2_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_3_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_2_cons_buff_0, %B_L2L1_2_3_cons_buff_0, %C_L1L2_2_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_2_cons_buff_1, %B_L2L1_2_3_cons_buff_1, %C_L1L2_2_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_3_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_2_3_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_2_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_2_3_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_2_cons_buff_0, %B_L2L1_2_3_cons_buff_0, %C_L1L2_2_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_2_cons_buff_1, %B_L2L1_2_3_cons_buff_1, %C_L1L2_2_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_2_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_2_3_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_2_3_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    %core_3_5 = aie.core(%tile_3_5) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      cf.br ^bb1(%c0 : index)
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb11
      %1 = arith.cmpi slt, %0, %c4294967295 : index
      cf.cond_br %1, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %c0_0 = arith.constant 0 : index
      %c16 = arith.constant 16 : index
      %c1_1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      cf.br ^bb3(%c0_0 : index)
    ^bb3(%2: index):  // 2 preds: ^bb2, ^bb10
      %3 = arith.cmpi slt, %2, %c16 : index
      cf.cond_br %3, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      aie.use_lock(%C_L1L2_3_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_3_buff_0) : (memref<32x32xi32>) -> ()
      %c0_2 = arith.constant 0 : index
      %c16_3 = arith.constant 16 : index
      %c1_4 = arith.constant 1 : index
      %c2_5 = arith.constant 2 : index
      cf.br ^bb5(%c0_2 : index)
    ^bb5(%4: index):  // 2 preds: ^bb4, ^bb6
      %5 = arith.cmpi slt, %4, %c16_3 : index
      cf.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      aie.use_lock(%A_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_3_cons_buff_0, %B_L2L1_3_3_cons_buff_0, %C_L1L2_3_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_3_cons_buff_1, %B_L2L1_3_3_cons_buff_1, %C_L1L2_3_3_buff_0) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_3_cons_prod_lock_0, Release, 1)
      %6 = arith.addi %4, %c2_5 : index
      cf.br ^bb5(%6 : index)
    ^bb7:  // pred: ^bb5
      aie.use_lock(%C_L1L2_3_3_cons_lock_0, Release, 1)
      aie.use_lock(%C_L1L2_3_3_prod_lock_0, AcquireGreaterEqual, 1)
      func.call @zero_i32(%C_L1L2_3_3_buff_1) : (memref<32x32xi32>) -> ()
      %c0_6 = arith.constant 0 : index
      %c16_7 = arith.constant 16 : index
      %c1_8 = arith.constant 1 : index
      %c2_9 = arith.constant 2 : index
      cf.br ^bb8(%c0_6 : index)
    ^bb8(%7: index):  // 2 preds: ^bb7, ^bb9
      %8 = arith.cmpi slt, %7, %c16_7 : index
      cf.cond_br %8, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      aie.use_lock(%A_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_3_cons_buff_0, %B_L2L1_3_3_cons_buff_0, %C_L1L2_3_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%A_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.use_lock(%B_L2L1_3_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      func.call @matmul_i16_i32(%A_L2L1_3_3_cons_buff_1, %B_L2L1_3_3_cons_buff_1, %C_L1L2_3_3_buff_1) : (memref<32x32xi16>, memref<32x32xi16>, memref<32x32xi32>) -> ()
      aie.use_lock(%A_L2L1_3_3_cons_prod_lock_0, Release, 1)
      aie.use_lock(%B_L2L1_3_3_cons_prod_lock_0, Release, 1)
      %9 = arith.addi %7, %c2_9 : index
      cf.br ^bb8(%9 : index)
    ^bb10:  // pred: ^bb8
      aie.use_lock(%C_L1L2_3_3_cons_lock_0, Release, 1)
      %10 = arith.addi %2, %c2 : index
      cf.br ^bb3(%10 : index)
    ^bb11:  // pred: ^bb3
      %11 = arith.addi %0, %c1 : index
      cf.br ^bb1(%11 : index)
    ^bb12:  // pred: ^bb1
      aie.end
    } {link_with = "mm_32x32x32.o", stack_size = 3328 : i32}
    aiex.runtime_sequence @sequence(%arg0: memref<262144xi16>, %arg1: memref<262144xi16>, %arg2: memref<262144xi32>) {
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 0][2, 4, 128, 32][65536, 128, 512, 1]) {id = 0 : i64, metadata = @C_L2L3_0} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 0][4, 16, 32, 32][0, 32, 512, 1]) {id = 1 : i64, metadata = @A_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 0][4, 16, 32, 32][128, 16384, 512, 1]) {id = 2 : i64, metadata = @B_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 65536][4, 16, 32, 32][0, 32, 512, 1]) {id = 3 : i64, metadata = @A_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 0][4, 16, 32, 32][128, 16384, 512, 1]) {id = 4 : i64, metadata = @B_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 32][2, 4, 128, 32][65536, 128, 512, 1]) {id = 0 : i64, metadata = @C_L2L3_1} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 16384][4, 16, 32, 32][0, 32, 512, 1]) {id = 1 : i64, metadata = @A_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 32][4, 16, 32, 32][128, 16384, 512, 1]) {id = 2 : i64, metadata = @B_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 81920][4, 16, 32, 32][0, 32, 512, 1]) {id = 3 : i64, metadata = @A_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 32][4, 16, 32, 32][128, 16384, 512, 1]) {id = 4 : i64, metadata = @B_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 64][2, 4, 128, 32][65536, 128, 512, 1]) {id = 0 : i64, metadata = @C_L2L3_2} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 32768][4, 16, 32, 32][0, 32, 512, 1]) {id = 1 : i64, metadata = @A_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 64][4, 16, 32, 32][128, 16384, 512, 1]) {id = 2 : i64, metadata = @B_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 98304][4, 16, 32, 32][0, 32, 512, 1]) {id = 3 : i64, metadata = @A_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 64][4, 16, 32, 32][128, 16384, 512, 1]) {id = 4 : i64, metadata = @B_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 96][2, 4, 128, 32][65536, 128, 512, 1]) {id = 0 : i64, metadata = @C_L2L3_3} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 49152][4, 16, 32, 32][0, 32, 512, 1]) {id = 1 : i64, metadata = @A_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 96][4, 16, 32, 32][128, 16384, 512, 1]) {id = 2 : i64, metadata = @B_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 114688][4, 16, 32, 32][0, 32, 512, 1]) {id = 3 : i64, metadata = @A_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 96][4, 16, 32, 32][128, 16384, 512, 1]) {id = 4 : i64, metadata = @B_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 131072][2, 4, 128, 32][65536, 128, 512, 1]) {id = 8 : i64, metadata = @C_L2L3_0} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 131072][4, 16, 32, 32][0, 32, 512, 1]) {id = 9 : i64, metadata = @A_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 0][4, 16, 32, 32][128, 16384, 512, 1]) {id = 10 : i64, metadata = @B_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 196608][4, 16, 32, 32][0, 32, 512, 1]) {id = 11 : i64, metadata = @A_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 0][4, 16, 32, 32][128, 16384, 512, 1]) {id = 12 : i64, metadata = @B_L3L2_0} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 131104][2, 4, 128, 32][65536, 128, 512, 1]) {id = 8 : i64, metadata = @C_L2L3_1} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 147456][4, 16, 32, 32][0, 32, 512, 1]) {id = 9 : i64, metadata = @A_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 32][4, 16, 32, 32][128, 16384, 512, 1]) {id = 10 : i64, metadata = @B_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 212992][4, 16, 32, 32][0, 32, 512, 1]) {id = 11 : i64, metadata = @A_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 32][4, 16, 32, 32][128, 16384, 512, 1]) {id = 12 : i64, metadata = @B_L3L2_1} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 131136][2, 4, 128, 32][65536, 128, 512, 1]) {id = 8 : i64, metadata = @C_L2L3_2} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 163840][4, 16, 32, 32][0, 32, 512, 1]) {id = 9 : i64, metadata = @A_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 64][4, 16, 32, 32][128, 16384, 512, 1]) {id = 10 : i64, metadata = @B_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 229376][4, 16, 32, 32][0, 32, 512, 1]) {id = 11 : i64, metadata = @A_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 64][4, 16, 32, 32][128, 16384, 512, 1]) {id = 12 : i64, metadata = @B_L3L2_2} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg2[0, 0, 0, 131168][2, 4, 128, 32][65536, 128, 512, 1]) {id = 8 : i64, metadata = @C_L2L3_3} : memref<262144xi32>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 180224][4, 16, 32, 32][0, 32, 512, 1]) {id = 9 : i64, metadata = @A_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 96][4, 16, 32, 32][128, 16384, 512, 1]) {id = 10 : i64, metadata = @B_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg0[0, 0, 0, 245760][4, 16, 32, 32][0, 32, 512, 1]) {id = 11 : i64, metadata = @A_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_memcpy_nd(%arg1[0, 0, 0, 96][4, 16, 32, 32][128, 16384, 512, 1]) {id = 12 : i64, metadata = @B_L3L2_3} : memref<262144xi16>
      aiex.npu.dma_wait {symbol = @C_L2L3_0}
      aiex.npu.dma_wait {symbol = @C_L2L3_1}
      aiex.npu.dma_wait {symbol = @C_L2L3_2}
      aiex.npu.dma_wait {symbol = @C_L2L3_3}
      aiex.npu.dma_wait {symbol = @C_L2L3_0}
      aiex.npu.dma_wait {symbol = @C_L2L3_1}
      aiex.npu.dma_wait {symbol = @C_L2L3_2}
      aiex.npu.dma_wait {symbol = @C_L2L3_3}
    }
    aie.shim_dma_allocation @A_L3L2_0(MM2S, 0, 0)
    %memtile_dma_0_1 = aie.memtile_dma(%mem_tile_0_1) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L3L2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_0_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L3L2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L3L2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_0_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L3L2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%A_L3L2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_0_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%A_L3L2_0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%A_L3L2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_0_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%A_L3L2_0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(S2MM, 1, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%B_L3L2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_0_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 24 : i32, next_bd_id = 25 : i32}
      aie.use_lock(%B_L3L2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%B_L3L2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_0_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 25 : i32, next_bd_id = 24 : i32}
      aie.use_lock(%B_L3L2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      %3 = aie.dma_start(MM2S, 1, ^bb10, ^bb12)
    ^bb10:  // 2 preds: ^bb9, ^bb11
      aie.use_lock(%B_L3L2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_0_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 26 : i32, next_bd_id = 27 : i32}
      aie.use_lock(%B_L3L2_0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb11
    ^bb11:  // pred: ^bb10
      aie.use_lock(%B_L3L2_0_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_0_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 27 : i32, next_bd_id = 26 : i32}
      aie.use_lock(%B_L3L2_0_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb10
    ^bb12:  // pred: ^bb9
      %4 = aie.dma_start(S2MM, 2, ^bb13, ^bb15)
    ^bb13:  // 2 preds: ^bb12, ^bb14
      aie.use_lock(%C_L2L3_0_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_0, Release, 1)
      aie.next_bd ^bb14
    ^bb14:  // pred: ^bb13
      aie.use_lock(%C_L2L3_0_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_0, Release, 1)
      aie.next_bd ^bb13
    ^bb15:  // pred: ^bb12
      %5 = aie.dma_start(S2MM, 3, ^bb16, ^bb18)
    ^bb16:  // 2 preds: ^bb15, ^bb17
      aie.use_lock(%C_L2L3_0_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 1024, 1024) {bd_id = 28 : i32, next_bd_id = 29 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_1, Release, 1)
      aie.next_bd ^bb17
    ^bb17:  // pred: ^bb16
      aie.use_lock(%C_L2L3_0_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 1024, 1024) {bd_id = 29 : i32, next_bd_id = 28 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_1, Release, 1)
      aie.next_bd ^bb16
    ^bb18:  // pred: ^bb15
      %6 = aie.dma_start(S2MM, 4, ^bb19, ^bb21)
    ^bb19:  // 2 preds: ^bb18, ^bb20
      aie.use_lock(%C_L2L3_0_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 2048, 1024) {bd_id = 6 : i32, next_bd_id = 7 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_2, Release, 1)
      aie.next_bd ^bb20
    ^bb20:  // pred: ^bb19
      aie.use_lock(%C_L2L3_0_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 2048, 1024) {bd_id = 7 : i32, next_bd_id = 6 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_2, Release, 1)
      aie.next_bd ^bb19
    ^bb21:  // pred: ^bb18
      %7 = aie.dma_start(S2MM, 5, ^bb22, ^bb24)
    ^bb22:  // 2 preds: ^bb21, ^bb23
      aie.use_lock(%C_L2L3_0_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 3072, 1024) {bd_id = 30 : i32, next_bd_id = 31 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_3, Release, 1)
      aie.next_bd ^bb23
    ^bb23:  // pred: ^bb22
      aie.use_lock(%C_L2L3_0_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 3072, 1024) {bd_id = 31 : i32, next_bd_id = 30 : i32}
      aie.use_lock(%C_L2L3_0_cons_lock_3, Release, 1)
      aie.next_bd ^bb22
    ^bb24:  // pred: ^bb21
      %8 = aie.dma_start(MM2S, 2, ^bb25, ^bb33)
    ^bb25:  // 2 preds: ^bb24, ^bb32
      aie.use_lock(%C_L2L3_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 8 : i32, next_bd_id = 9 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb26
    ^bb26:  // pred: ^bb25
      aie.use_lock(%C_L2L3_0_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 9 : i32, next_bd_id = 10 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_1, Release, 1)
      aie.next_bd ^bb27
    ^bb27:  // pred: ^bb26
      aie.use_lock(%C_L2L3_0_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 10 : i32, next_bd_id = 11 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_2, Release, 1)
      aie.next_bd ^bb28
    ^bb28:  // pred: ^bb27
      aie.use_lock(%C_L2L3_0_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_0 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 11 : i32, next_bd_id = 12 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_3, Release, 1)
      aie.next_bd ^bb29
    ^bb29:  // pred: ^bb28
      aie.use_lock(%C_L2L3_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 12 : i32, next_bd_id = 13 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb30
    ^bb30:  // pred: ^bb29
      aie.use_lock(%C_L2L3_0_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 13 : i32, next_bd_id = 14 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_1, Release, 1)
      aie.next_bd ^bb31
    ^bb31:  // pred: ^bb30
      aie.use_lock(%C_L2L3_0_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 14 : i32, next_bd_id = 15 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_2, Release, 1)
      aie.next_bd ^bb32
    ^bb32:  // pred: ^bb31
      aie.use_lock(%C_L2L3_0_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_0_buff_1 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 15 : i32, next_bd_id = 8 : i32}
      aie.use_lock(%C_L2L3_0_prod_lock_3, Release, 1)
      aie.next_bd ^bb25
    ^bb33:  // pred: ^bb24
      aie.end
    }
    aie.shim_dma_allocation @A_L3L2_1(MM2S, 0, 1)
    %memtile_dma_1_1 = aie.memtile_dma(%mem_tile_1_1) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L3L2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_1_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L3L2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L3L2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_1_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L3L2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%A_L3L2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_1_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%A_L3L2_1_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%A_L3L2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_1_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%A_L3L2_1_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(S2MM, 1, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%B_L3L2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_1_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 24 : i32, next_bd_id = 25 : i32}
      aie.use_lock(%B_L3L2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%B_L3L2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_1_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 25 : i32, next_bd_id = 24 : i32}
      aie.use_lock(%B_L3L2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      %3 = aie.dma_start(MM2S, 1, ^bb10, ^bb12)
    ^bb10:  // 2 preds: ^bb9, ^bb11
      aie.use_lock(%B_L3L2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_1_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 26 : i32, next_bd_id = 27 : i32}
      aie.use_lock(%B_L3L2_1_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb11
    ^bb11:  // pred: ^bb10
      aie.use_lock(%B_L3L2_1_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_1_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 27 : i32, next_bd_id = 26 : i32}
      aie.use_lock(%B_L3L2_1_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb10
    ^bb12:  // pred: ^bb9
      %4 = aie.dma_start(S2MM, 2, ^bb13, ^bb15)
    ^bb13:  // 2 preds: ^bb12, ^bb14
      aie.use_lock(%C_L2L3_1_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_0, Release, 1)
      aie.next_bd ^bb14
    ^bb14:  // pred: ^bb13
      aie.use_lock(%C_L2L3_1_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_0, Release, 1)
      aie.next_bd ^bb13
    ^bb15:  // pred: ^bb12
      %5 = aie.dma_start(S2MM, 3, ^bb16, ^bb18)
    ^bb16:  // 2 preds: ^bb15, ^bb17
      aie.use_lock(%C_L2L3_1_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 1024, 1024) {bd_id = 28 : i32, next_bd_id = 29 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_1, Release, 1)
      aie.next_bd ^bb17
    ^bb17:  // pred: ^bb16
      aie.use_lock(%C_L2L3_1_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 1024, 1024) {bd_id = 29 : i32, next_bd_id = 28 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_1, Release, 1)
      aie.next_bd ^bb16
    ^bb18:  // pred: ^bb15
      %6 = aie.dma_start(S2MM, 4, ^bb19, ^bb21)
    ^bb19:  // 2 preds: ^bb18, ^bb20
      aie.use_lock(%C_L2L3_1_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 2048, 1024) {bd_id = 6 : i32, next_bd_id = 7 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_2, Release, 1)
      aie.next_bd ^bb20
    ^bb20:  // pred: ^bb19
      aie.use_lock(%C_L2L3_1_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 2048, 1024) {bd_id = 7 : i32, next_bd_id = 6 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_2, Release, 1)
      aie.next_bd ^bb19
    ^bb21:  // pred: ^bb18
      %7 = aie.dma_start(S2MM, 5, ^bb22, ^bb24)
    ^bb22:  // 2 preds: ^bb21, ^bb23
      aie.use_lock(%C_L2L3_1_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 3072, 1024) {bd_id = 30 : i32, next_bd_id = 31 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_3, Release, 1)
      aie.next_bd ^bb23
    ^bb23:  // pred: ^bb22
      aie.use_lock(%C_L2L3_1_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 3072, 1024) {bd_id = 31 : i32, next_bd_id = 30 : i32}
      aie.use_lock(%C_L2L3_1_cons_lock_3, Release, 1)
      aie.next_bd ^bb22
    ^bb24:  // pred: ^bb21
      %8 = aie.dma_start(MM2S, 2, ^bb25, ^bb33)
    ^bb25:  // 2 preds: ^bb24, ^bb32
      aie.use_lock(%C_L2L3_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 8 : i32, next_bd_id = 9 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb26
    ^bb26:  // pred: ^bb25
      aie.use_lock(%C_L2L3_1_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 9 : i32, next_bd_id = 10 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_1, Release, 1)
      aie.next_bd ^bb27
    ^bb27:  // pred: ^bb26
      aie.use_lock(%C_L2L3_1_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 10 : i32, next_bd_id = 11 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_2, Release, 1)
      aie.next_bd ^bb28
    ^bb28:  // pred: ^bb27
      aie.use_lock(%C_L2L3_1_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_0 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 11 : i32, next_bd_id = 12 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_3, Release, 1)
      aie.next_bd ^bb29
    ^bb29:  // pred: ^bb28
      aie.use_lock(%C_L2L3_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 12 : i32, next_bd_id = 13 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb30
    ^bb30:  // pred: ^bb29
      aie.use_lock(%C_L2L3_1_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 13 : i32, next_bd_id = 14 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_1, Release, 1)
      aie.next_bd ^bb31
    ^bb31:  // pred: ^bb30
      aie.use_lock(%C_L2L3_1_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 14 : i32, next_bd_id = 15 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_2, Release, 1)
      aie.next_bd ^bb32
    ^bb32:  // pred: ^bb31
      aie.use_lock(%C_L2L3_1_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_1_buff_1 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 15 : i32, next_bd_id = 8 : i32}
      aie.use_lock(%C_L2L3_1_prod_lock_3, Release, 1)
      aie.next_bd ^bb25
    ^bb33:  // pred: ^bb24
      aie.end
    }
    aie.shim_dma_allocation @A_L3L2_2(MM2S, 0, 2)
    %memtile_dma_2_1 = aie.memtile_dma(%mem_tile_2_1) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L3L2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_2_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L3L2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L3L2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_2_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L3L2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%A_L3L2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_2_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%A_L3L2_2_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%A_L3L2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_2_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%A_L3L2_2_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(S2MM, 1, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%B_L3L2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_2_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 24 : i32, next_bd_id = 25 : i32}
      aie.use_lock(%B_L3L2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%B_L3L2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_2_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 25 : i32, next_bd_id = 24 : i32}
      aie.use_lock(%B_L3L2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      %3 = aie.dma_start(MM2S, 1, ^bb10, ^bb12)
    ^bb10:  // 2 preds: ^bb9, ^bb11
      aie.use_lock(%B_L3L2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_2_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 26 : i32, next_bd_id = 27 : i32}
      aie.use_lock(%B_L3L2_2_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb11
    ^bb11:  // pred: ^bb10
      aie.use_lock(%B_L3L2_2_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_2_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 27 : i32, next_bd_id = 26 : i32}
      aie.use_lock(%B_L3L2_2_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb10
    ^bb12:  // pred: ^bb9
      %4 = aie.dma_start(S2MM, 2, ^bb13, ^bb15)
    ^bb13:  // 2 preds: ^bb12, ^bb14
      aie.use_lock(%C_L2L3_2_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_0, Release, 1)
      aie.next_bd ^bb14
    ^bb14:  // pred: ^bb13
      aie.use_lock(%C_L2L3_2_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_0, Release, 1)
      aie.next_bd ^bb13
    ^bb15:  // pred: ^bb12
      %5 = aie.dma_start(S2MM, 3, ^bb16, ^bb18)
    ^bb16:  // 2 preds: ^bb15, ^bb17
      aie.use_lock(%C_L2L3_2_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 1024, 1024) {bd_id = 28 : i32, next_bd_id = 29 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_1, Release, 1)
      aie.next_bd ^bb17
    ^bb17:  // pred: ^bb16
      aie.use_lock(%C_L2L3_2_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 1024, 1024) {bd_id = 29 : i32, next_bd_id = 28 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_1, Release, 1)
      aie.next_bd ^bb16
    ^bb18:  // pred: ^bb15
      %6 = aie.dma_start(S2MM, 4, ^bb19, ^bb21)
    ^bb19:  // 2 preds: ^bb18, ^bb20
      aie.use_lock(%C_L2L3_2_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 2048, 1024) {bd_id = 6 : i32, next_bd_id = 7 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_2, Release, 1)
      aie.next_bd ^bb20
    ^bb20:  // pred: ^bb19
      aie.use_lock(%C_L2L3_2_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 2048, 1024) {bd_id = 7 : i32, next_bd_id = 6 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_2, Release, 1)
      aie.next_bd ^bb19
    ^bb21:  // pred: ^bb18
      %7 = aie.dma_start(S2MM, 5, ^bb22, ^bb24)
    ^bb22:  // 2 preds: ^bb21, ^bb23
      aie.use_lock(%C_L2L3_2_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 3072, 1024) {bd_id = 30 : i32, next_bd_id = 31 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_3, Release, 1)
      aie.next_bd ^bb23
    ^bb23:  // pred: ^bb22
      aie.use_lock(%C_L2L3_2_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 3072, 1024) {bd_id = 31 : i32, next_bd_id = 30 : i32}
      aie.use_lock(%C_L2L3_2_cons_lock_3, Release, 1)
      aie.next_bd ^bb22
    ^bb24:  // pred: ^bb21
      %8 = aie.dma_start(MM2S, 2, ^bb25, ^bb33)
    ^bb25:  // 2 preds: ^bb24, ^bb32
      aie.use_lock(%C_L2L3_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 8 : i32, next_bd_id = 9 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb26
    ^bb26:  // pred: ^bb25
      aie.use_lock(%C_L2L3_2_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 9 : i32, next_bd_id = 10 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_1, Release, 1)
      aie.next_bd ^bb27
    ^bb27:  // pred: ^bb26
      aie.use_lock(%C_L2L3_2_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 10 : i32, next_bd_id = 11 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_2, Release, 1)
      aie.next_bd ^bb28
    ^bb28:  // pred: ^bb27
      aie.use_lock(%C_L2L3_2_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_0 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 11 : i32, next_bd_id = 12 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_3, Release, 1)
      aie.next_bd ^bb29
    ^bb29:  // pred: ^bb28
      aie.use_lock(%C_L2L3_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 12 : i32, next_bd_id = 13 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb30
    ^bb30:  // pred: ^bb29
      aie.use_lock(%C_L2L3_2_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 13 : i32, next_bd_id = 14 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_1, Release, 1)
      aie.next_bd ^bb31
    ^bb31:  // pred: ^bb30
      aie.use_lock(%C_L2L3_2_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 14 : i32, next_bd_id = 15 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_2, Release, 1)
      aie.next_bd ^bb32
    ^bb32:  // pred: ^bb31
      aie.use_lock(%C_L2L3_2_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_2_buff_1 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 15 : i32, next_bd_id = 8 : i32}
      aie.use_lock(%C_L2L3_2_prod_lock_3, Release, 1)
      aie.next_bd ^bb25
    ^bb33:  // pred: ^bb24
      aie.end
    }
    aie.shim_dma_allocation @A_L3L2_3(MM2S, 0, 3)
    %memtile_dma_3_1 = aie.memtile_dma(%mem_tile_3_1) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L3L2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_3_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L3L2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L3L2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_3_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L3L2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(MM2S, 0, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%A_L3L2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_3_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%A_L3L2_3_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%A_L3L2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L3L2_3_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 8, stride = 4>, <size = 4, stride = 32>, <size = 4, stride = 1>]) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%A_L3L2_3_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(S2MM, 1, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%B_L3L2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_3_cons_buff_0 : memref<1024xi16>, 0, 1024) {bd_id = 24 : i32, next_bd_id = 25 : i32}
      aie.use_lock(%B_L3L2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%B_L3L2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_3_cons_buff_1 : memref<1024xi16>, 0, 1024) {bd_id = 25 : i32, next_bd_id = 24 : i32}
      aie.use_lock(%B_L3L2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      %3 = aie.dma_start(MM2S, 1, ^bb10, ^bb12)
    ^bb10:  // 2 preds: ^bb9, ^bb11
      aie.use_lock(%B_L3L2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_3_cons_buff_0 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 26 : i32, next_bd_id = 27 : i32}
      aie.use_lock(%B_L3L2_3_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb11
    ^bb11:  // pred: ^bb10
      aie.use_lock(%B_L3L2_3_cons_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L3L2_3_cons_buff_1 : memref<1024xi16>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 27 : i32, next_bd_id = 26 : i32}
      aie.use_lock(%B_L3L2_3_cons_prod_lock_0, Release, 1)
      aie.next_bd ^bb10
    ^bb12:  // pred: ^bb9
      %4 = aie.dma_start(S2MM, 2, ^bb13, ^bb15)
    ^bb13:  // 2 preds: ^bb12, ^bb14
      aie.use_lock(%C_L2L3_3_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_0, Release, 1)
      aie.next_bd ^bb14
    ^bb14:  // pred: ^bb13
      aie.use_lock(%C_L2L3_3_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_0, Release, 1)
      aie.next_bd ^bb13
    ^bb15:  // pred: ^bb12
      %5 = aie.dma_start(S2MM, 3, ^bb16, ^bb18)
    ^bb16:  // 2 preds: ^bb15, ^bb17
      aie.use_lock(%C_L2L3_3_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 1024, 1024) {bd_id = 28 : i32, next_bd_id = 29 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_1, Release, 1)
      aie.next_bd ^bb17
    ^bb17:  // pred: ^bb16
      aie.use_lock(%C_L2L3_3_prod_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 1024, 1024) {bd_id = 29 : i32, next_bd_id = 28 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_1, Release, 1)
      aie.next_bd ^bb16
    ^bb18:  // pred: ^bb15
      %6 = aie.dma_start(S2MM, 4, ^bb19, ^bb21)
    ^bb19:  // 2 preds: ^bb18, ^bb20
      aie.use_lock(%C_L2L3_3_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 2048, 1024) {bd_id = 6 : i32, next_bd_id = 7 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_2, Release, 1)
      aie.next_bd ^bb20
    ^bb20:  // pred: ^bb19
      aie.use_lock(%C_L2L3_3_prod_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 2048, 1024) {bd_id = 7 : i32, next_bd_id = 6 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_2, Release, 1)
      aie.next_bd ^bb19
    ^bb21:  // pred: ^bb18
      %7 = aie.dma_start(S2MM, 5, ^bb22, ^bb24)
    ^bb22:  // 2 preds: ^bb21, ^bb23
      aie.use_lock(%C_L2L3_3_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 3072, 1024) {bd_id = 30 : i32, next_bd_id = 31 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_3, Release, 1)
      aie.next_bd ^bb23
    ^bb23:  // pred: ^bb22
      aie.use_lock(%C_L2L3_3_prod_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 3072, 1024) {bd_id = 31 : i32, next_bd_id = 30 : i32}
      aie.use_lock(%C_L2L3_3_cons_lock_3, Release, 1)
      aie.next_bd ^bb22
    ^bb24:  // pred: ^bb21
      %8 = aie.dma_start(MM2S, 2, ^bb25, ^bb33)
    ^bb25:  // 2 preds: ^bb24, ^bb32
      aie.use_lock(%C_L2L3_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 8 : i32, next_bd_id = 9 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb26
    ^bb26:  // pred: ^bb25
      aie.use_lock(%C_L2L3_3_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 9 : i32, next_bd_id = 10 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_1, Release, 1)
      aie.next_bd ^bb27
    ^bb27:  // pred: ^bb26
      aie.use_lock(%C_L2L3_3_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 10 : i32, next_bd_id = 11 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_2, Release, 1)
      aie.next_bd ^bb28
    ^bb28:  // pred: ^bb27
      aie.use_lock(%C_L2L3_3_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_0 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 11 : i32, next_bd_id = 12 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_3, Release, 1)
      aie.next_bd ^bb29
    ^bb29:  // pred: ^bb28
      aie.use_lock(%C_L2L3_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 0, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 12 : i32, next_bd_id = 13 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb30
    ^bb30:  // pred: ^bb29
      aie.use_lock(%C_L2L3_3_cons_lock_1, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 1024, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 13 : i32, next_bd_id = 14 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_1, Release, 1)
      aie.next_bd ^bb31
    ^bb31:  // pred: ^bb30
      aie.use_lock(%C_L2L3_3_cons_lock_2, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 2048, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 14 : i32, next_bd_id = 15 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_2, Release, 1)
      aie.next_bd ^bb32
    ^bb32:  // pred: ^bb31
      aie.use_lock(%C_L2L3_3_cons_lock_3, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L2L3_3_buff_1 : memref<4096xi32>, 3072, 1024, [<size = 8, stride = 128>, <size = 4, stride = 8>, <size = 4, stride = 32>, <size = 8, stride = 1>]) {bd_id = 15 : i32, next_bd_id = 8 : i32}
      aie.use_lock(%C_L2L3_3_prod_lock_3, Release, 1)
      aie.next_bd ^bb25
    ^bb33:  // pred: ^bb24
      aie.end
    }
    %mem_0_2 = aie.mem(%tile_0_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_0_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_0_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_0_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_0_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_0_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_0_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_0_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_0_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_0_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_0_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_0_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_0_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_0_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_0_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_1_2 = aie.mem(%tile_1_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_0_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_0_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_0_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_0_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_1_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_1_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_1_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_1_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_1_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_0_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_1_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_1_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_0_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_1_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_2_2 = aie.mem(%tile_2_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_0_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_0_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_0_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_0_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_2_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_0_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_2_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_2_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_0_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_2_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_3_2 = aie.mem(%tile_3_2) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_0_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_0_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_0_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_0_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_0_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_3_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_3_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_3_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_3_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_3_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_0_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_3_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_3_0_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_0_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_3_0_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_0_3 = aie.mem(%tile_0_3) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_1_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_1_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_1_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_1_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_0_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_0_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_0_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_0_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_0_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_1_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_0_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_0_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_1_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_0_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_1_3 = aie.mem(%tile_1_3) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_1_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_1_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_1_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_1_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_1_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_1_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_1_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_1_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_1_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_1_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_1_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_1_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_1_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_1_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_2_3 = aie.mem(%tile_2_3) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_1_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_1_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_1_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_1_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_2_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_1_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_2_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_2_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_1_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_2_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_3_3 = aie.mem(%tile_3_3) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_1_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_1_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_1_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_1_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_1_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_3_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_3_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_3_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_3_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_3_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_1_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_3_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_3_1_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_1_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_3_1_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_0_4 = aie.mem(%tile_0_4) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_2_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_2_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_0_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_0_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_0_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_0_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_0_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_2_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_0_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_0_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_2_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_0_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_1_4 = aie.mem(%tile_1_4) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_2_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_2_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_1_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_1_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_1_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_1_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_1_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_2_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_1_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_1_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_2_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_1_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_2_4 = aie.mem(%tile_2_4) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_2_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_2_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_2_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_2_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_2_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_2_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_2_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_2_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_3_4 = aie.mem(%tile_3_4) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_2_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_3_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_3_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_3_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_3_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_3_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_2_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_3_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_3_2_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_2_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_3_2_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_0_5 = aie.mem(%tile_0_5) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_3_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_0_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_3_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_3_0_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_0_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_3_0_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_0_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_0_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_0_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_0_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_0_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_0_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_3_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_0_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_0_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_0_3_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_0_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_1_5 = aie.mem(%tile_1_5) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_3_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_1_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_3_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_3_1_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_1_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_3_1_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_1_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_1_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_1_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_1_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_1_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_1_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_3_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_1_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_1_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_1_3_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_1_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_2_5 = aie.mem(%tile_2_5) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_3_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_2_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_3_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_3_2_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_2_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_3_2_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_2_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_2_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_2_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_2_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_3_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_2_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_2_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_2_3_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_2_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    %mem_3_5 = aie.mem(%tile_3_5) {
      %0 = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
    ^bb1:  // 2 preds: ^bb0, ^bb2
      aie.use_lock(%A_L2L1_3_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 0 : i32, next_bd_id = 1 : i32}
      aie.use_lock(%A_L2L1_3_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb2
    ^bb2:  // pred: ^bb1
      aie.use_lock(%A_L2L1_3_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%A_L2L1_3_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 1 : i32, next_bd_id = 0 : i32}
      aie.use_lock(%A_L2L1_3_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb1
    ^bb3:  // pred: ^bb0
      %1 = aie.dma_start(S2MM, 1, ^bb4, ^bb6)
    ^bb4:  // 2 preds: ^bb3, ^bb5
      aie.use_lock(%B_L2L1_3_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_3_cons_buff_0 : memref<32x32xi16>, 0, 1024) {bd_id = 2 : i32, next_bd_id = 3 : i32}
      aie.use_lock(%B_L2L1_3_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb5
    ^bb5:  // pred: ^bb4
      aie.use_lock(%B_L2L1_3_3_cons_prod_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%B_L2L1_3_3_cons_buff_1 : memref<32x32xi16>, 0, 1024) {bd_id = 3 : i32, next_bd_id = 2 : i32}
      aie.use_lock(%B_L2L1_3_3_cons_cons_lock_0, Release, 1)
      aie.next_bd ^bb4
    ^bb6:  // pred: ^bb3
      %2 = aie.dma_start(MM2S, 0, ^bb7, ^bb9)
    ^bb7:  // 2 preds: ^bb6, ^bb8
      aie.use_lock(%C_L1L2_3_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_3_buff_0 : memref<32x32xi32>, 0, 1024) {bd_id = 4 : i32, next_bd_id = 5 : i32}
      aie.use_lock(%C_L1L2_3_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb8
    ^bb8:  // pred: ^bb7
      aie.use_lock(%C_L1L2_3_3_cons_lock_0, AcquireGreaterEqual, 1)
      aie.dma_bd(%C_L1L2_3_3_buff_1 : memref<32x32xi32>, 0, 1024) {bd_id = 5 : i32, next_bd_id = 4 : i32}
      aie.use_lock(%C_L1L2_3_3_prod_lock_0, Release, 1)
      aie.next_bd ^bb7
    ^bb9:  // pred: ^bb6
      aie.end
    }
    aie.shim_dma_allocation @B_L3L2_0(MM2S, 1, 0)
    aie.shim_dma_allocation @B_L3L2_1(MM2S, 1, 1)
    aie.shim_dma_allocation @B_L3L2_2(MM2S, 1, 2)
    aie.shim_dma_allocation @B_L3L2_3(MM2S, 1, 3)
    aie.shim_dma_allocation @C_L2L3_0(S2MM, 0, 0)
    aie.shim_dma_allocation @C_L2L3_1(S2MM, 0, 1)
    aie.shim_dma_allocation @C_L2L3_2(S2MM, 0, 2)
    aie.shim_dma_allocation @C_L2L3_3(S2MM, 0, 3)
    aie.packet_flow(15) {
      aie.packet_source<%shim_noc_tile_0_0, TileControl : 0>
      aie.packet_dest<%shim_noc_tile_0_0, South : 0>
    } {keep_pkt_header = true, priority_route = true}
    aie.packet_flow(15) {
      aie.packet_source<%shim_noc_tile_1_0, TileControl : 0>
      aie.packet_dest<%shim_noc_tile_1_0, South : 0>
    } {keep_pkt_header = true, priority_route = true}
    aie.packet_flow(15) {
      aie.packet_source<%shim_noc_tile_2_0, TileControl : 0>
      aie.packet_dest<%shim_noc_tile_2_0, South : 0>
    } {keep_pkt_header = true, priority_route = true}
    aie.packet_flow(15) {
      aie.packet_source<%shim_noc_tile_3_0, TileControl : 0>
      aie.packet_dest<%shim_noc_tile_3_0, South : 0>
    } {keep_pkt_header = true, priority_route = true}
  }
}
