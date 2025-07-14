; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "aie2"

@in_cons_buff_0 = external global [36 x i32]
@in2_cons_buff_1 = external global [18 x i32]
@in2_cons_buff_0 = external global [18 x i32]
@in3_cons_buff_1 = external global [18 x i32]
@in3_cons_buff_0 = external global [18 x i32]
@out2_buff_1 = external global [18 x i32]
@out2_buff_0 = external global [18 x i32]
@out3_buff_1 = external global [18 x i32]
@out3_buff_0 = external global [18 x i32]
@out_buff_0 = external global [36 x i32]
@out_cons = external global [36 x i32]
@out = external global [36 x i32]
@out3_cons = external global [18 x i32]
@out3 = external global [18 x i32]
@out2_cons = external global [18 x i32]
@out2 = external global [18 x i32]
@in3_cons = external global [18 x i32]
@in3 = external global [18 x i32]
@in2_cons = external global [18 x i32]
@in2 = external global [18 x i32]
@in_cons = external global [36 x i32]
@in = external global [36 x i32]

declare void @debug_i32(i32)

declare void @llvm.aie2.put.ms(i32, i32)

declare { i32, i32 } @llvm.aie2.get.ss()

declare void @llvm.aie2.mcd.write.vec(<16 x i32>, i32)

declare <16 x i32> @llvm.aie2.scd.read.vec(i32)

declare void @llvm.aie2.acquire(i32, i32)

declare void @llvm.aie2.release(i32, i32)

define void @core_0_3() {
  br label %1

1:                                                ; preds = %24, %0
  %2 = phi i64 [ %25, %24 ], [ 0, %0 ]
  %3 = icmp slt i64 %2, 9223372036854775806
  br i1 %3, label %4, label %26

4:                                                ; preds = %1
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  br label %5

5:                                                ; preds = %8, %4
  %6 = phi i64 [ %13, %8 ], [ 0, %4 ]
  %7 = icmp slt i64 %6, 18
  br i1 %7, label %8, label %14

8:                                                ; preds = %5
  %9 = getelementptr inbounds nuw i32, ptr @in3_cons_buff_0, i64 %6
  %10 = load i32, ptr %9, align 4
  %11 = add i32 %10, 2
  %12 = getelementptr inbounds nuw i32, ptr @out3_buff_0, i64 %6
  store i32 %11, ptr %12, align 4
  %13 = add i64 %6, 1
  br label %5

14:                                               ; preds = %5
  call void @llvm.aie2.release(i32 48, i32 1)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  br label %15

15:                                               ; preds = %18, %14
  %16 = phi i64 [ %23, %18 ], [ 0, %14 ]
  %17 = icmp slt i64 %16, 18
  br i1 %17, label %18, label %24

18:                                               ; preds = %15
  %19 = getelementptr inbounds nuw i32, ptr @in3_cons_buff_1, i64 %16
  %20 = load i32, ptr %19, align 4
  %21 = add i32 %20, 2
  %22 = getelementptr inbounds nuw i32, ptr @out3_buff_1, i64 %16
  store i32 %21, ptr %22, align 4
  %23 = add i64 %16, 1
  br label %15

24:                                               ; preds = %15
  call void @llvm.aie2.release(i32 48, i32 1)
  call void @llvm.aie2.release(i32 51, i32 1)
  %25 = add i64 %2, 2
  br label %1

26:                                               ; preds = %1
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  br label %27

27:                                               ; preds = %30, %26
  %28 = phi i64 [ %35, %30 ], [ 0, %26 ]
  %29 = icmp slt i64 %28, 18
  br i1 %29, label %30, label %36

30:                                               ; preds = %27
  %31 = getelementptr inbounds nuw i32, ptr @in3_cons_buff_0, i64 %28
  %32 = load i32, ptr %31, align 4
  %33 = add i32 %32, 2
  %34 = getelementptr inbounds nuw i32, ptr @out3_buff_0, i64 %28
  store i32 %33, ptr %34, align 4
  %35 = add i64 %28, 1
  br label %27

36:                                               ; preds = %27
  call void @llvm.aie2.release(i32 48, i32 1)
  call void @llvm.aie2.release(i32 51, i32 1)
  ret void
}

define void @core_0_2() {
  br label %1

1:                                                ; preds = %24, %0
  %2 = phi i64 [ %25, %24 ], [ 0, %0 ]
  %3 = icmp slt i64 %2, 9223372036854775806
  br i1 %3, label %4, label %26

4:                                                ; preds = %1
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  br label %5

5:                                                ; preds = %8, %4
  %6 = phi i64 [ %13, %8 ], [ 0, %4 ]
  %7 = icmp slt i64 %6, 18
  br i1 %7, label %8, label %14

8:                                                ; preds = %5
  %9 = getelementptr inbounds nuw i32, ptr @in2_cons_buff_0, i64 %6
  %10 = load i32, ptr %9, align 4
  %11 = add i32 %10, 1
  %12 = getelementptr inbounds nuw i32, ptr @out2_buff_0, i64 %6
  store i32 %11, ptr %12, align 4
  %13 = add i64 %6, 1
  br label %5

14:                                               ; preds = %5
  call void @llvm.aie2.release(i32 48, i32 1)
  call void @llvm.aie2.release(i32 51, i32 1)
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  br label %15

15:                                               ; preds = %18, %14
  %16 = phi i64 [ %23, %18 ], [ 0, %14 ]
  %17 = icmp slt i64 %16, 18
  br i1 %17, label %18, label %24

18:                                               ; preds = %15
  %19 = getelementptr inbounds nuw i32, ptr @in2_cons_buff_1, i64 %16
  %20 = load i32, ptr %19, align 4
  %21 = add i32 %20, 1
  %22 = getelementptr inbounds nuw i32, ptr @out2_buff_1, i64 %16
  store i32 %21, ptr %22, align 4
  %23 = add i64 %16, 1
  br label %15

24:                                               ; preds = %15
  call void @llvm.aie2.release(i32 48, i32 1)
  call void @llvm.aie2.release(i32 51, i32 1)
  %25 = add i64 %2, 2
  br label %1

26:                                               ; preds = %1
  call void @llvm.aie2.acquire(i32 50, i32 -1)
  call void @llvm.aie2.acquire(i32 49, i32 -1)
  br label %27

27:                                               ; preds = %30, %26
  %28 = phi i64 [ %35, %30 ], [ 0, %26 ]
  %29 = icmp slt i64 %28, 18
  br i1 %29, label %30, label %36

30:                                               ; preds = %27
  %31 = getelementptr inbounds nuw i32, ptr @in2_cons_buff_0, i64 %28
  %32 = load i32, ptr %31, align 4
  %33 = add i32 %32, 1
  %34 = getelementptr inbounds nuw i32, ptr @out2_buff_0, i64 %28
  store i32 %33, ptr %34, align 4
  %35 = add i64 %28, 1
  br label %27

36:                                               ; preds = %27
  call void @llvm.aie2.release(i32 48, i32 1)
  call void @llvm.aie2.release(i32 51, i32 1)
  ret void
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
