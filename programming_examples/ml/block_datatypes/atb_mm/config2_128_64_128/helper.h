//===- helper.h -------------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// Copyright (C) 2025, Advanced Micro Devices, Inc.
//
//===----------------------------------------------------------------------===//

#include <bitset>
#include <cassert>
#include <cfloat>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <ostream>
#include <random>
#include <vector>

inline std::string toBinaryString(int8_t n) {
  std::bitset<8> bits(static_cast<uint8_t>(n));
  std::string binary_str = bits.to_string();
  binary_str.insert(4, " ");

  return binary_str;
}

// Helper function to generate random floating point numbers with high exponent
// variance (useful for blocked datatypes). Exponents are interpreted as base 2
inline float generateRandomFloatingPoint(std::mt19937 &eng, double minExp, double maxExp) {
  std::uniform_real_distribution<float> distrExp(minExp, maxExp);
  float exponent = distrExp(eng);

  std::uniform_real_distribution<float> distrMantissa(0.0, 1.0);
  float mantissa = distrMantissa(eng);

  return mantissa * std::pow(2.0, exponent);
}

// block - block size
// size  - length of the input array
// array - the array
// returnArray - the array to be filled with the quantized values
// rounding - 0 for zero, 1 for nearest (tie to even)
// verbose - make some noise
// Quantization of an array of floats to bfp16.
// The return array is structured as follows:
// 1. The first byte is the shared exponent (max exponent of the block).
// 2. The next *block* bytes are the quantized values.
inline std::vector<uint8_t> floatToBfp16(int block, int size, float *array, int rounding = 0) {
  std::vector<uint8_t> res(size * 1.125);

  int mbits = 7;
  int start = 0, end, i, currentIndex = 1;
  unsigned int sign, exp, maxExp;
  unsigned int *p, mantissa;
  uint8_t valueInt8;

  while (true) {
    // decide on the block (starting and ending point)
    end = start + block;
    end = end > size ? size : end;

    // Find max exp
    maxExp = 0;
    for (i = start; i < end; i++) {
      p = (unsigned int *)(array + i);
      exp = *p >> 23;    // Get rid of mantissa
      exp &= 0x000000FF; // Keep the last 8 bit exponent (remove sign)

      maxExp = maxExp < exp ? exp : maxExp;
    }

    // Round each number
    for (i = start; i < end; i++) {
      p = (unsigned int *)(array + i);

      sign = *p & 0x80000000;     // Sign
      exp = *p >> 23;             // Get rid of mantissa
      exp &= 0x000000FF;          // Keep the last 8 bit exponent (remove sign)
      mantissa = *p & 0x007FFFFF; // 23-bit mantissa
      if (exp)
        mantissa |= 0x00800000; // add the implicit for normal value

      if (exp >= 255)
        continue; // Infinity or NaN remains

      // The rouding mode for the mantissa in AIE2p is always truncation
      // Each scalar value is stored in two's complement representation
      mantissa = sign ? ~mantissa + 1 : mantissa;
      // At least erase 23 - mbits + 1 (+1 is for making the implicit bit
      // explicit)
      valueInt8 = mantissa >> (23 - mbits + 1);

      // Note that shifting by more than 32 bits is undefined behavior in C++
      if (maxExp - exp >= 32) {
        valueInt8 = sign ? 0xff : 0x00;
      } else {
        // Perform an arithmetic right shift
        // Again, the rounding mode is truncation for AIE2p
        valueInt8 = static_cast<int8_t>(valueInt8) >> (maxExp - exp);
      }

      res[currentIndex] = valueInt8;
      currentIndex++;
    }
    res[currentIndex - 9] = (uint8_t)maxExp;
    currentIndex++;
    start = end;
    if (start >= size)
      break;
  }

  return res;
}

// Convert a bfp16 array to a float.
// Size should be the number of bytes in the input bfp16 array
inline std::vector<float> bfp16ebs8ToFloat(int size, uint8_t *array, int verbose = 0) {
  std::vector<float> res(size / 1.125);

  int block = 8;
  int tempIndx = 0;
  for (int i = 0; i < size; i += block + 1) {
    uint8_t sharedExponent = (uint8_t)array[i];
    float multiplier;
    if (sharedExponent >= 127) {
      multiplier = 1.0 * (1 << (sharedExponent - 127));
    } else {
      multiplier = 1.0 / (1 << (127 - sharedExponent));
    }
    multiplier /= 64.0;
    if (verbose) {
      printf("shared_exponent = %d\n", sharedExponent);
      printf("multiplier = %f\n", multiplier);
    }
    for (int j = 1; j < block + 1; j++) {
      bool negative = array[i + j] & 0x80;
      if (negative) {
        // Two's complement for negative numbers
        uint8_t decoded = ~(array[i + j] - 1);
        res[tempIndx] = float(decoded) * multiplier;
      } else {
        res[tempIndx] = float(array[i + j] * multiplier);
      }
      res[tempIndx] = negative ? -res[tempIndx] : res[tempIndx];
      if (verbose) {
        printf("return_array[%d] = %f\n", tempIndx, res[tempIndx]);
      }
      tempIndx++;
    }
  }

  return res;
}

// Shuffle tiles of 64x64 elements for the matrix
// Width and height are expected to be the number of scalar elements in the matrix
// This function rearranges the 8x8 subtiles into rows so that a single subtile is contiguous in
// memory within each tile.
inline std::vector<uint8_t> shuffleMatrixForBfp16ebs8(size_t matrixWidth, size_t matrixHeight,
                                                      size_t tileWidth, size_t tileHeight,
                                                      std::vector<uint8_t> bfpMatrix,
                                                      bool unshuffle = false) {
  assert(matrixWidth % tileWidth == 0 && "Matrix width must be divisible by tile width");
  assert(matrixHeight % tileHeight == 0 && "Matrix height must be divisible by tile height");
  assert(tileWidth % 64 == 0 && "Tile width must be a multiple of 64");
  assert(tileHeight % 8 == 0 && "Tile height must be a multiple of 8");
  assert(bfpMatrix.size() == (size_t)matrixWidth * matrixHeight * 1.125 &&
         "Matrix size must be width*height*1.125");

  matrixWidth = matrixWidth * 1.125;
  std::vector<uint8_t> res(matrixWidth * matrixHeight);

  tileWidth = tileWidth * 1.125;

  size_t subtileWidth = 8 * 1.125;
  size_t subtileHeight = 8;

  // The main idea is that inputGlobal X and Y are traversing the input matrix in the order we want
  // the elements to be accessed by the core, while outputGlobal X and Y are traversing the tiles in
  // the way they are going to be sent to the accelerator. Essentially, outputGlobal X and Y are
  // just traversing the tiles themselves as if they were contiguous and then going to the next
  // tile.

  // Iterate over the tiles in the matrix
  for (size_t tileStartY = 0; tileStartY < matrixHeight; tileStartY += tileHeight) {
    for (size_t tileStartX = 0; tileStartX < matrixWidth; tileStartX += tileWidth) {

      size_t tileCountingIndex = 0;
      // Iterate over the subtiles in each tile
      for (size_t subtileStartY = 0; subtileStartY < tileHeight; subtileStartY += subtileHeight) {
        for (size_t subtileStartX = 0; subtileStartX < tileWidth; subtileStartX += subtileWidth) {

          // Iterate over the elements in each subtile
          for (size_t i = 0; i < subtileHeight; ++i) {
            for (size_t j = 0; j < subtileWidth; ++j) {
              size_t inputGlobalX = tileStartX + subtileStartX + j;
              size_t inputGlobalY = tileStartY + subtileStartY + i;
              size_t inputIndex = inputGlobalY * matrixWidth + inputGlobalX;

              size_t outputGlobalX = tileStartX + tileCountingIndex % tileWidth;
              size_t outputGlobalY = tileStartY + tileCountingIndex / tileWidth;
              size_t outputIndex = outputGlobalY * matrixWidth + outputGlobalX;

              if (!unshuffle) {
                res[outputIndex] = bfpMatrix[inputIndex];
              } else {
                res[inputIndex] = bfpMatrix[outputIndex];
              }
              tileCountingIndex++;
            }
          }
        }
      }
    }
  }

  return res;
}

// Enhanced shuffle function that makes both subtiles AND tiles contiguous in memory
// This function first arranges tiles contiguously, then within each tile arranges subtiles contiguously
// Width and height are expected to be the number of scalar elements in the matrix
inline std::vector<uint8_t> shuffleMatrixForBfp16ebs8RowMajorTiles(size_t matrixWidth, size_t matrixHeight,
                                                             size_t tileWidth, size_t tileHeight,
                                                             std::vector<uint8_t> bfpMatrix,
                                                             bool unshuffle = false) {
  assert(matrixWidth % tileWidth == 0 && "Matrix width must be divisible by tile width");
  assert(matrixHeight % tileHeight == 0 && "Matrix height must be divisible by tile height");
  // assert(tileWidth % 64 == 0 && "Tile width must be a multiple of 64");
  // assert(tileHeight % 8 == 0 && "Tile height must be a multiple of 8");
  assert(bfpMatrix.size() == (size_t)matrixWidth * matrixHeight * 1.125 &&
         "Matrix size must be width*height*1.125");

  matrixWidth = matrixWidth * 1.125;
  std::vector<uint8_t> res(matrixWidth * matrixHeight);

  tileWidth = tileWidth * 1.125;

  size_t subtileWidth = 8 * 1.125;
  size_t subtileHeight = 8;
  
  size_t tilesPerRow = matrixWidth / tileWidth;
  size_t tilesPerCol = matrixHeight / tileHeight;
  size_t totalTiles = tilesPerRow * tilesPerCol;
  size_t elementsPerTile = tileWidth * tileHeight;

  // Enhanced layout: tiles are arranged contiguously, and within each tile, subtiles are contiguous
  // Tile ordering: row-major order of tiles
  // Within each tile: subtiles in row-major order, elements within subtiles in row-major order

  // Iterate over tiles in row-major order (makes tiles contiguous)
  for (size_t tileRow = 0; tileRow < tilesPerCol; tileRow++) {
    for (size_t tileCol = 0; tileCol < tilesPerRow; tileCol++) {
      
      size_t tileStartY = tileRow * tileHeight;
      size_t tileStartX = tileCol * tileWidth;
      size_t tileIndex = tileRow * tilesPerRow + tileCol;  // Linear tile index
      
      size_t tileElementCounter = 0;
      
      // Within each tile, iterate over subtiles in row-major order (makes subtiles contiguous)
      for (size_t subtileStartY = 0; subtileStartY < tileHeight; subtileStartY += subtileHeight) {
        for (size_t subtileStartX = 0; subtileStartX < tileWidth; subtileStartX += subtileWidth) {

          // Within each subtile, iterate over elements in row-major order
          for (size_t i = 0; i < subtileHeight; ++i) {
            for (size_t j = 0; j < subtileWidth; ++j) {
              
              // Input position (original 2D matrix layout)
              size_t inputGlobalX = tileStartX + subtileStartX + j;
              size_t inputGlobalY = tileStartY + subtileStartY + i;
              size_t inputIndex = inputGlobalY * matrixWidth + inputGlobalX;

              // Output position (enhanced contiguous layout)
              // All tiles are laid out contiguously, and within each tile, all subtiles are contiguous
              size_t outputIndex = tileIndex * elementsPerTile + tileElementCounter;

              if (!unshuffle) {
                res[outputIndex] = bfpMatrix[inputIndex];
              } else {
                res[inputIndex] = bfpMatrix[outputIndex];
              }
              
              tileElementCounter++;
            }
          }
        }
      }
    }
  }

  return res;
}

// Enhanced shuffle function with column-major tile ordering
// This function arranges tiles in column-major order, then within each tile arranges subtiles contiguously
// Width and height are expected to be the number of scalar elements in the matrix
inline std::vector<uint8_t> shuffleMatrixForBfp16ebs8ColMajorTiles(size_t matrixWidth, size_t matrixHeight,
                                                                   size_t tileWidth, size_t tileHeight,
                                                                   std::vector<uint8_t> bfpMatrix,
                                                                   bool unshuffle = false) {
  assert(matrixWidth % tileWidth == 0 && "Matrix width must be divisible by tile width");
  assert(matrixHeight % tileHeight == 0 && "Matrix height must be divisible by tile height");
  assert(tileWidth % 64 == 0 && "Tile width must be a multiple of 64");
  assert(tileHeight % 8 == 0 && "Tile height must be a multiple of 8");
  assert(bfpMatrix.size() == (size_t)matrixWidth * matrixHeight * 1.125 &&
         "Matrix size must be width*height*1.125");

  matrixWidth = matrixWidth * 1.125;
  std::vector<uint8_t> res(matrixWidth * matrixHeight);

  tileWidth = tileWidth * 1.125;

  size_t subtileWidth = 8 * 1.125;
  size_t subtileHeight = 8;
  
  size_t tilesPerRow = matrixWidth / tileWidth;
  size_t tilesPerCol = matrixHeight / tileHeight;
  size_t totalTiles = tilesPerRow * tilesPerCol;
  size_t elementsPerTile = tileWidth * tileHeight;

  // Column-major tile layout: tiles are arranged in column-major order (column by column)
  // Tile ordering: column-major order of tiles (traverse columns first, then rows)
  // Within each tile: subtiles in row-major order, elements within subtiles in row-major order

  // Iterate over tiles in column-major order (makes tiles contiguous column-wise)
  for (size_t tileCol = 0; tileCol < tilesPerRow; tileCol++) {
    for (size_t tileRow = 0; tileRow < tilesPerCol; tileRow++) {
      
      size_t tileStartY = tileRow * tileHeight;
      size_t tileStartX = tileCol * tileWidth;
      size_t tileIndex = tileCol * tilesPerCol + tileRow;  // Column-major linear tile index
      
      size_t tileElementCounter = 0;
      
      // Within each tile, iterate over subtiles in row-major order (makes subtiles contiguous)
      for (size_t subtileStartY = 0; subtileStartY < tileHeight; subtileStartY += subtileHeight) {
        for (size_t subtileStartX = 0; subtileStartX < tileWidth; subtileStartX += subtileWidth) {

          // Within each subtile, iterate over elements in row-major order
          for (size_t i = 0; i < subtileHeight; ++i) {
            for (size_t j = 0; j < subtileWidth; ++j) {
              
              // Input position (original 2D matrix layout)
              size_t inputGlobalX = tileStartX + subtileStartX + j;
              size_t inputGlobalY = tileStartY + subtileStartY + i;
              size_t inputIndex = inputGlobalY * matrixWidth + inputGlobalX;

              // Output position (column-major tile contiguous layout)
              // All tiles are laid out in column-major order, and within each tile, all subtiles are contiguous
              size_t outputIndex = tileIndex * elementsPerTile + tileElementCounter;

              if (!unshuffle) {
                res[outputIndex] = bfpMatrix[inputIndex];
              } else {
                res[inputIndex] = bfpMatrix[outputIndex];
              }
              
              tileElementCounter++;
            }
          }
        }
      }
    }
  }

  return res;
}

// Pretty print to ostream a bfp16ebs8 array
inline void printBfp16ebs8Array(int arraySize, std::vector<uint8_t> array, int blocksPerLine = 4,
                                int blocksBeforeEmptyLine = 8, std::ostream &ostream = std::cout,
                                int width = 3, const std::string &blockSeparatorStart = " | B",
                                const std::string &blockSeparatorEnd = " - ") {
  for (int i = 0; i < arraySize; i++) {
    if (i % (blocksPerLine * 9) == 0) {
      ostream << "\n";
      if (i % (blocksBeforeEmptyLine * 9) == 0) {
        ostream << "\n";
      }
    }

    if (i % 9 == 0) {
      ostream << blockSeparatorStart << std::setw(width) << i / 9 << " - ";
    }

    ostream << std::setw(4) << int(array[i]);
  }

  ostream << std::endl;
}

// Helper function to save shuffled matrix as floats to file
inline void saveShuffledMatrixAsFloats(size_t matrixWidth, size_t matrixHeight,
                                      std::vector<uint8_t> shuffledMatrix,
                                      const std::string& filename = "output/B_shuffled.txt") {
  // Convert to float
  std::vector<float> floatMatrix = bfp16ebs8ToFloat(shuffledMatrix.size(), shuffledMatrix.data());
  
  // Save to file
  std::ofstream outFile(filename);
  if (outFile.is_open()) {
    outFile << std::fixed << std::setprecision(6);
    
    // Print matrix dimensions as header
    outFile << "# Shuffled Matrix: " << matrixWidth << "x" << matrixHeight << "\n";
    
    // Print floats in matrix format
    for (size_t i = 0; i < floatMatrix.size(); ++i) {
      if (i % matrixWidth == 0 && i > 0) {
        outFile << "\n";
      }
      outFile << std::setw(12) << floatMatrix[i] << " ";
    }
    outFile << "\n";
    outFile.close();
    
    std::cout << "Shuffled matrix saved as floats to: " << filename << std::endl;
  } else {
    std::cerr << "Error: Could not open file " << filename << " for writing." << std::endl;
  }
}

// Transform B matrix from row-major to column-major 64x64 blocks with 1x4 groups of 8x8 sub-blocks
// Input: row-major matrix of size height x width
// Output: matrix arranged in column-major 64x64 blocks, with 1x4 groups (8x32 elements each), in 8x2 arrangement
inline std::vector<float> transform_B_1x4(const std::vector<float>& input, size_t height, size_t width) {
  assert(height % 64 == 0 && "Height must be divisible by 64");
  assert(width % 64 == 0 && "Width must be divisible by 64");
  assert(input.size() == height * width && "Input size must match height * width");
  
  std::vector<float> output(height * width);
  
  size_t big_blocks_rows = height / 64;    // Number of 64x64 blocks vertically
  size_t big_blocks_cols = width / 64;     // Number of 64x64 blocks horizontally
  
  // Iterate through 64x64 blocks in column-major order
  for (size_t big_block_col = 0; big_block_col < big_blocks_cols; big_block_col++) {
    for (size_t big_block_row = 0; big_block_row < big_blocks_rows; big_block_row++) {
      
      // Within each 64x64 block, we have an 8×2 arrangement of 1×4 groups
      // Each 1×4 group contains 4 consecutive 8×8 blocks horizontally (8×32 elements)
      for (size_t group_col = 0; group_col < 2; group_col++) {        // 2 columns of groups
        for (size_t group_row = 0; group_row < 8; group_row++) {      // 8 rows of groups
          
          // Within each 1×4 group, we have 4 consecutive 8×8 blocks horizontally
          // Process all elements in column-major order within the group
          for (size_t j = 0; j < 32; j++) {  // columns within the 8×32 group (32 columns total)
            for (size_t i = 0; i < 8; i++) {   // rows within the 8×32 group (8 rows total)
              
              // Determine which 8×8 block within the 1×4 group we're in
              size_t block_in_group = j / 8;  // 0, 1, 2, or 3
              size_t j_in_block = j % 8;      // column within the 8×8 block
              
              // Calculate which 8×8 sub-block we're in within the 64×64 block
              size_t sub_block_row = group_row;
              size_t sub_block_col = group_col * 4 + block_in_group;
              
              // Calculate source position (row-major input)
              size_t src_row = big_block_row * 64 + sub_block_row * 8 + i;
              size_t src_col = big_block_col * 64 + sub_block_col * 8 + j_in_block;
              size_t src_index = src_row * width + src_col;
              
              // Calculate destination position
              size_t big_block_index = big_block_col * big_blocks_rows + big_block_row;
              size_t group_index = group_col * 8 + group_row;  // 16 groups per 64×64 block (8×2)
              size_t within_group_index = j * 8 + i;           // column-major within the 8×32 group
              size_t dst_index = big_block_index * (64 * 64) + group_index * (8 * 32) + within_group_index;
              
              output[dst_index] = input[src_index];
            }
          }
        }
      }
    }
  }
  
  return output;
}

// Transform B matrix from row-major to column-major 64x64 blocks with 2x2 groups of 16x16 sub-blocks
// Input: row-major matrix of size height x width
// Output: matrix arranged in column-major 64x64 blocks, with 2x2 groups (16x16 elements each), in 4x4 arrangement
inline std::vector<float> transform_B_2x2(const std::vector<float>& input, size_t height, size_t width) {
  assert(height % 64 == 0 && "Height must be divisible by 64");
  assert(width % 64 == 0 && "Width must be divisible by 64");
  assert(input.size() == height * width && "Input size must match height * width");
  
  std::vector<float> output(height * width);
  
  size_t big_blocks_rows = height / 64;    // Number of 64x64 blocks vertically
  size_t big_blocks_cols = width / 64;     // Number of 64x64 blocks horizontally
  
  // Iterate through 64x64 blocks in column-major order
  for (size_t big_block_col = 0; big_block_col < big_blocks_cols; big_block_col++) {
    for (size_t big_block_row = 0; big_block_row < big_blocks_rows; big_block_row++) {
      
      // Within each 64x64 block, we have a 4×4 arrangement of 2×2 groups
      // Each 2×2 group contains 4 16×16 blocks (2×2 arrangement of 16×16 elements = 32×32 elements)
      for (size_t group_col = 0; group_col < 4; group_col++) {        // 4 columns of groups
        for (size_t group_row = 0; group_row < 4; group_row++) {      // 4 rows of groups
          
          // Within each 2×2 group, we have 4 16×16 blocks in 2×2 arrangement
          // Process all elements in column-major order within the group
          for (size_t j = 0; j < 32; j++) {  // columns within the 32×32 group (32 columns total)
            for (size_t i = 0; i < 32; i++) {   // rows within the 32×32 group (32 rows total)
              
              // Determine which 16×16 block within the 2×2 group we're in
              size_t block_row_in_group = i / 16;  // 0 or 1
              size_t block_col_in_group = j / 16;  // 0 or 1
              size_t i_in_block = i % 16;          // row within the 16×16 block
              size_t j_in_block = j % 16;          // column within the 16×16 block
              
              // Calculate which 16×16 sub-block we're in within the 64×64 block
              size_t sub_block_row = group_row * 2 + block_row_in_group;
              size_t sub_block_col = group_col * 2 + block_col_in_group;
              
              // Calculate source position (row-major input)
              size_t src_row = big_block_row * 64 + sub_block_row * 16 + i_in_block;
              size_t src_col = big_block_col * 64 + sub_block_col * 16 + j_in_block;
              size_t src_index = src_row * width + src_col;
              
              // Calculate destination position
              size_t big_block_index = big_block_col * big_blocks_rows + big_block_row;
              size_t group_index = group_col * 4 + group_row;  // 16 groups per 64×64 block (4×4)
              size_t within_group_index = j * 32 + i;          // column-major within the 32×32 group
              size_t dst_index = big_block_index * (64 * 64) + group_index * (32 * 32) + within_group_index;
              
              output[dst_index] = input[src_index];
            }
          }
        }
      }
    }
  }
  
  return output;
}

// Transform A matrix from row-major to column-major 64x64 blocks with 2x2 groups of 16x16 sub-blocks
// Input: row-major matrix of size height x width
// Output: matrix arranged in column-major 64x64 blocks, with 2x2 groups (16x16 elements each), in 4x4 arrangement
inline std::vector<float> transform_A_2x2(const std::vector<float>& input, size_t height, size_t width) {
  assert(height % 64 == 0 && "Height must be divisible by 64");
  assert(width % 64 == 0 && "Width must be divisible by 64");
  assert(input.size() == height * width && "Input size must match height * width");
  
  std::vector<float> output(height * width);
  
  size_t big_blocks_rows = height / 64;    // Number of 64x64 blocks vertically
  size_t big_blocks_cols = width / 64;     // Number of 64x64 blocks horizontally
  
  // Iterate through 64x64 blocks in row-major order (different from B matrix)
  for (size_t big_block_row = 0; big_block_row < big_blocks_rows; big_block_row++) {
    for (size_t big_block_col = 0; big_block_col < big_blocks_cols; big_block_col++) {
      
      // Within each 64x64 block, we have a 4×4 arrangement of 2×2 groups
      // Each 2×2 group contains 4 16×16 blocks (2×2 arrangement of 16×16 elements = 32×32 elements)
      for (size_t group_row = 0; group_row < 4; group_row++) {      // 4 rows of groups
        for (size_t group_col = 0; group_col < 4; group_col++) {    // 4 columns of groups
          
          // Within each 2×2 group, we have 4 16×16 blocks in 2×2 arrangement
          // Process all elements in row-major order within the group (different from B matrix)
          for (size_t i = 0; i < 32; i++) {   // rows within the 32×32 group (32 rows total)
            for (size_t j = 0; j < 32; j++) { // columns within the 32×32 group (32 columns total)
              
              // Determine which 16×16 block within the 2×2 group we're in
              size_t block_row_in_group = i / 16;  // 0 or 1
              size_t block_col_in_group = j / 16;  // 0 or 1
              size_t i_in_block = i % 16;          // row within the 16×16 block
              size_t j_in_block = j % 16;          // column within the 16×16 block
              
              // Calculate which 16×16 sub-block we're in within the 64×64 block
              size_t sub_block_row = group_row * 2 + block_row_in_group;
              size_t sub_block_col = group_col * 2 + block_col_in_group;
              
              // Calculate source position (row-major input)
              size_t src_row = big_block_row * 64 + sub_block_row * 16 + i_in_block;
              size_t src_col = big_block_col * 64 + sub_block_col * 16 + j_in_block;
              size_t src_index = src_row * width + src_col;
              
              // Calculate destination position
              size_t big_block_index = big_block_row * big_blocks_cols + big_block_col;
              size_t group_index = group_row * 4 + group_col;  // 16 groups per 64×64 block (4×4)
              size_t within_group_index = i * 32 + j;          // row-major within the 32×32 group
              size_t dst_index = big_block_index * (64 * 64) + group_index * (32 * 32) + within_group_index;
              
              output[dst_index] = input[src_index];
            }
          }
        }
      }
    }
  }
  
  return output;
}
