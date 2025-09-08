//===- mm.cc ----------------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2025, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

#include "./aie_kernel_utils.h"
#include <aie_api/aie.hpp>

template <typename T, int M, int N>
void zero_vectorized(T *__restrict c) {
  constexpr int r = 512 / (sizeof(T) * 8);
  static_assert((M * N) % r == 0);
  const aie::vector<T, r> zeros = aie::zeros<T, r>();
  const T *__restrict c_end = c + M * N;
  for (; c < c_end; c += r) {
    aie::store_v(c, zeros);
  }
}

// This kernel is a variation of the conventional matrix multiplications in the
// repo that uses different datatypes for the A and B and performs a conversion
// for the A matrix. This kernel should be followed along with the equivalent on
// in bfp16 only on mm.cc
template <unsigned rowA, unsigned colA, unsigned colB, unsigned r, unsigned s,
          unsigned t>
void matmul_vectorized_2x2_bfp16_bf16(const bfloat16 *__restrict pA,
                                      const bfp16ebs8 *__restrict pB,
                                      bfloat16 *__restrict pC) {
  const unsigned sizeA = r * s;
  const unsigned sizeB = s * t;
  const unsigned sizeC = r * t;

  AIE_PREPARE_FOR_PIPELINING
  AIE_LOOP_MIN_ITERATION_COUNT(4)
  for (unsigned z = 0; z < rowA; z += 2) {
      bfloat16 *__restrict pC1 = pC + (z * colB + 0) * sizeC;
      bfloat16 *__restrict pC2 = pC + ((z + 1) * colB + 0) * sizeC;

      for (unsigned j = 0; j < colB; j += 2)
#ifdef OPT_PERF_ENABLED
      AIE_LOOP_FLATTEN
#endif
        {
          const bfloat16 *__restrict pA1 = pA + (z * colA + 0) * sizeA;
          const bfloat16 *__restrict pA2 = pA + ((z + 1) * colA + 0) * sizeA;

          aie::block_vector_input_buffer_stream<bfp16ebs8, 64> pB1bfp16(pB);
          aie::block_vector_input_buffer_stream<bfp16ebs8, 64> pB2bfp16(pB);
          // For non transposed matrix
          // pB1bfp16.seek(j);
          // pB2bfp16.seek(j + 1);
          pB1bfp16.seek(j * colA);
          pB2bfp16.seek((j + 1) * colA);

          aie::vector<bfloat16, sizeA> A0;
          aie::vector<bfloat16, sizeA> A1;
          aie::block_vector<bfp16ebs8, sizeB> B0;
          aie::block_vector<bfp16ebs8, sizeB> B1;

          aie::accum<accfloat, sizeC> accC00(aie::load_v<sizeC>(pC1));
          aie::accum<accfloat, sizeC> accC01(aie::load_v<sizeC>(pC1 + sizeC));
          aie::accum<accfloat, sizeC> accC10(aie::load_v<sizeC>(pC2));
          aie::accum<accfloat, sizeC> accC11(aie::load_v<sizeC>(pC2 + sizeC));

          aie::accum<accfloat, 64> accA0;
          aie::accum<accfloat, 64> accA1;

          for (unsigned i = 0; i < colA; ++i)
#ifdef OPT_PERF_ENABLED
      AIE_LOOP_FLATTEN
#endif
            {
              A0 = aie::load_v<sizeA>(pA1);
              pA1 += sizeA;
              A1 = aie::load_v<sizeA>(pA2);
              pA2 += sizeA;

              // Convert A0 into bfp16
              accA0 = A0;
              // Convert A1 into bfp16 through a different path (see bfp
              // conversion example)
              accA1 = mul_elem_64(A1, concat(broadcast_one_to_v32bfloat16(),
                                             broadcast_one_to_v32bfloat16()));

              // For non transposed matrix
              // B0 = pB1bfp16.pop_seek(colB - 1);
              // B1 = pB2bfp16.pop_seek(colB - 1);
              B0 = pB1bfp16.pop();
              B1 = pB2bfp16.pop();

              accC00 = mac_8x8_8x8T(accA0.to_vector<bfp16ebs8>(), B0, accC00);
              accC01 = mac_8x8_8x8T(accA0.to_vector<bfp16ebs8>(), B1, accC01);
              accC10 = mac_8x8_8x8T(accA1.to_vector<bfp16ebs8>(), B0, accC10);
              accC11 = mac_8x8_8x8T(accA1.to_vector<bfp16ebs8>(), B1, accC11);
            }

          aie::store_v(pC1, accC00.template to_vector<bfloat16>());
          pC1 += sizeC;
          aie::store_v(pC1, accC01.template to_vector<bfloat16>());
          pC1 += sizeC;
          aie::store_v(pC2, accC10.template to_vector<bfloat16>());
          pC2 += sizeC;
          aie::store_v(pC2, accC11.template to_vector<bfloat16>());
          pC2 += sizeC;
        }
    }
}





constexpr int M = 64;  constexpr int K = 64;  constexpr int N = 64;
constexpr int m = 64;  constexpr int k = 64;  constexpr int n = 64;
constexpr int r = 8;   constexpr int s = 8;   constexpr int t = 8;

void matmul_8x8x8_kernel(bfloat16 *__restrict inA,
                  bfp16ebs8 *__restrict inB,
                  bfloat16 *__restrict outC, int B_stream_index) {
                  // float *__restrict outC) {

  aie::accum<accfloat, 64> chess_storage(dm0) acc0_data ( aie::load_v<64>(outC)   ) ;
  aie::accum<accfloat, 64> chess_storage(dm1) acc1_data ( aie::load_v<64>(outC + 64)   ) ;
  aie::accum<accfloat, 64> chess_storage(dm2) acc2_data ( aie::load_v<64>(outC + 128)   ) ;
  aie::accum<accfloat, 64> chess_storage(dm3) acc3_data ( aie::load_v<64>(outC + 192)   ) ;


  aie::block_vector_input_buffer_stream<bfp16ebs8, 64> pB_stream(inB);
  pB_stream.seek(B_stream_index);
  aie::block_vector<bfp16ebs8, 64> chess_storage(ex0) B0_data_bfp = pB_stream.pop();
  aie::block_vector<bfp16ebs8, 64> chess_storage(ex1) B1_data_bfp = pB_stream.pop();
  aie::block_vector<bfp16ebs8, 64> chess_storage(ex2) B2_data_bfp = pB_stream.pop();
  aie::block_vector<bfp16ebs8, 64> chess_storage(ex3) B3_data_bfp = pB_stream.pop();

  aie::vector<bfloat16, 64> A0_data_bf16;
  A0_data_bf16 = aie::load_v<64>(inA);  inA += 64;
  aie::accum<accfloat, 64> chess_storage(dm4) A0_data_float;
  A0_data_float = A0_data_bf16; 
  aie::block_vector<bfp16ebs8, 64> chess_storage(ex10) A0_data_bfp = A0_data_float.to_vector<bfp16ebs8>();

    aie::block_vector<bfp16ebs8, 64> chess_storage(ex4) B0_data_bfp_pong = pB_stream.pop();
    aie::block_vector<bfp16ebs8, 64> chess_storage(ex5) B1_data_bfp_pong = pB_stream.pop();
    aie::block_vector<bfp16ebs8, 64> chess_storage(ex6) B2_data_bfp_pong = pB_stream.pop();
    aie::block_vector<bfp16ebs8, 64> chess_storage(ex7) B3_data_bfp_pong = pB_stream.pop();

    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    aie::block_vector<bfp16ebs8, 64> chess_storage(ex11) A0_data_bfp_pong = A0_data_float.to_vector<bfp16ebs8>();
    // aie::block_vector<bfp16ebs8, 64> A0_data_bfp_pong = A0_data_float.to_vector<bfp16ebs8>();

    acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp, B2_data_bfp, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp, B3_data_bfp, acc3_data);

    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    A0_data_bfp = A0_data_float.to_vector<bfp16ebs8>();
    B0_data_bfp = pB_stream.pop();
    B1_data_bfp = pB_stream.pop();
    B2_data_bfp = pB_stream.pop();
    B3_data_bfp = pB_stream.pop();
    acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp_pong, B2_data_bfp_pong, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp_pong, B3_data_bfp_pong, acc3_data);



    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    A0_data_bfp_pong = A0_data_float.to_vector<bfp16ebs8>();
    B0_data_bfp_pong = pB_stream.pop();
    B1_data_bfp_pong = pB_stream.pop();
    B2_data_bfp_pong = pB_stream.pop();
    B3_data_bfp_pong = pB_stream.pop();
    acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp, B2_data_bfp, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp, B3_data_bfp, acc3_data);



    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    A0_data_bfp = A0_data_float.to_vector<bfp16ebs8>();
    B0_data_bfp = pB_stream.pop();
    B1_data_bfp = pB_stream.pop();
    B2_data_bfp = pB_stream.pop();
    B3_data_bfp = pB_stream.pop();
    acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp_pong, B2_data_bfp_pong, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp_pong, B3_data_bfp_pong, acc3_data);


    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    A0_data_bfp_pong = A0_data_float.to_vector<bfp16ebs8>();
    B0_data_bfp_pong = pB_stream.pop();
    B1_data_bfp_pong = pB_stream.pop();
    B2_data_bfp_pong = pB_stream.pop();
    B3_data_bfp_pong = pB_stream.pop();
    acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp, B2_data_bfp, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp, B3_data_bfp, acc3_data);



    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    A0_data_bfp = A0_data_float.to_vector<bfp16ebs8>();
    B0_data_bfp = pB_stream.pop();
    B1_data_bfp = pB_stream.pop();
    B2_data_bfp = pB_stream.pop();
    B3_data_bfp = pB_stream.pop();
    acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp_pong, B2_data_bfp_pong, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp_pong, B3_data_bfp_pong, acc3_data);

    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    A0_data_bfp_pong = A0_data_float.to_vector<bfp16ebs8>();
    B0_data_bfp_pong = pB_stream.pop();
    B1_data_bfp_pong = pB_stream.pop();
    B2_data_bfp_pong = pB_stream.pop();
    B3_data_bfp_pong = pB_stream.pop();
    acc0_data = mac_8x8_8x8T(A0_data_bfp, B0_data_bfp, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp, B1_data_bfp, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp, B2_data_bfp, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp, B3_data_bfp, acc3_data);


    A0_data_bf16 = aie::load_v<64>(inA);
    inA += 64;
    A0_data_float = A0_data_bf16;
    A0_data_bfp = A0_data_float.to_vector<bfp16ebs8>();
    B0_data_bfp = pB_stream.pop();
    B1_data_bfp = pB_stream.pop();
    B2_data_bfp = pB_stream.pop();
    B3_data_bfp = pB_stream.pop();
    acc0_data = mac_8x8_8x8T(A0_data_bfp_pong, B0_data_bfp_pong, acc0_data);
    acc1_data = mac_8x8_8x8T(A0_data_bfp_pong, B1_data_bfp_pong, acc1_data);
    acc2_data = mac_8x8_8x8T(A0_data_bfp_pong, B2_data_bfp_pong, acc2_data);
    acc3_data = mac_8x8_8x8T(A0_data_bfp_pong, B3_data_bfp_pong, acc3_data);

    aie::store_v(outC, acc0_data.template to_vector<bfloat16>());
    outC += 64;
    aie::store_v(outC, acc1_data.template to_vector<bfloat16>());
    outC += 64;
    aie::store_v(outC, acc2_data.template to_vector<bfloat16>());
    outC += 64;
    aie::store_v(outC, acc3_data.template to_vector<bfloat16>());
    outC += 64;

}


extern "C" {

// #ifndef DIM_M
// #define DIM_M 64
// #endif

// #ifndef DIM_K
// #define DIM_K 128
// #endif

// #ifndef DIM_N
// #define DIM_N 128
// #endif

void matmul_vectorized_different_datatypes(bfloat16 *__restrict pA,
                                           bfp16ebs8 *__restrict pB,
                                           bfloat16 *__restrict pC) {

  // for (int iter = 0; iter < 8; iter++){
    // int inA_index = 0;
    // for (int i = 0; i < m * n / (8 * 32); i++) {
    //   matmul_8x8x8_kernel(pA + inA_index, pB, pC, (i % 4) * 32);
    //   pC += 8 * 32;
    //   inA_index = (i / 4) * 8 * 64;
    // }

    event0();
    for (int i = 0; i < m * n / (8 * 32); i++) {
    // for (int i = 0; i < 1; i++) {
      int block_row = i / (n/32);
      int block_col = i % (n/32);
      matmul_8x8x8_kernel(pA + block_row * 8 * k, pB, pC, block_col * 8 * 4);
      pC += 8 * 32;
    }
    event1();

}

void zero_kernel_bf16(bfloat16 *__restrict cOut) {
  zero_vectorized<bfloat16, DIM_M, DIM_N>(cOut);
}
}
