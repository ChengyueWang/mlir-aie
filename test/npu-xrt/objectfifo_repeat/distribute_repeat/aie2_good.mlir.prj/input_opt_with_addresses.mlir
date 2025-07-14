module attributes {llvm.target_triple = "aie2"} {
  llvm.mlir.global external @in_cons_buff_0() {addr_space = 0 : i32} : !llvm.array<36 x i32>
  llvm.mlir.global external @in2_cons_buff_1() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in2_cons_buff_0() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in3_cons_buff_1() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in3_cons_buff_0() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out2_buff_1() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out2_buff_0() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out3_buff_1() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out3_buff_0() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out_buff_0() {addr_space = 0 : i32} : !llvm.array<36 x i32>
  llvm.func @debug_i32(i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.put.ms(i32, i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.get.ss() -> !llvm.struct<(i32, i32)> attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.mcd.write.vec(vector<16xi32>, i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.scd.read.vec(i32) -> vector<16xi32> attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.acquire(i32, i32) attributes {sym_visibility = "private"}
  llvm.func @llvm.aie2.release(i32, i32) attributes {sym_visibility = "private"}
  llvm.mlir.global external @out_cons() {addr_space = 0 : i32} : !llvm.array<36 x i32>
  llvm.mlir.global external @out() {addr_space = 0 : i32} : !llvm.array<36 x i32>
  llvm.mlir.global external @out3_cons() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out3() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out2_cons() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @out2() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in3_cons() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in3() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in2_cons() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in2() {addr_space = 0 : i32} : !llvm.array<18 x i32>
  llvm.mlir.global external @in_cons() {addr_space = 0 : i32} : !llvm.array<36 x i32>
  llvm.mlir.global external @in() {addr_space = 0 : i32} : !llvm.array<36 x i32>
  llvm.func @core_0_3() {
    %0 = llvm.mlir.addressof @out3_buff_1 : !llvm.ptr
    %1 = llvm.mlir.addressof @in3_cons_buff_1 : !llvm.ptr
    %2 = llvm.mlir.addressof @out3_buff_0 : !llvm.ptr
    %3 = llvm.mlir.addressof @in3_cons_buff_0 : !llvm.ptr
    %4 = llvm.mlir.constant(51 : i32) : i32
    %5 = llvm.mlir.constant(48 : i32) : i32
    %6 = llvm.mlir.constant(49 : i32) : i32
    %7 = llvm.mlir.constant(50 : i32) : i32
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.mlir.constant(18 : index) : i64
    %11 = llvm.mlir.constant(-1 : i32) : i32
    %12 = llvm.mlir.constant(2 : index) : i64
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(9223372036854775806 : index) : i64
    llvm.br ^bb1(%13 : i64)
  ^bb1(%16: i64):  // 2 preds: ^bb0, ^bb8
    %17 = llvm.icmp "slt" %16, %15 : i64
    llvm.cond_br %17, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.call @llvm.aie2.acquire(%7, %11) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%6, %11) : (i32, i32) -> ()
    llvm.br ^bb3(%13 : i64)
  ^bb3(%18: i64):  // 2 preds: ^bb2, ^bb4
    %19 = llvm.icmp "slt" %18, %10 : i64
    llvm.cond_br %19, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %20 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %21 = llvm.getelementptr inbounds|nuw %20[%18] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %22 = llvm.load %21 : !llvm.ptr -> i32
    %23 = llvm.add %22, %9 : i32
    %24 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %25 = llvm.getelementptr inbounds|nuw %24[%18] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %23, %25 : i32, !llvm.ptr
    %26 = llvm.add %18, %14 : i64
    llvm.br ^bb3(%26 : i64)
  ^bb5:  // pred: ^bb3
    llvm.call @llvm.aie2.release(%5, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%4, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%7, %11) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%6, %11) : (i32, i32) -> ()
    llvm.br ^bb6(%13 : i64)
  ^bb6(%27: i64):  // 2 preds: ^bb5, ^bb7
    %28 = llvm.icmp "slt" %27, %10 : i64
    llvm.cond_br %28, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %29 = llvm.getelementptr %1[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %30 = llvm.getelementptr inbounds|nuw %29[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %31 = llvm.load %30 : !llvm.ptr -> i32
    %32 = llvm.add %31, %9 : i32
    %33 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %34 = llvm.getelementptr inbounds|nuw %33[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %32, %34 : i32, !llvm.ptr
    %35 = llvm.add %27, %14 : i64
    llvm.br ^bb6(%35 : i64)
  ^bb8:  // pred: ^bb6
    llvm.call @llvm.aie2.release(%5, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%4, %8) : (i32, i32) -> ()
    %36 = llvm.add %16, %12 : i64
    llvm.br ^bb1(%36 : i64)
  ^bb9:  // pred: ^bb1
    llvm.call @llvm.aie2.acquire(%7, %11) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%6, %11) : (i32, i32) -> ()
    llvm.br ^bb10(%13 : i64)
  ^bb10(%37: i64):  // 2 preds: ^bb9, ^bb11
    %38 = llvm.icmp "slt" %37, %10 : i64
    llvm.cond_br %38, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %39 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %40 = llvm.getelementptr inbounds|nuw %39[%37] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %41 = llvm.load %40 : !llvm.ptr -> i32
    %42 = llvm.add %41, %9 : i32
    %43 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %44 = llvm.getelementptr inbounds|nuw %43[%37] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %42, %44 : i32, !llvm.ptr
    %45 = llvm.add %37, %14 : i64
    llvm.br ^bb10(%45 : i64)
  ^bb12:  // pred: ^bb10
    llvm.call @llvm.aie2.release(%5, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%4, %8) : (i32, i32) -> ()
    llvm.return
  }
  llvm.func @core_0_2() {
    %0 = llvm.mlir.addressof @out2_buff_1 : !llvm.ptr
    %1 = llvm.mlir.addressof @in2_cons_buff_1 : !llvm.ptr
    %2 = llvm.mlir.addressof @out2_buff_0 : !llvm.ptr
    %3 = llvm.mlir.addressof @in2_cons_buff_0 : !llvm.ptr
    %4 = llvm.mlir.constant(51 : i32) : i32
    %5 = llvm.mlir.constant(48 : i32) : i32
    %6 = llvm.mlir.constant(49 : i32) : i32
    %7 = llvm.mlir.constant(50 : i32) : i32
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.constant(18 : index) : i64
    %10 = llvm.mlir.constant(-1 : i32) : i32
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.mlir.constant(9223372036854775806 : index) : i64
    %14 = llvm.mlir.constant(2 : index) : i64
    llvm.br ^bb1(%11 : i64)
  ^bb1(%15: i64):  // 2 preds: ^bb0, ^bb8
    %16 = llvm.icmp "slt" %15, %13 : i64
    llvm.cond_br %16, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    llvm.call @llvm.aie2.acquire(%7, %10) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%6, %10) : (i32, i32) -> ()
    llvm.br ^bb3(%11 : i64)
  ^bb3(%17: i64):  // 2 preds: ^bb2, ^bb4
    %18 = llvm.icmp "slt" %17, %9 : i64
    llvm.cond_br %18, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %19 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %20 = llvm.getelementptr inbounds|nuw %19[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %21 = llvm.load %20 : !llvm.ptr -> i32
    %22 = llvm.add %21, %8 : i32
    %23 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %24 = llvm.getelementptr inbounds|nuw %23[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %24 : i32, !llvm.ptr
    %25 = llvm.add %17, %12 : i64
    llvm.br ^bb3(%25 : i64)
  ^bb5:  // pred: ^bb3
    llvm.call @llvm.aie2.release(%5, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%4, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%7, %10) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%6, %10) : (i32, i32) -> ()
    llvm.br ^bb6(%11 : i64)
  ^bb6(%26: i64):  // 2 preds: ^bb5, ^bb7
    %27 = llvm.icmp "slt" %26, %9 : i64
    llvm.cond_br %27, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %28 = llvm.getelementptr %1[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %29 = llvm.getelementptr inbounds|nuw %28[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %30 = llvm.load %29 : !llvm.ptr -> i32
    %31 = llvm.add %30, %8 : i32
    %32 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %33 = llvm.getelementptr inbounds|nuw %32[%26] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %31, %33 : i32, !llvm.ptr
    %34 = llvm.add %26, %12 : i64
    llvm.br ^bb6(%34 : i64)
  ^bb8:  // pred: ^bb6
    llvm.call @llvm.aie2.release(%5, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%4, %8) : (i32, i32) -> ()
    %35 = llvm.add %15, %14 : i64
    llvm.br ^bb1(%35 : i64)
  ^bb9:  // pred: ^bb1
    llvm.call @llvm.aie2.acquire(%7, %10) : (i32, i32) -> ()
    llvm.call @llvm.aie2.acquire(%6, %10) : (i32, i32) -> ()
    llvm.br ^bb10(%11 : i64)
  ^bb10(%36: i64):  // 2 preds: ^bb9, ^bb11
    %37 = llvm.icmp "slt" %36, %9 : i64
    llvm.cond_br %37, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    %38 = llvm.getelementptr %3[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %39 = llvm.getelementptr inbounds|nuw %38[%36] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %40 = llvm.load %39 : !llvm.ptr -> i32
    %41 = llvm.add %40, %8 : i32
    %42 = llvm.getelementptr %2[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<18 x i32>
    %43 = llvm.getelementptr inbounds|nuw %42[%36] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %41, %43 : i32, !llvm.ptr
    %44 = llvm.add %36, %12 : i64
    llvm.br ^bb10(%44 : i64)
  ^bb12:  // pred: ^bb10
    llvm.call @llvm.aie2.release(%5, %8) : (i32, i32) -> ()
    llvm.call @llvm.aie2.release(%4, %8) : (i32, i32) -> ()
    llvm.return
  }
}

