module {
  aie.device(npu2) {
    func.func private @zero_kernel_bf16(memref<64x64xbf16>)
    func.func private @matmul_vectorized_different_datatypes(memref<64x64xbf16>, memref<64x8x!aiex.bfp<"v8bfp16ebs8">>, memref<64x64xbf16>)
    %shim_noc_tile_1_0 = aie.tile(1, 0)
    %mem_tile_1_1 = aie.tile(1, 1)
    %shim_noc_tile_0_0 = aie.tile(0, 0)
    %mem_tile_0_1 = aie.tile(0, 1)
    %shim_noc_tile_2_0 = aie.tile(2, 0)
    %mem_tile_2_1 = aie.tile(2, 1)
    %tile_1_2 = aie.tile(1, 2)
    aie.objectfifo @inA(%shim_noc_tile_1_0, {%mem_tile_1_1}, 2 : i32) : !aie.objectfifo<memref<64x64xbf16>> 
    aie.objectfifo @memA(%mem_tile_1_1 dimensionsToStream [<size = 8, stride = 512>, <size = 8, stride = 8>, <size = 8, stride = 64>, <size = 8, stride = 1>], {%tile_1_2}, 2 : i32) : !aie.objectfifo<memref<64x64xbf16>> 
    aie.objectfifo.link [@inA] -> [@memA]([] [])
    aie.objectfifo @inB(%shim_noc_tile_0_0, {%mem_tile_0_1}, 2 : i32) : !aie.objectfifo<memref<64x8x!aiex.bfp<"v8bfp16ebs8">>> 
    aie.objectfifo @memB(%mem_tile_0_1, {%tile_1_2}, 2 : i32) : !aie.objectfifo<memref<64x8x!aiex.bfp<"v8bfp16ebs8">>> 
    aie.objectfifo.link [@inB] -> [@memB]([] [])
    aie.objectfifo @memC(%tile_1_2, {%mem_tile_2_1}, 2 : i32) : !aie.objectfifo<memref<64x64xbf16>> 
    aie.objectfifo @outC(%mem_tile_2_1 dimensionsToStream [<size = 8, stride = 512>, <size = 8, stride = 8>, <size = 8, stride = 64>, <size = 8, stride = 1>], {%shim_noc_tile_2_0}, 2 : i32) : !aie.objectfifo<memref<64x64xbf16>> 
    aie.objectfifo.link [@memC] -> [@outC]([] [])
    %core_1_2 = aie.core(%tile_1_2) {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %c1 = arith.constant 1 : index
      scf.for %arg0 = %c0 to %c4294967295 step %c1 {
        %c0_0 = arith.constant 0 : index
        %c64 = arith.constant 64 : index
        %c1_1 = arith.constant 1 : index
        scf.for %arg1 = %c0_0 to %c64 step %c1_1 {
          %0 = aie.objectfifo.acquire @memC(Produce, 1) : !aie.objectfifosubview<memref<64x64xbf16>>
          %1 = aie.objectfifo.subview.access %0[0] : !aie.objectfifosubview<memref<64x64xbf16>> -> memref<64x64xbf16>
          func.call @zero_kernel_bf16(%1) : (memref<64x64xbf16>) -> ()
          %c0_2 = arith.constant 0 : index
          %c8 = arith.constant 8 : index
          %c1_3 = arith.constant 1 : index
          scf.for %arg2 = %c0_2 to %c8 step %c1_3 {
            %2 = aie.objectfifo.acquire @memA(Consume, 1) : !aie.objectfifosubview<memref<64x64xbf16>>
            %3 = aie.objectfifo.subview.access %2[0] : !aie.objectfifosubview<memref<64x64xbf16>> -> memref<64x64xbf16>
            %4 = aie.objectfifo.acquire @memB(Consume, 1) : !aie.objectfifosubview<memref<64x8x!aiex.bfp<"v8bfp16ebs8">>>
            %5 = aie.objectfifo.subview.access %4[0] : !aie.objectfifosubview<memref<64x8x!aiex.bfp<"v8bfp16ebs8">>> -> memref<64x8x!aiex.bfp<"v8bfp16ebs8">>
            func.call @matmul_vectorized_different_datatypes(%3, %5, %1) : (memref<64x64xbf16>, memref<64x8x!aiex.bfp<"v8bfp16ebs8">>, memref<64x64xbf16>) -> ()
            aie.objectfifo.release @memA(Consume, 1)
            aie.objectfifo.release @memB(Consume, 1)
          }
          aie.objectfifo.release @memC(Produce, 1)
        }
      }
      aie.end
    } {link_with = "mm_64x64x64.o", stack_size = 3840 : i32}
    aiex.runtime_sequence @sequence(%arg0: memref<262144xbf16>, %arg1: memref<32768x!aiex.bfp<"v8bfp16ebs8">>, %arg2: memref<262144xbf16>) {
      %0 = aiex.dma_configure_task_for @outC {
        aie.dma_bd(%arg2 : memref<262144xbf16>, 0, 32768, [<size = 2, stride = 32768>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {issue_token = true, repeat_count = 1 : i32}
      aiex.dma_start_task(%0)
      %1 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 0, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%1)
      %2 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%2)
      %3 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 32768, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%3)
      %4 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%4)
      %5 = aiex.dma_configure_task_for @outC {
        aie.dma_bd(%arg2 : memref<262144xbf16>, 65536, 32768, [<size = 2, stride = 32768>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {issue_token = true, repeat_count = 1 : i32}
      aiex.dma_start_task(%5)
      %6 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 65536, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%6)
      %7 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%7)
      %8 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 98304, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%8)
      %9 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%9)
      aiex.dma_await_task(%0)
      aiex.dma_free_task(%6)
      aiex.dma_free_task(%7)
      %10 = aiex.dma_configure_task_for @outC {
        aie.dma_bd(%arg2 : memref<262144xbf16>, 131072, 32768, [<size = 2, stride = 32768>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {issue_token = true, repeat_count = 1 : i32}
      aiex.dma_start_task(%10)
      %11 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 131072, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%11)
      %12 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%12)
      %13 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 163840, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%13)
      %14 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%14)
      aiex.dma_await_task(%5)
      aiex.dma_free_task(%11)
      aiex.dma_free_task(%12)
      %15 = aiex.dma_configure_task_for @outC {
        aie.dma_bd(%arg2 : memref<262144xbf16>, 196608, 32768, [<size = 2, stride = 32768>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {issue_token = true, repeat_count = 1 : i32}
      aiex.dma_start_task(%15)
      %16 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 196608, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%16)
      %17 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%17)
      %18 = aiex.dma_configure_task_for @inA {
        aie.dma_bd(%arg0 : memref<262144xbf16>, 229376, 32768, [<size = 8, stride = 0>, <size = 8, stride = 64>, <size = 64, stride = 512>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      } {repeat_count = 7 : i32}
      aiex.dma_start_task(%18)
      %19 = aiex.dma_configure_task_for @inB {
        aie.dma_bd(%arg1 : memref<32768x!aiex.bfp<"v8bfp16ebs8">>, 0, 32768, [<size = 1, stride = 0>, <size = 64, stride = 512>, <size = 8, stride = 64>, <size = 64, stride = 1>]) {burst_length = 0 : i32}
        aie.end
      }
      aiex.dma_start_task(%19)
      aiex.dma_await_task(%10)
      aiex.dma_free_task(%16)
      aiex.dma_free_task(%17)
      aiex.dma_await_task(%15)
    }
  }
}

