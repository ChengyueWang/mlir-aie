//===- bfp_test.cpp ---------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2025, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

#include <bits/stdc++.h>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <stdfloat>
#include <vector>

#include "xrt/xrt_bo.h"
#include "xrt/xrt_device.h"
#include "xrt/xrt_kernel.h"

// Clangd fix, remove
#ifdef _CLANGD
namespace std {
using bfloat16_t = double;
} // namespace std
#endif

#include "../helper.h"
#include "common.h"

#define XSTR(X) STR(X)
#define STR(X) #X

constexpr long long verify_stochastic_threshold = 1024 * 1024;
constexpr int verify_stochastic_n_samples = 1000;

// Verification tolerance
// See "Note on Numerical Tolerances" in README.md
// TODO: This might have to be adjusted for bfp
float abs_tol = matmul_common::get_abs_tol<std::bfloat16_t>();
float rel_tol = matmul_common::get_rel_tol<std::bfloat16_t>();

// Function to write matrix to CSV file
void writeMatrixToCSV(const std::vector<float> &matrix, int rows, int cols,
                      const std::string &filename) {
  std::ofstream file(filename);
  if (!file.is_open()) {
    std::cerr << "Error: Could not open file " << filename << std::endl;
    return;
  }

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      file << matrix[i * cols + j];
      if (j < cols - 1)
        file << ",";
    }
    file << "\n";
  }
  file.close();
  std::cout << "Matrix written to " << filename << std::endl;
}

// Function to compute golden reference matrix multiplication
// B is stored in column-major format (N×K), so we treat it as B^T
std::vector<float> computeGoldenReference(const std::vector<float> &A,
                                         const std::vector<float> &B, int M,
                                         int K, int N) {
  std::vector<float> C(M * N, 0.0f);

  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      for (int k = 0; k < K; k++) {
        // B is stored as N×K (column-major), so B[j * K + k] gives us B^T[k][j]
        C[i * N + j] += A[i * K + k] * B[j * K + k];
      }
    }
  }

  return C;
}

// Layout transpose function for A matrix: convert from row-major to 2x1_8x8block layout
// Input: A matrix in normal row-major format
// Output: A matrix in 2x1 arrangement where 8x8 blocks are stacked vertically
// Within each 8x8 block, elements remain in row-major order
std::vector<float> layout_A_2x1_8x8block(std::vector<float>&  input, int rows, int cols) {
  // Ensure dimensions are compatible with 8x8 blocks
  assert(rows % 8 == 0 && "Rows must be divisible by 8");
  assert(cols % 8 == 0 && "Cols must be divisible by 8");

  std::vector<float> output(rows * cols);

  
  int block_rows = rows / 8;  // Number of 8x8 blocks vertically
  int block_cols = cols / 8;  // Number of 8x8 blocks horizontally
  
  // Ensure block dimensions are compatible with 2x1 layout
  assert(block_rows % 2 == 0 && "Block rows must be divisible by 2 for 2x1 layout");
  
  int output_idx = 0;
  
  printf("A layout: block_rows: %d, block_cols: %d\n", block_rows, block_cols);
  
  // Iterate through 2x1 super-blocks (each containing 2 vertically stacked 8x8 blocks) 
  for (int super_block_row = 0; super_block_row < block_rows; super_block_row += 2) {
    for (int super_block_col = 0; super_block_col < block_cols; super_block_col++) {
      // Within each 2x1 super-block, process in column-major order
      // First process the top 8x8 block, then the bottom 8x8 block
      for (int block_in_super = 0; block_in_super < 2; block_in_super++) {
        int current_block_row = super_block_row + block_in_super;
        int current_block_col = super_block_col;
        
        // Within each 8x8 block, keep row-major order
        for (int row_in_block = 0; row_in_block < 8; row_in_block++) {
          for (int col_in_block = 0; col_in_block < 8; col_in_block++) {
            // Calculate the position in the original row-major matrix
            int orig_row = current_block_row * 8 + row_in_block;
            int orig_col = current_block_col * 8 + col_in_block;
            int orig_idx = orig_row * cols + orig_col;
            
            // Copy to output in the new layout
            output[output_idx++] = input[orig_idx];
          }
        }
      }
    }
  }
  return output;
}


std::vector<float> layout_A_L1_2x1_8x8block(std::vector<float>& input, int rows, int cols, int L1_block_m, int L1_block_k) {
  // Ensure dimensions are compatible
  assert(rows % L1_block_m == 0 && "Rows must be divisible by L1_block_m");
  assert(cols % L1_block_k == 0 && "Cols must be divisible by L1_block_k");
  assert(L1_block_m % 8 == 0 && "L1_block_m must be divisible by 8");
  assert(L1_block_k % 8 == 0 && "L1_block_k must be divisible by 8");
  assert((L1_block_m / 8) % 2 == 0 && "L1_block_m/8 must be divisible by 2 for 2x1 layout");

  std::vector<float> output(rows * cols);
  
  int L1_rows = rows / L1_block_m;  // Number of L1 blocks vertically
  int L1_cols = cols / L1_block_k;  // Number of L1 blocks horizontally
  
  printf("L1 layout: L1_rows: %d, L1_cols: %d, L1_block_m: %d, L1_block_k: %d\n", 
         L1_rows, L1_cols, L1_block_m, L1_block_k);
  
  int output_idx = 0;
  
  // Iterate through L1 blocks in row-major order
  for (int L1_row = 0; L1_row < L1_rows; L1_row++) {
    for (int L1_col = 0; L1_col < L1_cols; L1_col++) {
      
      printf("Processing L1 block (%d, %d)\n", L1_row, L1_col);
      
      // Extract the current L1 block data
      std::vector<float> L1_block_data(L1_block_m * L1_block_k);
      for (int i = 0; i < L1_block_m; i++) {
        for (int j = 0; j < L1_block_k; j++) {
          int orig_row = L1_row * L1_block_m + i;
          int orig_col = L1_col * L1_block_k + j;
          int orig_idx = orig_row * cols + orig_col;
          int L1_idx = i * L1_block_k + j;
          L1_block_data[L1_idx] = input[orig_idx];
        }
      }
      
      // Apply 2x1_8x8block transformation to this L1 block
      std::vector<float> transformed_block = layout_A_2x1_8x8block(L1_block_data, L1_block_m, L1_block_k);
      
      // Copy transformed block to output
      for (int k = 0; k < transformed_block.size(); k++) {
        output[output_idx++] = transformed_block[k];
      }
    }
  }
  
  return output;
}



// Layout transpose function: reorganize matrix from row-major to 1x2_8x8block layout
// Input: B (float array), rows x cols, row-major
// Output: transposed layout with 1x2 row-major blocks of 8x8 column-major blocks
std::vector<float> layout_transpose_1x2_8x8block(std::vector<float>& input, int rows, int cols) {
  
  std::vector<float> output(rows * cols);

  int block_rows = rows / 8;  // Number of 8x8 blocks vertically
  int block_cols = cols / 8;  // Number of 8x8 blocks horizontally
  int output_idx = 0;

  printf("block_rows: %d, block_cols: %d\n", block_rows, block_cols);

  // Iterate through 1x2 super-blocks (each containing 2 horizontally stacked 8x8 blocks)
    for (int super_block_col = 0; super_block_col < block_cols; super_block_col += 2) {
  for (int super_block_row = 0; super_block_row < block_rows; super_block_row++) {
      
      // Within each 1x2 super-block, process in row-major order
      // First process the left 8x8 block, then the right 8x8 block
      for (int block_in_super = 0; block_in_super < std::min(2, block_cols - super_block_col); block_in_super++) {
        int current_block_row = super_block_row;
        int current_block_col = super_block_col + block_in_super;
        
        // Within each 8x8 block, process in column-major order
        for (int col_in_block = 0; col_in_block < 8; col_in_block++) {
          for (int row_in_block = 0; row_in_block < 8; row_in_block++) {
            // Calculate the position in the original row-major matrix
            int orig_row = current_block_row * 8 + row_in_block;
            int orig_col = current_block_col * 8 + col_in_block;
            int orig_idx = orig_row * cols + orig_col;
            // printf("orig_row: %d, orig_col: %d, orig_idx: %d\n", orig_row, orig_col, orig_idx);
            // Copy to output in the new layout
            output[output_idx++] = input[orig_idx];
          }
        }
      }
    }
  }
  return output;
}



std::vector<float> layout_transpose_L1_1x2_8x8block(std::vector<float>& input, int rows, int cols, int L1_block_k, int L1_block_n) {
  // Ensure dimensions are compatible
  assert(rows % L1_block_k == 0 && "Rows must be divisible by L1_block_k");
  assert(cols % L1_block_n == 0 && "Cols must be divisible by L1_block_n");
  assert(L1_block_k % 8 == 0 && "L1_block_k must be divisible by 8");
  assert(L1_block_n % 8 == 0 && "L1_block_n must be divisible by 8");
  assert((L1_block_n / 8) % 2 == 0 && "L1_block_n/8 must be divisible by 2 for 1x2 layout");

  std::vector<float> output(rows * cols);
  
  int L1_rows = rows / L1_block_k;  // Number of L1 blocks vertically
  int L1_cols = cols / L1_block_n;  // Number of L1 blocks horizontally
  
  printf("B L1 layout: L1_rows: %d, L1_cols: %d, L1_block_k: %d, L1_block_n: %d\n", 
         L1_rows, L1_cols, L1_block_k, L1_block_n);
  
  int output_idx = 0;
  
  // Iterate through L1 blocks in COLUMN-MAJOR order (top-to-bottom, left-to-right)
  for (int L1_col = 0; L1_col < L1_cols; L1_col++) {
    for (int L1_row = 0; L1_row < L1_rows; L1_row++) {
      
      printf("Processing L1 block (%d, %d)\n", L1_row, L1_col);
      
      // Extract the current L1 block data
      std::vector<float> L1_block_data(L1_block_k * L1_block_n);
      for (int i = 0; i < L1_block_k; i++) {
        for (int j = 0; j < L1_block_n; j++) {
          int orig_row = L1_row * L1_block_k + i;
          int orig_col = L1_col * L1_block_n + j;
          int orig_idx = orig_row * cols + orig_col;
          int L1_idx = i * L1_block_n + j;
          L1_block_data[L1_idx] = input[orig_idx];
        }
      }
      
      // Apply 1x2_8x8block transformation to this L1 block
      std::vector<float> transformed_block = layout_transpose_1x2_8x8block(L1_block_data, L1_block_k, L1_block_n);
      
      // Copy transformed block to output
      for (int k = 0; k < transformed_block.size(); k++) {
        output[output_idx++] = transformed_block[k];
      }
    }
  }
  
  return output;
}



// Helper function: transform a single L1 block from 2x2_8x8block to row-major
std::vector<float> layout_transform_C_2x2_8x8block(std::vector<float>& input, int L1_block_m, int L1_block_n) {
  std::vector<float> output(L1_block_m * L1_block_n);
  
  int input_idx = 0;
  int blocks_per_row = L1_block_n / 8;  // Number of 8x8 blocks horizontally in L1 block
  int blocks_per_col = L1_block_m / 8;  // Number of 8x8 blocks vertically in L1 block
  
  // Process 2x2 super-blocks of 8x8 blocks
  for (int super_block_row = 0; super_block_row < blocks_per_col; super_block_row += 2) {
    for (int super_block_col = 0; super_block_col < blocks_per_row; super_block_col += 2) {
      
      // Within each 2x2 super-block, process in order: [0,0], [0,1], [1,0], [1,1]
      for (int block_row = 0; block_row < 2; block_row++) {
        for (int block_col = 0; block_col < 2; block_col++) {
          
          int current_block_row = super_block_row + block_row;
          int current_block_col = super_block_col + block_col;
          
          // Process each 8x8 block (stored in row-major order in input)
          for (int row_in_block = 0; row_in_block < 8; row_in_block++) {
            for (int col_in_block = 0; col_in_block < 8; col_in_block++) {
              
              // Calculate position in the output (row-major within L1 block)
              int output_row = current_block_row * 8 + row_in_block;
              int output_col = current_block_col * 8 + col_in_block;
              int output_idx = output_row * L1_block_n + output_col;
              
              // Copy from input (2x2_8x8block layout) to output (row-major)
              output[output_idx] = input[input_idx++];
            }
          }
        }
      }
    }
  }
  
  return output;
}




// Layout transform function for C matrix with two-level hierarchy
// Level 1: L1 blocks of size L1_block_m × L1_block_n in row-major order
// Level 2: Within each L1 block, 2x2 arrangement of 8x8 blocks
// Input: C matrix in hierarchical layout
// Output: C matrix in normal row-major format
std::vector<float> layout_transform_C_L1_2x2_8x8block(std::vector<float>& input, int M, int N, int L1_block_m, int L1_block_n) {
  // Ensure dimensions are compatible
  assert(M % L1_block_m == 0 && "M must be divisible by L1_block_m");
  assert(N % L1_block_n == 0 && "N must be divisible by L1_block_n");
  assert(L1_block_m % 16 == 0 && "L1_block_m must be divisible by 16 for 2x2 8x8 blocks");
  assert(L1_block_n % 16 == 0 && "L1_block_n must be divisible by 16 for 2x2 8x8 blocks");

  std::vector<float> output(M * N);
  
  int L1_rows = M / L1_block_m;  // Number of L1 blocks vertically
  int L1_cols = N / L1_block_n;  // Number of L1 blocks horizontally
  
  printf("C L1 layout: L1_rows: %d, L1_cols: %d, L1_block_m: %d, L1_block_n: %d\n", 
         L1_rows, L1_cols, L1_block_m, L1_block_n);
  
  int input_idx = 0;
  
  // Iterate through L1 blocks in row-major order (matching matrix multiplication output)
  for (int L1_row = 0; L1_row < L1_rows; L1_row++) {
    for (int L1_col = 0; L1_col < L1_cols; L1_col++) {
      
      printf("Processing C L1 block (%d, %d)\n", L1_row, L1_col);
      
      // Extract the current L1 block data (in 2x2_8x8block format)
      int L1_block_size = L1_block_m * L1_block_n;
      std::vector<float> L1_block_data(L1_block_size);
      
      for (int i = 0; i < L1_block_size; i++) {
        L1_block_data[i] = input[input_idx++];
      }
      
      // Transform this L1 block from 2x2_8x8block to row-major
      std::vector<float> transformed_block = layout_transform_C_2x2_8x8block(L1_block_data, L1_block_m, L1_block_n);
      
      // Place the transformed L1 block into the correct position in the output matrix
      for (int i = 0; i < L1_block_m; i++) {
        for (int j = 0; j < L1_block_n; j++) {
          int output_row = L1_row * L1_block_m + i;
          int output_col = L1_col * L1_block_n + j;
          int output_idx = output_row * N + output_col;
          int L1_idx = i * L1_block_n + j;
          
          output[output_idx] = transformed_block[L1_idx];
        }
      }
    }
  }
  
  return output;
}






int main(int argc, const char *argv[]) {

  // ------------------------------------------------------
  // Parse program arguments
  // ------------------------------------------------------
  cxxopts::Options options("Matrix Matrix Multiplication Test");
  cxxopts::ParseResult vm;
  matmul_common::add_default_options(options);
  options.add_options()("trows,w", "Tile size m",
                        cxxopts::value<int>()->default_value("64"))(
      "tinner,y", "Tile size k", cxxopts::value<int>()->default_value("64"))(
      "tcolumns,z", "Tile size n", cxxopts::value<int>()->default_value("64"));

  matmul_common::parse_options(argc, argv, options, vm);
  int verbosity = vm["verbosity"].as<int>();
  int do_verify = vm["verify"].as<bool>();
  int n_iterations = vm["iters"].as<int>();
  int n_warmup_iterations = vm["warmup"].as<int>();
  int trace_size = vm["trace_sz"].as<int>();
  int b_col_maj = vm["b_col_maj"].as<int>();

  // Fix the seed to ensure reproducibility in CI.
  srand(1726250518); // srand(time(NULL));

  int M = vm["M"].as<int>();
  int K = vm["K"].as<int>();
  int N = vm["N"].as<int>();

  int m = vm["w"].as<int>();
  int k = vm["y"].as<int>();
  int n = vm["z"].as<int>();


printf("m = %d, n = %d\n", m, n);

  bool do_verify_stochastic = (long long)M * N > verify_stochastic_threshold;

  if (verbosity >= 1) {
    std::cout << "Matrix size " << M << "x" << K << "x" << N << std::endl;
  }

  int A_SIZE = M * K;
  int B_SIZE = N * K;
  int C_SIZE = M * N;

  size_t A_VOLUME = (A_SIZE * sizeof(uint8_t)) * 1.125;
  size_t B_VOLUME = (B_SIZE * sizeof(uint8_t)) * 1.125;
  size_t C_VOLUME = (C_SIZE * sizeof(uint8_t)) * 1.125;

  std::vector<uint32_t> instr_v =
      test_utils::load_instr_binary(vm["instr"].as<std::string>());

  if (verbosity >= 1)
    std::cout << "Sequence instr count: " << instr_v.size() << "\n";

  // ------------------------------------------------------
  // Get device, load the xclbin & kernel and register them
  // ------------------------------------------------------
  // Get a device handle
  unsigned int device_index = 0;
  auto device = xrt::device(device_index);

  // Load the xclbin
  if (verbosity >= 1)
    std::cout << "Loading xclbin: " << vm["xclbin"].as<std::string>() << "\n";
  auto xclbin = xrt::xclbin(vm["xclbin"].as<std::string>());

  if (verbosity >= 1)
    std::cout << "Kernel opcode: " << vm["kernel"].as<std::string>() << "\n";
  std::string Node = vm["kernel"].as<std::string>();

  // Get the kernel from the xclbin
  auto xkernels = xclbin.get_kernels();
  auto xkernel = *std::find_if(xkernels.begin(), xkernels.end(),
                               [Node, verbosity](xrt::xclbin::kernel &k) {
                                 auto name = k.get_name();
                                 if (verbosity >= 1) {
                                   std::cout << "Name: " << name << std::endl;
                                 }
                                 return name.rfind(Node, 0) == 0;
                               });
  auto kernelName = xkernel.get_name();

  if (verbosity >= 1)
    std::cout << "Registering xclbin: " << vm["xclbin"].as<std::string>()
              << "\n";

  device.register_xclbin(xclbin);

  // get a hardware context
  if (verbosity >= 1)
    std::cout << "Getting hardware context.\n";
  xrt::hw_context context(device, xclbin.get_uuid());

  // get a kernel handle
  if (verbosity >= 1)
    std::cout << "Getting handle to kernel:" << kernelName << "\n";
  auto kernel = xrt::kernel(context, kernelName);

  // ------------------------------------------------------
  // Initialize input/output buffer sizes and sync them
  // ------------------------------------------------------

  auto bo_instr = xrt::bo(device, instr_v.size() * sizeof(int),
                          XCL_BO_FLAGS_CACHEABLE, kernel.group_id(1));
  auto bo_a =
      xrt::bo(device, A_VOLUME, XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(3));
  auto bo_b =
      xrt::bo(device, B_VOLUME, XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(4));
  auto bo_out =
      xrt::bo(device, C_VOLUME, XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(5));

  // ------------------------------------------------------
  // Generate data for buffers
  // ------------------------------------------------------
  if (verbosity >= 1) {
    std::cout << "Writing data into buffer objects.\n";
  }

  std::vector<float> AVec(A_SIZE);
  for (int i = 0; i < A_SIZE; i++) {
    AVec[i] = 1 ;
    // AVec[i] = i % 32;
    // AVec[i] = i / (128*64);

    // Limiting to 16 to avoid precision loss issues
    // AVec[i] = (i / K) / 16.0f;
    // if (i % K == i / K) {
    //   AVec[i] = 1.0;
    // } else {
    //   AVec[i] = 0.0;
    // }
    // AVec[i] = (i / 64) % 8;
  }

  std::vector<float> BVec(B_SIZE);
  for (int i = 0; i < B_SIZE; i++) {
    // Limiting to 16 to avoid precision loss issues
    // BVec[i] = (i % N) / 16.0f;
    BVec[i] = 1;
    // BVec[i] =  (i % 32 ) / 8 ;

    // if (i % K == i / K) {
    //   BVec[i] = 1.0;
    // } else {
    //   BVec[i] = 0.0;
    // }
    // if (i % 128 < 8 && i / 128 < 8)
    //   BVec[i] = i / 8;
    // else
    //   BVec[i] = 0.0;
    // BVec[i] = i % 8;
  }

  std::vector<float> BVec_transposed(B_SIZE);
  // Transpose B to column-major format
  for (int i = 0; i < K; i++) {
    for (int j = 0; j < N; j++) {
      BVec_transposed[j * K + i] = BVec[i * N + j];
    }
  }

  // // std::vector<float> BVec_transformed = transform_B_2x2(BVec, K, N);
  std::vector<float> AVec_transformed = layout_A_L1_2x1_8x8block(AVec, M, K, m, k);
  std::vector<float> BVec_transformed = layout_transpose_L1_1x2_8x8block(BVec, K, N, k, n);

  auto AVecBfpShuffled = floatToBfp16(8, A_SIZE, AVec_transformed.data(), 0);
  auto BVecBfpShuffled = floatToBfp16(8, B_SIZE, BVec_transformed.data(), 0);


  // auto AVecBfp = floatToBfp16(8, A_SIZE, AVec.data(), 0);
  // auto BVecBfp = floatToBfp16(8, B_SIZE, BVec_transposed.data(), 0);
  auto shuffleStart = std::chrono::high_resolution_clock::now();
  // std::vector<uint8_t> AVecBfpShuffled = shuffleMatrixForBfp16ebs8RowMajorTiles(K, M, k, m, AVecBfp);
  // std::vector<uint8_t> BVecBfpShuffled = shuffleMatrixForBfp16ebs8RowMajorTiles(K, N, k, n, BVecBfp);
  auto shuffleStop = std::chrono::high_resolution_clock::now();

  float inputShuffleTime =
      std::chrono::duration_cast<std::chrono::microseconds>(shuffleStop -
                                                            shuffleStart)
          .count();

  // std::ofstream outfile1("inputB.txt");
  // matmul_common::print_matrix(BVec, K, N, K, outfile1, " ", " ... ", 3);
  // printBfp16ebs8Array(A_VOLUME, BVecBfp, 16, 16, outfile1);
  // outfile1.close();

  // std::ofstream outfile2("inputBShuffled.txt");
  // auto temp = bfp16ebs8ToFloat(B_VOLUME, BVecBfpShuffled.data());
  // // printBfp16ebs8Array(B_VOLUME, BVecBfpShuffled, 16, 16, outfile2);
  // matmul_common::print_matrix(temp, K, N, K, outfile2, " ", " ... ", 3);
  // outfile2.close();

  // ------------------------------------------------------
  // Write data into buffers
  // ------------------------------------------------------
  uint8_t *bufA = bo_a.map<uint8_t *>();
  uint8_t *bufB = bo_b.map<uint8_t *>();
  memcpy(bufA, AVecBfpShuffled.data(), A_VOLUME);
  memcpy(bufB, BVecBfpShuffled.data(), B_VOLUME);

  // Initialize outputs; bufOut is results matrix
  char *bufOut = bo_out.map<char *>();

  // Instruction buffer for DMA configuration
  void *bufInstr = bo_instr.map<void *>();
  memcpy(bufInstr, instr_v.data(), instr_v.size() * sizeof(int));

  bo_instr.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_a.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_b.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_out.sync(XCL_BO_SYNC_BO_TO_DEVICE);

  // ------------------------------------------------------
  // Run kernel
  // ------------------------------------------------------
  unsigned num_iter = n_iterations + n_warmup_iterations;
  float npu_time_total = 0;
  float npu_time_min = 9999999;
  float npu_time_max = 0;
  float outShuffleTime = 0;

  int errors = 0;
  float macs = 2.0 * float(M) * float(K) * float(N);

  for (unsigned iter = 0; iter < num_iter; iter++) {
    auto start = std::chrono::high_resolution_clock::now();
    unsigned int opcode = 3;
    auto run = kernel(opcode, bo_instr, instr_v.size(), bo_a, bo_b, bo_out);
    ert_cmd_state r = run.wait();
    if (r != ERT_CMD_STATE_COMPLETED) {
      std::cout << "Kernel did not complete. Returned status: " << r << "\n";
      return 1;
    }
    auto stop = std::chrono::high_resolution_clock::now();
    bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

    if (iter < n_warmup_iterations) {
      /* Warmup iterations do not count towards average runtime. */
      continue;
    }

    // ------------------------------------------------------
    // Check output
    // ------------------------------------------------------
    if (do_verify) {
      std::vector<uint8_t> CVecBfp(C_VOLUME);
      memcpy(CVecBfp.data(), bufOut, C_VOLUME);

      auto outShuffleStart = std::chrono::high_resolution_clock::now();
      // std::vector<uint8_t> CVecBfpShuffled =
      //     shuffleMatrixForBfp16ebs8(N, M, n, m, CVecBfp, true);
      auto outShuffleStop = std::chrono::high_resolution_clock::now();

      outShuffleTime += std::chrono::duration_cast<std::chrono::microseconds>(
                            outShuffleStop - outShuffleStart)
                            .count();

      std::vector<float> CVec_raw = bfp16ebs8ToFloat(C_VOLUME, CVecBfp.data(), 0);
      std::vector<float> CVec = layout_transform_C_L1_2x2_8x8block(CVec_raw, M, N, m * 4, n);

      // Compute golden reference for comparison
      if (verbosity >= 1) {
        std::cout << "Computing golden reference ..." << std::endl;
      }
      auto CGolden = computeGoldenReference(AVec, BVec_transposed, M, K, N);

      // Write matrices to CSV files (only on first iteration)
      if (iter == n_warmup_iterations) {
        if (verbosity >= 1) {
          std::cout << "Writing matrices to CSV files ..." << std::endl;
        }
        writeMatrixToCSV(AVec, M, K, "output/matrix_A.csv");
        writeMatrixToCSV(BVec, K, N, "output/matrix_B.csv");
        writeMatrixToCSV(CGolden, M, N, "output/matrix_C_golden.csv");
        writeMatrixToCSV(CVec, M, N, "output/matrix_C_output.csv");
        writeMatrixToCSV(AVec_transformed, M, K, "output/AVec_transformed.csv");
        writeMatrixToCSV(BVec_transformed, K, N, "output/BVec_transformed.csv");
        writeMatrixToCSV(CVec_raw, M, N, "output/CVec_raw.csv");


      }

      if (verbosity >= 1) {
        std::cout << "Verifying against reference matmul ..." << std::endl;
      }
      auto vstart = std::chrono::system_clock::now();
      if (do_verify_stochastic) {
        errors = matmul_common::verify_stochastic<float, float, float>(
            M, N, K, AVec, BVec_transposed, CVec, verify_stochastic_n_samples, verbosity,
            abs_tol, rel_tol, true);
      } else {
        errors = matmul_common::verify<float, float, float>(
            M, N, K, AVec, BVec_transposed, CVec, verbosity, abs_tol * 3, rel_tol, true);
      }
      auto vstop = std::chrono::system_clock::now();

      // std::ofstream outfile("output.txt");
      // matmul_common::print_matrix(CVec, N, M, N, outfile, " ", " ... ", 3);
      // // printBfp16ebs8Array(C_VOLUME, CVecBfp, 16, 16, outfile);
      // outfile.close();

      float vtime =
          std::chrono::duration_cast<std::chrono::seconds>(vstop - vstart)
              .count();
      if (verbosity >= 1) {
        std::cout << "Verify time: " << vtime << " s." << std::endl;
      }
    } else {
      // Even if verification is disabled, we can still save the output matrices
      if (iter == n_warmup_iterations) {
        std::vector<uint8_t> CVecBfp(C_VOLUME);
        memcpy(CVecBfp.data(), bufOut, C_VOLUME);
        
        auto outShuffleStart = std::chrono::high_resolution_clock::now();
        std::vector<uint8_t> CVecBfpShuffled =
            shuffleMatrixForBfp16ebs8(N, M, n, m, CVecBfp, true);
        auto outShuffleStop = std::chrono::high_resolution_clock::now();
        
        auto CVec = bfp16ebs8ToFloat(C_VOLUME, CVecBfpShuffled.data(), 0);
        auto CGolden = computeGoldenReference(AVec, BVec, M, K, N);
        
        if (verbosity >= 1) {
          std::cout << "Writing matrices to CSV files ..." << std::endl;
        }
        writeMatrixToCSV(AVec, M, K, "output/matrix_A.csv");
        writeMatrixToCSV(BVec, K, N, "output/matrix_B.csv");
        writeMatrixToCSV(CGolden, M, N, "output/matrix_C_golden.csv");
        writeMatrixToCSV(CVec, M, N, "output/matrix_C_output.csv");
      }
      
      if (verbosity >= 1)
        std::cout << "WARNING: matmul results not verified." << std::endl;
    }

    float npu_time =
        std::chrono::duration_cast<std::chrono::microseconds>(stop - start)
            .count();

    npu_time_total += npu_time;
    npu_time_min = (npu_time < npu_time_min) ? npu_time : npu_time_min;
    npu_time_max = (npu_time > npu_time_max) ? npu_time : npu_time_max;
  }

  // ------------------------------------------------------
  // Output results
  // ------------------------------------------------------
  std::cout << std::endl
            << "Avg NPU matmul time: " << npu_time_total / n_iterations << "us."
            << std::endl;
  std::cout << "Avg NPU gflops: "
            << macs / (1000 * npu_time_total / n_iterations) << std::endl;

  std::cout << std::endl
            << "Min NPU matmul time: " << npu_time_min << "us." << std::endl;
  std::cout << "Max NPU gflops: " << macs / (1000 * npu_time_min) << std::endl;

  std::cout << std::endl
            << "Max NPU matmul time: " << npu_time_max << "us." << std::endl;
  std::cout << "Min NPU gflops: " << macs / (1000 * npu_time_max) << std::endl;

  std::cout << std::endl
            << "Shuffle time: "
            << inputShuffleTime + (outShuffleTime / n_iterations) << "us."
            << std::endl;

  if (!errors) {
    std::cout << "\nPASS!\n\n";
    return 0;
  }
  std::cout << "\nError count: " << errors;
  if (do_verify_stochastic) {
    std::cout << " (out of " << verify_stochastic_n_samples
              << " random samples)";
  }
  std::cout << "\n\n";
  std::cout << "\nFailed.\n\n";
  return 1;
}