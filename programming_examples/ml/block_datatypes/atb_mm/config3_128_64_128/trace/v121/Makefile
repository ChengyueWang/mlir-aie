##===- Makefile -----------------------------------------------------------===##
# 
# This file licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# Copyright (C) 2025, Advanced Micro Devices, Inc.
# 
##===----------------------------------------------------------------------===##

srcdir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
subdir=${srcdir}
targetname=n32_core
devicename=npu2
kernelsrc:=mm_bfp_mixed.cc
hostsrc := $(firstword $(wildcard ${srcdir}/mixed_test.cpp))

# M, K, N: final GEMM dimensions
M?=1024
K?=128
N?=2048

# m, k, n: single AIE core GEMM dimensions
m?=128
k?=64
n?=128
# m?=64
# k?=64
# n?=64
##===- official/mlir-aie/programming_examples/makefile-common ----------------------------------------------------===##

AIETOOLS_DIR ?= $(shell realpath $(dir $(shell which xchesscc))/../)
AIE_INCLUDE_DIR ?= ${AIETOOLS_DIR}/data/versal_prod/lib
AIE2_INCLUDE_DIR ?= ${AIETOOLS_DIR}/data/aie_ml/lib

AIEOPT_DIR ?= $(shell realpath $(dir $(shell which aie-opt))/..)

WARNING_FLAGS = -Wno-parentheses -Wno-attributes -Wno-macro-redefined -Wno-empty-body -Wno-missing-template-arg-list-after-template-kw

CHESSCC1_FLAGS = -f -p me -P ${AIE_INCLUDE_DIR} -I ${AIETOOLS_DIR}/include
CHESSCC2_FLAGS = -f -p me -P ${AIE2_INCLUDE_DIR} -I ${AIETOOLS_DIR}/include
CHESS_FLAGS = -P ${AIE_INCLUDE_DIR}

CHESSCCWRAP1_FLAGS = aie -I ${AIETOOLS_DIR}/include 
CHESSCCWRAP2_FLAGS = aie2 -I ${AIETOOLS_DIR}/include
CHESSCCWRAP2P_FLAGS = aie2p -I ${AIETOOLS_DIR}/include 
PEANOWRAP2_FLAGS = -O2 -std=c++20 --target=aie2-none-unknown-elf ${WARNING_FLAGS} -DNDEBUG -I ${AIEOPT_DIR}/include 
PEANOWRAP2P_FLAGS = -O2 -std=c++20 --target=aie2p-none-unknown-elf ${WARNING_FLAGS} -DNDEBUG -I ${AIEOPT_DIR}/include 

TEST_POWERSHELL := $(shell command -v powershell.exe >/dev/null 2>&1 && echo yes || echo no)
ifeq ($(TEST_POWERSHELL),yes)
	powershell = powershell.exe
	getwslpath = wslpath -w
else
	powershell = 
	getwslpath = echo
endif

##===- official/mlir-aie/programming_examples/ml/block_datatypes/matrix_multiplication/makefile_common  ----------------------------------------------------===##


matrix_multiplication_dir := ${srcdir}
kernel_dir := ${srcdir}

kernels=mm_${m}x${k}x${n}
aieargs+=-m $m -k $k -n $n
target_suffix=${M}x${K}x${N}_${m}x${k}x${n}

target_suffix?=${M}x${K}x${N}
mlir_target?=build/aie_${target_suffix}.mlir
xclbin_target?=build/final_${target_suffix}.xclbin
insts_target?=build/insts_${target_suffix}.txt
aie_py_src?=${targetname}.py

runargs?=-v 2 --warmup 1 --iters 1
aieargs+=-M $M -K $K -N $N

use_chess?=0

opt_perf?=0

ifneq (${use_chess}, 1)
aiecc_peano_flags=--no-xchesscc --no-xbridge --peano ${PEANO_INSTALL_DIR}
endif

# KERNEL_CC defines the C compiler used to compile the kernel.
# KERNEL_CFLAGS holds the flags passed to that compiler.
# By default, we use Peano, a.k.a. llvm-aie.
KERNEL_CC=${PEANO_INSTALL_DIR}/bin/clang++
KERNEL_CFLAGS=${PEANOWRAP2P_FLAGS}

ifeq (${use_chess}, 1)
KERNEL_CC=xchesscc_wrapper
KERNEL_CFLAGS=${CHESSCCWRAP2P_FLAGS}
endif

KERNEL_DEFINES=-DDIM_M=${m} -DDIM_K=${k} -DDIM_N=${n}

ifeq (${opt_perf}, 1)
	KERNEL_DEFINES+=-DOPT_PERF_ENABLED
endif

ifeq (${use_placed}, 1)
aie_py_src=${targetname}_placed.py
endif

# ##########################################################################
# Targets
# ##########################################################################

.PHONY: all
all: ${xclbin_target} ${targetname}.exe

build/mm_${m}x${k}x${n}.o: ${kernel_dir}/${kernelsrc}
	mkdir -p ${@D}
	cd ${@D} && ${KERNEL_CC} ${KERNEL_CFLAGS} ${KERNEL_DEFINES} -c $< -o ${@F}

${mlir_target}: ${srcdir}/${aie_py_src}
	mkdir -p ${@D}
	python3 $< ${aieargs} > $@

${xclbin_target}: ${mlir_target} ${kernels:%=build/%.o}
# ${xclbin_target}: mlir/aie_512x512x512_64x64x64.mlir ${kernels:%=build/%.o}
	mkdir -p ${@D}
	cd ${@D} && aiecc.py --alloc-scheme=basic-sequential --aie-generate-xclbin --no-compile-host --xclbin-name=${@F} \
				${aiecc_peano_flags} --dynamic-objFifos \
				--aie-generate-npu-insts --npu-insts-name=${insts_target:build/%=%} $(<:%=../%)

${targetname}.exe: ${hostsrc} ${matrix_multiplication_dir}/common.h ${srcdir}/helper.h
	rm -rf _build
	mkdir -p _build
	cd _build && ${powershell} cmake -E env CXXFLAGS="-std=c++23 -ggdb -DDTYPE_IN=${dtype_in_cpp} -DDTYPE_OUT=${dtype_out_cpp} -DDTYPE_ACC=${dtype_acc_cpp}" \
		cmake `${getwslpath} ${srcdir}` -D CMAKE_C_COMPILER=gcc-13 -D CMAKE_CXX_COMPILER=g++-13 -DTARGET_NAME=${targetname} -DHOST_SRC=${hostsrc} -DMATMUL_DIR=${matrix_multiplication_dir}
	cd _build && ${powershell} cmake --build . --config Release
ifeq "${powershell}" "powershell.exe"
	cp _build/${targetname}.exe $@
else
	cp _build/${targetname} $@ 
endif

run: ${targetname}.exe ${xclbin_target}
	export XRT_HACK_UNSECURE_LOADING_XCLBIN=1 && \
	${powershell} ./$< -x ${xclbin_target} -i ${insts_target} -k MLIR_AIE -M $M -K $K -N $N -w $m -y $k -z $n ${runargs}


.PHONY: trace
trace: 
# 	${srcdir}/utils/parse_trace.py --input trace.txt --mlir ${mlir_target} --output trace_mm.json
	@mkdir -p trace
	@next_version=$$(ls -1d trace/v* 2>/dev/null | sed 's/trace\/v//' | sort -n | tail -1); \
	if [ -z "$$next_version" ]; then next_version=0; fi; \
	next_version=$$((next_version + 1)); \
	version_dir="trace/v$$next_version"; \
	mkdir -p "$$version_dir"; \
	if [ -f trace_mm.json ]; then cp trace_mm.json "$$version_dir/"; fi; \
	if [ -f n32_core_placed.py ]; then cp n32_core_placed.py "$$version_dir/"; fi; \
	if [ -f Makefile ]; then cp Makefile "$$version_dir/"; fi; \
	if [ -f mixed_test.cpp ]; then cp mixed_test.cpp "$$version_dir/"; fi; \
	if [ -f mm_bfp_mixed.cc ]; then cp mm_bfp_mixed.cc "$$version_dir/"; fi; \
	if [ -f bitcode_cleaned.lst ]; then cp bitcode_cleaned.lst "$$version_dir/"; fi; \
	echo "Created $$version_dir with trace files"
# 	${srcdir}/utils/get_trace_summary.py --input trace_mm.json 
# ./utils/parse_trace.py --input trace.txt --mlir build/aie_256x256x128_64x64x64.mlir --output trace_mm.json 

.PHONY: clean
clean:
	rm -rf build _build ${targetname}.exe trace.txt trace_mm.json


	