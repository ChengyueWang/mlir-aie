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

template <int M, int N>
void zero_vectorized_v64bfp16ebs8(bfp16ebs8 *__restrict cOut) {
  int const vectorSize = 64;

  const aie::accum<accfloat, vectorSize> acc =
      aie::zeros<accfloat, vectorSize>();

  aie::block_vector_output_buffer_stream<bfp16ebs8, vectorSize> outStreamC(
      cOut);

  for (int i = 0; i < M * N / 64; i++) {
    outStreamC << acc.to_vector<bfp16ebs8>();
  }
}


constexpr int M = 128/4;  constexpr int K = 64;  constexpr int N = 128;
constexpr int m = 128/4;  constexpr int k = 64;  constexpr int n = 128;
constexpr int r = 8;   constexpr int s = 8;   constexpr int t = 8;


extern "C" {

static int g_counter = 0;

void matmul_vectorized_bfp16(bfp16ebs8 *__restrict pA, bfp16ebs8 *__restrict pB,
                             bfp16ebs8 *__restrict pC) {

    pC += g_counter * m * n / 8; // divde by 8 because 1 address have 8 data
    if (g_counter == 3){
      g_counter = 0;
    }else{
      g_counter = g_counter + 1;
    }

  int run_num = 1000 ; 
  for (int run =0; run < run_num ; run ++){
    // each ouput block contains 8x8 elements
    for (int block_row = 0; block_row < m / 8; block_row = block_row + 2) {
      aie::block_vector_input_buffer_stream<bfp16ebs8, 64> pC0In_stream(pC);
      pC0In_stream.seek(block_row * n/8);
      aie::block_vector_input_buffer_stream<bfp16ebs8, 64> pC1In_stream(pC);
      pC1In_stream.seek((block_row +1) * n/8);

      aie::block_vector_output_buffer_stream<bfp16ebs8, 64> pC0Out_stream(pC);
      pC0Out_stream.seek(block_row * n/8);
      aie::block_vector_output_buffer_stream<bfp16ebs8, 64> pC1Out_stream(pC);
      pC1Out_stream.seek((block_row+1) * n/8);

      aie::block_vector_input_buffer_stream<bfp16ebs8, 64> pB_stream(pB);
      pB_stream.seek(block_row * k/8);

      AIE_LOOP_UNROLL(2)
      for (int block_col = 0; block_col < n / 8; block_col = block_col + 2) {
        aie::block_vector_input_buffer_stream<bfp16ebs8, 64> pA_stream(pA);
        int A_stream_index = block_row * k / 8; 
        pA_stream.seek(A_stream_index);

        aie::block_vector<bfp16ebs8, 64> chess_storage(ex0) loadC0 = pC0In_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex1) loadC1 = pC0In_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex2) loadC2 = pC1In_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex3) loadC3 = pC1In_stream.pop();

        aie::accum<accfloat, 64> chess_storage(dm0) acc0_data(loadC0);
        aie::accum<accfloat, 64> chess_storage(dm1) acc1_data(loadC1);
        aie::accum<accfloat, 64> chess_storage(dm2) acc2_data(loadC2);
        aie::accum<accfloat, 64> chess_storage(dm3) acc3_data(loadC3);

        aie::block_vector<bfp16ebs8, 64> chess_storage(ex4) A0_data_bfp_pong = pA_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex5) A1_data_bfp_pong = pA_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex6) B0_data_bfp_pong = pB_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex7) B1_data_bfp_pong = pB_stream.pop();

        aie::block_vector<bfp16ebs8, 64> chess_storage(ex8) A0_data_bfp = pA_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex9) A1_data_bfp = pA_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex10) B0_data_bfp = pB_stream.pop();
        aie::block_vector<bfp16ebs8, 64> chess_storage(ex11) B1_data_bfp = pB_stream.pop();

        acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp, B0_data_bfp, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp, B1_data_bfp, acc3_data);
        A0_data_bfp = pA_stream.pop();
        A1_data_bfp = pA_stream.pop();
        B0_data_bfp = pB_stream.pop();
        B1_data_bfp = pB_stream.pop();
        acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp_pong, B0_data_bfp_pong, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp_pong, B1_data_bfp_pong, acc3_data);
        A0_data_bfp_pong = pA_stream.pop();
        A1_data_bfp_pong = pA_stream.pop();
        B0_data_bfp_pong = pB_stream.pop();
        B1_data_bfp_pong = pB_stream.pop();
        acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp, B0_data_bfp, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp, B1_data_bfp, acc3_data);
        A0_data_bfp = pA_stream.pop();
        A1_data_bfp = pA_stream.pop();
        B0_data_bfp = pB_stream.pop();
        B1_data_bfp = pB_stream.pop();
        acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp_pong, B0_data_bfp_pong, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp_pong, B1_data_bfp_pong, acc3_data);
        A0_data_bfp_pong = pA_stream.pop();
        A1_data_bfp_pong = pA_stream.pop();
        B0_data_bfp_pong = pB_stream.pop();
        B1_data_bfp_pong = pB_stream.pop();
        acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp, B0_data_bfp, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp, B1_data_bfp, acc3_data);
        A0_data_bfp = pA_stream.pop();
        A1_data_bfp = pA_stream.pop();
        B0_data_bfp = pB_stream.pop();
        B1_data_bfp = pB_stream.pop();
        acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp_pong, B0_data_bfp_pong, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp_pong, B1_data_bfp_pong, acc3_data);
        A0_data_bfp_pong = pA_stream.pop();
        A1_data_bfp_pong = pA_stream.pop();
        B0_data_bfp_pong = pB_stream.pop();
        B1_data_bfp_pong = pB_stream.pop();
        acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp, B0_data_bfp, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp, B1_data_bfp, acc3_data);


        acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
        acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
        acc2_data = mac_8x8_8x8T(A1_data_bfp_pong, B0_data_bfp_pong, acc2_data);
        acc3_data = mac_8x8_8x8T(A1_data_bfp_pong, B1_data_bfp_pong, acc3_data);

        pC0Out_stream.push(acc0_data.template to_vector<bfp16ebs8>());
        pC0Out_stream.push(acc1_data.template to_vector<bfp16ebs8>());
        pC1Out_stream.push(acc2_data.template to_vector<bfp16ebs8>());
        pC1Out_stream.push(acc3_data.template to_vector<bfp16ebs8>());
      }
    }

  }

  }

void zero_kernel(bfp16ebs8 *__restrict cOut) {
  zero_vectorized_v64bfp16ebs8<DIM_M, DIM_N>(cOut);
}

}