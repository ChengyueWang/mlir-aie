//===- mixed_test.cpp -------------------------------------------*- C++ -*-===//
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
#include <thread>
#include <cstdint>
#include <cstdlib>
#include <ctime>
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

// Print functions for outputting matrices to files
static FILE *open_file(const char* filename, const char *mode) {
    FILE *fp = fopen(filename, mode);
    if (fp == NULL) {
        fprintf(stderr, "ERROR: Cannot open file '%s'.\n", filename);
        exit(1);
    }
    return fp;
}

// Print matrix of float values to file
void print_matrix_float(const char* filename, const float* data, int rows, int cols) {
    FILE* fp = open_file(filename, "w+");
    fprintf(fp, "(%d, %d)\n", rows, cols);
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            fprintf(fp, "%f", data[i * cols + j]);
            if (j < cols - 1) fprintf(fp, " ");
        }
        fprintf(fp, "\n");
    }
    fclose(fp);
}

// Print vector of float values to file
void print_vector_float(const char* filename, const std::vector<float>& data, int rows, int cols) {
    FILE* fp = open_file(filename, "w+");
    fprintf(fp, "(%d, %d)\n", rows, cols);
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            fprintf(fp, "%f", data[i * cols + j]);
            if (j < cols - 1) fprintf(fp, " ");
        }
        fprintf(fp, "\n");
    }
    fclose(fp);
}

// Print vector of bfloat16_t values to file (converted to float)
void print_vector_bfloat16(const char* filename, const std::vector<std::bfloat16_t>& data, int rows, int cols) {
    FILE* fp = open_file(filename, "w+");
    fprintf(fp, "(%d, %d)\n", rows, cols);
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            fprintf(fp, "%f", (float)data[i * cols + j]);
            if (j < cols - 1) fprintf(fp, " ");
        }
        fprintf(fp, "\n");
    }
    fclose(fp);
}

// Matrix initialization functions with different block sizes
// Generic function to initialize matrix with NxN blocks, each block has constant value (1, 2, 3, ...)
void init_matrix_blocks(std::vector<std::bfloat16_t>& matrix, int rows, int cols, int block_size) {
    int block_rows = rows / block_size;  // Number of NxN blocks vertically
    int block_cols = cols / block_size;  // Number of NxN blocks horizontally
    
    for (int block_row = 0; block_row < block_rows; block_row++) {
        for (int block_col = 0; block_col < block_cols; block_col++) {
            int block_id = block_row * block_cols + block_col + 1; // Block value (1, 2, 3, ...)
            // Fill the NxN block with the block_id value
            for (int i = 0; i < block_size; i++) {
                for (int j = 0; j < block_size; j++) {
                    int row = block_row * block_size + i;
                    int col = block_col * block_size + j;
                    if (row < rows && col < cols) {  // Bounds check
                        matrix[row * cols + col] = (std::bfloat16_t)block_id;
                    }
                }
            }
        }
    }
}

// Initialize matrix with 8x8 blocks, each block has constant value (1, 2, 3, ...)
void init_matrix_8x8_blocks(std::vector<std::bfloat16_t>& matrix, int rows, int cols) {
    init_matrix_blocks(matrix, rows, cols, 8);
}

// Initialize matrix with 16x16 blocks, each block has constant value (1, 2, 3, ...)
void init_matrix_16x16_blocks(std::vector<std::bfloat16_t>& matrix, int rows, int cols) {
    init_matrix_blocks(matrix, rows, cols, 16);
}

// Initialize matrix with 32x32 blocks, each block has constant value (1, 2, 3, ...)
void init_matrix_32x32_blocks(std::vector<std::bfloat16_t>& matrix, int rows, int cols) {
    init_matrix_blocks(matrix, rows, cols, 32);
}

// Initialize matrix with constant value
void init_matrix_constant(std::vector<std::bfloat16_t>& matrix, int size, float value) {
    for (int i = 0; i < size; i++) {
        matrix[i] = (std::bfloat16_t)value;
    }
}

// Calculate golden result (reference matrix multiplication)
// Assumes A is M×K row-major, B is K×N row-major, C is M×N row-major
void calc_golden_result(const std::vector<std::bfloat16_t>& A, const std::vector<std::bfloat16_t>& B, 
                       std::vector<std::bfloat16_t>& C, int M, int K, int N) {
    // Initialize output matrix to zero
    std::fill(C.begin(), C.end(), (std::bfloat16_t)0.0f);
    
    // Perform matrix multiplication: C = A * B
    // A[i,k] = A[i * K + k]  (row-major)
    // B[k,j] = B[k * N + j]  (row-major)
    // C[i,j] = C[i * N + j]  (row-major)
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            float sum = 0.0f;
            for (int k = 0; k < K; k++) {
                sum += (float)A[i * K + k] * (float)B[k * N + j]; 
            }
            C[i * N + j] = (std::bfloat16_t)sum;
        }
    }
}




#define XSTR(X) STR(X)
#define STR(X) #X

constexpr long long verify_stochastic_threshold = 1024 * 1024;
constexpr int verify_stochastic_n_samples = 1000;

// Verification tolerance
// See "Note on Numerical Tolerances" in README.md
// TODO: This might have to be adjusted for bfp
float abs_tol = matmul_common::get_abs_tol<std::bfloat16_t>();
float rel_tol = matmul_common::get_rel_tol<std::bfloat16_t>() * 2.0f;

int main(int argc, const char *argv[]) {

  // ------------------------------------------------------
  // Parse program arguments
  // ------------------------------------------------------
  cxxopts::Options options("Matrix Matrix Multiplication Test");
  cxxopts::ParseResult vm;
  matmul_common::add_default_options(options);
  options.add_options()("trows,w", "Tile size m", cxxopts::value<int>()->default_value("64"))(
      "tinner,y", "Tile size k", cxxopts::value<int>()->default_value("64"))(
      "tcolumns,z", "Tile size n", cxxopts::value<int>()->default_value("64"));

  matmul_common::parse_options(argc, argv, options, vm);
  int verbosity = vm["verbosity"].as<int>();
  // int do_verify = vm["verify"].as<bool>();
  bool do_verify = 1;
  // int n_iterations = vm["iters"].as<int>();
  // int n_warmup_iterations = vm["warmup"].as<int>();
  int n_iterations = 1;
  int n_warmup_iterations = 0;
  // int trace_size = vm["trace_sz"].as<int>();
  int trace_size = 81920;
  int b_col_maj = vm["b_col_maj"].as<int>();

  printf("b_col_maj: %d\n", b_col_maj);

  // Fix the seed to ensure reproducibility in CI.
  srand(1726250518); // srand(time(NULL));

  int M = vm["M"].as<int>();
  int K = vm["K"].as<int>();
  int N = vm["N"].as<int>();

  int m = vm["w"].as<int>();
  int k = vm["y"].as<int>();
  int n = vm["z"].as<int>();

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

  std::vector<uint32_t> instr_v = test_utils::load_instr_binary(vm["instr"].as<std::string>());

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
  auto xkernel =
      *std::find_if(xkernels.begin(), xkernels.end(), [Node, verbosity](xrt::xclbin::kernel &k) {
        auto name = k.get_name();
        if (verbosity >= 1) {
          std::cout << "Name: " << name << std::endl;
        }
        return name.rfind(Node, 0) == 0;
      });
  auto kernelName = xkernel.get_name();

  if (verbosity >= 1)
    std::cout << "Registering xclbin: " << vm["xclbin"].as<std::string>() << "\n";

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

  auto bo_instr =
      xrt::bo(device, instr_v.size() * sizeof(int), XCL_BO_FLAGS_CACHEABLE, kernel.group_id(1));
  auto bo_a =
      xrt::bo(device, A_SIZE * sizeof(std::bfloat16_t), XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(3));
  auto bo_b = xrt::bo(device, B_VOLUME, XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(4));
  auto bo_out =
      xrt::bo(device, C_SIZE * sizeof(std::bfloat16_t), XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(5));

  auto bo_tmp1 = xrt::bo(device, 1, XRT_BO_FLAGS_HOST_ONLY, kernel.group_id(6));

  // Workaround so we declare a really small trace buffer when one is not used
  int tmp_trace_size = (trace_size > 0) ? trace_size : 1;
  auto bo_trace = xrt::bo(device, tmp_trace_size * 4, XRT_BO_FLAGS_HOST_ONLY,
                          kernel.group_id(7));

  // ------------------------------------------------------
  // Generate data for buffers
  // ------------------------------------------------------
  if (verbosity >= 1) {
    std::cout << "Writing data into buffer objects.\n";
  }

  std::vector<std::bfloat16_t> AVec(A_SIZE);
  
  // Alternative initialization options:
  // init_matrix_8x8_blocks(AVec, M, K);     // For 8x8 block pattern
  // init_matrix_16x16_blocks(AVec, M, K);   // For 16x16 block pattern
  // init_matrix_32x32_blocks(AVec, M, K);   // For 32x32 block pattern
  // init_matrix_constant(AVec, A_SIZE, 1.0f); // For constant values
  
  for (int i = 0; i < A_SIZE; i++) {
    // Limiting to 16 to avoid precision loss issues
    AVec[i] = 1;
    // AVec[i] = (std::bfloat16_t)((rand() % 8) - 4);
    // AVec[i] = i % 256;
    // AVec[i] = i / 4096;
    // if (i % N == i / N) {
    //   AVec[i] = i;
    // } else {
    //   AVec[i] = 0.0;
    // }
    // AVec[i] = (i / 8) % 1000;
  }

  std::vector<std::bfloat16_t> BVec(B_SIZE);  // K×N row-major
  std::vector<std::bfloat16_t> BVec_col_major(B_SIZE);  // N×K column-major
  

  // Alternative initialization options:
  // init_matrix_8x8_blocks(BVec, K, N);     // For 8x8 block pattern
  // init_matrix_16x16_blocks(BVec, K, N);   // For 16x16 block pattern
  // init_matrix_32x32_blocks(BVec, K, N);   // For 32x32 block pattern
  // init_matrix_constant(BVec, B_SIZE, 1.0f); // For constant values
  

  for (int i = 0; i < B_SIZE; i++) {
    // Limiting to 16 to avoid precision loss issues
    BVec[i] = 1;
    // BVec[i] = i / 4096;
    // BVec[i] = i % 128 ; 
    // BVec[i] = (std::bfloat16_t)((rand() % 8) - 4);
    // Diagonal:
    // if (i % N == i / N) {
    //   BVec[i] = i; //1.0;
    // } else {
    //   BVec[i] = 0.0;
    // }
  }
  // init_matrix_blocks(AVec, M, K, 32);
  // init_matrix_blocks(BVec, K, N, 16);
  // BVec[0] = 1;
  // BVec[1] = 2;
  // BVec[2] = 3;
  // BVec[3] = 4;

  // This is a quick conversion to avoid having to create a custom function for bf16 for now
  std::vector<float> BVecFloat(B_SIZE);
  for (int i = 0; i < B_SIZE; i++) {
    BVecFloat[i] = (float)BVec[i];  // Use original row-major BVec
  }


  std::vector<float> BVec_transformed = transform_B(BVecFloat, K, N);
  auto BVecBfpShuffled = floatToBfp16(8, B_SIZE, BVec_transformed.data(), 0);


  // auto BVecBfp = floatToBfp16(8, B_SIZE, BVecFloat.data(), 0);
  auto shuffleStart = std::chrono::high_resolution_clock::now();
  auto shuffleStop = std::chrono::high_resolution_clock::now();
  // std::vector<uint8_t> BVecBfpShuffled = shuffleMatrixForBfp16ebs8(K, N, k, n, BVecBfp);
  float shuffleTime = std::chrono::duration_cast<std::chrono::microseconds>(shuffleStop - shuffleStart).count();

  // Save shuffled matrix as floats to file
  // saveShuffledMatrixAsFloats(K, N, BVecBfpShuffled, "output/B_shuffled.txt");
  print_vector_float("output/B_shuffled_float.txt", BVec_transformed, K, N);

  // ------------------------------------------------------
  // Calculate golden result (reference matrix multiplication)
  // ------------------------------------------------------
  std::vector<std::bfloat16_t> GoldenVec(C_SIZE);
  auto goldenStart = std::chrono::high_resolution_clock::now();
  if (verbosity >= 1 && do_verify == true) {
    std::cout << "Calculating golden result..." << std::endl;
    calc_golden_result(AVec, BVec, GoldenVec, M, K, N);
  }
  auto goldenStop = std::chrono::high_resolution_clock::now();
  
  float goldenTime = 
      std::chrono::duration_cast<std::chrono::microseconds>(goldenStop - goldenStart).count();

  // ------------------------------------------------------
  // Save matrices to output files for debugging/analysis
  // ------------------------------------------------------
  if (verbosity >= 1) {
    std::cout << "Saving matrices to output/ directory..." << std::endl;
  }
  
  // Print input matrices (converted to float format)
  print_vector_bfloat16("output/A_matrix.txt", AVec, M, K);
  print_vector_bfloat16("output/B_matrix_row_major.txt", BVec, K, N);
  // print_vector_bfloat16("output/B_matrix_col_major.txt", BVec_col_major, N, K);
  
  // Print golden result (reference output)
  print_vector_bfloat16("output/Golden_matrix.txt", GoldenVec, M, N);

  // ------------------------------------------------------
  // Write data into buffers
  // ------------------------------------------------------
  std::bfloat16_t *bufA = bo_a.map<std::bfloat16_t *>();
  uint8_t *bufB = bo_b.map<uint8_t *>();
  memcpy(bufA, AVec.data(), AVec.size() * sizeof(std::bfloat16_t));
  memcpy(bufB, BVecBfpShuffled.data(), B_VOLUME);

  // Initialize outputs; bufOut is results matrix
  char *bufOut = bo_out.map<char *>();

  char *bufTrace = bo_trace.map<char *>();
  if (trace_size > 0)
    memset(bufTrace, 0, trace_size);

  // Instruction buffer for DMA configuration
  void *bufInstr = bo_instr.map<void *>();
  memcpy(bufInstr, instr_v.data(), instr_v.size() * sizeof(int));

  std::cout << "sync input arguments \n"; 

  bo_instr.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_a.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_b.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  bo_out.sync(XCL_BO_SYNC_BO_TO_DEVICE);
  if (trace_size > 0)
    bo_trace.sync(XCL_BO_SYNC_BO_TO_DEVICE);

  // ------------------------------------------------------
  // Run kernel
  // ------------------------------------------------------
  unsigned num_iter = n_iterations + n_warmup_iterations;
  float npu_time_total = 0;
  float npu_time_min = 9999999;
  float npu_time_max = 0;

  int errors = 0;
  float macs = 2.0 * float(M) * float(K) * float(N);

  std::cout << "run kernels \n"; 

  for (unsigned iter = 0; iter < num_iter; iter++) {

    // sleep(0.01);

    std::cout << "run iteration " << iter << "\n";

    auto start = std::chrono::high_resolution_clock::now();
    unsigned int opcode = 3;
    auto run = kernel(opcode, bo_instr, instr_v.size(), bo_a, bo_b, bo_out,
                      bo_tmp1, bo_trace);

    std::cout << "launched kernel iteration " << iter << "\n";
    ert_cmd_state r = run.wait();
    if (r != ERT_CMD_STATE_COMPLETED) {
      std::cout << "Kernel did not complete. Returned status: " << r << "\n";
      return 1;
    }
    std::cout << "finsh kernel iteration " << iter << "\n";
    auto stop = std::chrono::high_resolution_clock::now();
    bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    if (trace_size > 0)
      bo_trace.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

    if (iter < n_warmup_iterations) {
      /* Warmup iterations do not count towards average runtime. */
      continue;
    }
    
    float npu_time = std::chrono::duration_cast<std::chrono::microseconds>(stop - start).count();

    npu_time_total += npu_time;
    npu_time_min = (npu_time < npu_time_min) ? npu_time : npu_time_min;
    npu_time_max = (npu_time > npu_time_max) ? npu_time : npu_time_max;
  }

  // Only write out trace of last iteration.
  if (trace_size > 0) {
    matmul_common::write_out_trace((char *)bufTrace, trace_size,
                                   vm["trace_file"].as<std::string>());
  }

  // ------------------------------------------------------
  // Check output
  // ------------------------------------------------------
  if (do_verify) {
    std::vector<std::bfloat16_t> CVec(C_SIZE);
    memcpy(CVec.data(), bufOut, CVec.size() * sizeof(std::bfloat16_t));

    // Save output matrix (only for first iteration to avoid overwriting)
    // if (iter == n_warmup_iterations && verbosity >= 1) {
    if ( verbosity >= 1) {
      std::cout << "Saving output matrix to output/ directory..." << std::endl;
      print_vector_bfloat16("output/C_matrix.txt", CVec, M, N);
    }

    if (verbosity >= 1) {
      std::cout << "Verifying against reference matmul ..." << std::endl;
    }
    auto vstart = std::chrono::system_clock::now();
    
    // Create reference matrices for comparison using different accumulation types
    std::vector<std::bfloat16_t> CRef_bfloat(C_SIZE);
    std::vector<std::bfloat16_t> CRef_float(C_SIZE);
    
    // // Debug: Check a few input values
    // std::cout << "Debug: A[0]=" << (float)AVec[0] << ", A[1]=" << (float)AVec[1] << std::endl;
    // std::cout << "Debug: B[0]=" << (float)BVec[0] << ", B[1]=" << (float)BVec[1] << std::endl;
    // std::cout << "Debug: K=" << K << ", expecting result=" << K << std::endl;
    
    // // Manual debug calculation for element [0,0] with bfloat16 accumulation
    // std::bfloat16_t debug_sum_bf16 = 0;
    // float debug_sum_float = 0;
    // for (int k = 0; k < K; k++) {
    //     std::bfloat16_t a_val = AVec[0 * K + k];  // A[0,k]
    //     std::bfloat16_t b_val = BVec[k * N + 0];  // B[k,0]
    //     std::bfloat16_t product = a_val * b_val;
    //     debug_sum_bf16 += product;
    //     debug_sum_float += (float)product;
        
    //     if (k < 10 || k >= K-5) {  // Print first 10 and last 5 iterations
    //         std::cout << "Debug k=" << k << ": A[0," << k << "]=" << (float)a_val 
    //                  << ", B[" << k << ",0]=" << (float)b_val 
    //                  << ", product=" << (float)product 
    //                  << ", sum_bf16=" << (float)debug_sum_bf16 
    //                  << ", sum_float=" << debug_sum_float << std::endl;
    //     }
    // }
    // std::cout << "Debug final sums for [0,0]: bf16=" << (float)debug_sum_bf16 
    //           << ", float=" << debug_sum_float << std::endl;
    
    // Calculate reference with bfloat16 accumulation
    matmul_common::matmul<std::bfloat16_t, std::bfloat16_t, std::bfloat16_t>(
        M, N, K, AVec, BVec, CRef_bfloat, 0);
    
    // Calculate reference with float accumulation  
    matmul_common::matmul<std::bfloat16_t, std::bfloat16_t, float>(
        M, N, K, AVec, BVec, CRef_float, 0);
        
    // // Debug: Check results
    // std::cout << "Debug results: CRef_bfloat[0]=" << (float)CRef_bfloat[0] 
    //           << ", CRef_float[0]=" << (float)CRef_float[0] << std::endl;
    
    // Save both reference matrices for comparison
    // if (iter == n_warmup_iterations) {
      print_vector_bfloat16("output/C_verify_acc_bfloat.txt", CRef_bfloat, M, N);
      print_vector_bfloat16("output/C_verify_acc_float.txt", CRef_float, M, N);
    // }
    
    if (do_verify_stochastic) {
      errors =
          matmul_common::verify_stochastic<std::bfloat16_t, std::bfloat16_t, float>(
              M, N, K, AVec, BVec, CVec, verify_stochastic_n_samples, verbosity, abs_tol, rel_tol,
              0);  // Use b_col_maj=0 for row-major interpretation
    } else {
      errors = matmul_common::verify<std::bfloat16_t, std::bfloat16_t, float>(
          M, N, K, AVec, BVec, CVec, verbosity, abs_tol, rel_tol, 0);  // Use float for accumulation
    }
    auto vstop = std::chrono::system_clock::now();

    float vtime = std::chrono::duration_cast<std::chrono::seconds>(vstop - vstart).count();
    if (verbosity >= 1) {
      std::cout << "Verify time: " << vtime << " s." << std::endl;
    }
  } else {
    if (verbosity >= 1)
      std::cout << "WARNING: matmul results not verified." << std::endl;
  }



  // ------------------------------------------------------
  // Output results
  // ------------------------------------------------------
  std::cout << std::endl
            << "Avg NPU matmul time: " << npu_time_total / n_iterations << "us." << std::endl;
  std::cout << "Avg NPU gflops: " << macs / (1000 * npu_time_total / n_iterations) << std::endl;

  std::cout << std::endl << "Min NPU matmul time: " << npu_time_min << "us." << std::endl;
  std::cout << "Max NPU gflops: " << macs / (1000 * npu_time_min) << std::endl;

  std::cout << std::endl << "Max NPU matmul time: " << npu_time_max << "us." << std::endl;
  std::cout << "Min NPU gflops: " << macs / (1000 * npu_time_max) << std::endl;

  std::cout << std::endl << "Shuffle time: " << shuffleTime << "us." << std::endl;
  std::cout << "Golden result computation time: " << goldenTime << "us." << std::endl;

  if (!errors && do_verify) {
    std::cout << "\nPASS!\n\n";
    return 0;
  }

  std::cout << "\nError count: " << errors;
  if (do_verify_stochastic) {
    std::cout << " (out of " << verify_stochastic_n_samples << " random samples)";
  }
  std::cout << "\n\n";

  std::cout << "\nFailed.\n\n";
  return 1;
}
