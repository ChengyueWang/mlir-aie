
//===- mm.cc ----------------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2025, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

#include "aie_kernel_utils.h"
#include <aie_api/aie.hpp>

bfloat16 c_bf16_2nd_half [ 128 * 128  / 2];

template <int M, int N>
void zero_vectorized_v64bfp16ebs8(bfp16ebs8 *__restrict cOut) {
  // int const vectorSize = 64;
  // const aie::accum<accfloat, vectorSize> acc =
  //     aie::zeros<accfloat, vectorSize>();
  // aie::block_vector_output_buffer_stream<bfp16ebs8, vectorSize> outStreamC(
  //     cOut);
  // for (int i = 0; i < M * N / 64; i++) {
  //   outStreamC << acc.to_vector<bfp16ebs8>();
  // }

  bfloat16 * c_ptr_bf16 = (bfloat16 *) cOut;
  const aie::vector<bfloat16, 64> zeros = aie::zeros<bfloat16, 64>();
  const bfloat16 *__restrict c_ptr_bf16_end = c_ptr_bf16 + 128 * 128 / 2;
  for (; c_ptr_bf16 < c_ptr_bf16_end; c_ptr_bf16 += 64) {
    aie::store_v(c_ptr_bf16, zeros);
  }

  bfloat16 * c_bf16_2nd_half_ptr = c_bf16_2nd_half;
  for (int i=0; i<128 * 128 / 64; i++) {
    aie::store_v(c_bf16_2nd_half_ptr, zeros);
    c_bf16_2nd_half_ptr += 64;
  }


}


constexpr int M = 128/4;  constexpr int K = 64;  constexpr int N = 128;
constexpr int m = 128/4;  constexpr int k = 64;  constexpr int n = 128;
constexpr int r = 8;   constexpr int s = 8;   constexpr int t = 8;


extern "C" {

static int g_counter = 0;

static int k_counter = 0;  // 4096 / 64 / 4; // K / k / DIV


void matmul_vectorized_bfp16(bfp16ebs8 *__restrict pA, bfp16ebs8 *__restrict pB,
                             bfp16ebs8 *__restrict pC) {

    pC += g_counter * m * n / 8; // divde by 8 because 1 address have 8 data
    if (g_counter == 3){
      g_counter = 0;
    }else{
      g_counter = g_counter + 1;
    }
    

    k_counter += 1; 
    if (k_counter == 4096 / 64 / 4){ // // K / k / DIV
      k_counter = 0;
      // transfer second half BF16 to pC

    }


  }

void zero_kernel(bfp16ebs8 *__restrict cOut) {
  zero_vectorized_v64bfp16ebs8<DIM_M, DIM_N>(cOut);
}

}