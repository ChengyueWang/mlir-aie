#
# This file is licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org     
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#
# (c) Copyright 2025 AMD Inc.
# This placed implementation uses configure_task instructions instead of
# dma_memcpy_nd in the runtime sequence configuration. It is otherwise
# identical.
import argparse
from ml_dtypes import bfloat16
import numpy as np

from aie.extras.context import mlir_mod_ctx
from aie.dialects.aie import *
from aie.dialects.aiex import *
from aie.dialects.aiex import v8bfp16ebs8
import aie.utils.trace as trace_utils
from aie.helpers.taplib import TensorAccessSequence, TensorTiler2D
from aie.helpers.dialects.ext.scf import _for as range_
from aie.iron.dtype import str_to_dtype
from aie.utils.trace_events_enum import CoreEvent, MemEvent, ShimTileEvent, MemTileEvent


my_print_test = {}
my_print_test["test_key"] = []
my_print_test["test_key"].append("test_value")

def ceildiv(a, b):
    return (a + b - 1) // b

def main():
    argparser = argparse.ArgumentParser(
        prog="AIE Matrix Multiplication MLIR Design (Quad Core) with bfp16ebs8 weights and bf16 input/output",
        description="Emits MLIR code for a matrix multiplication design of the given input size using four cores. Only supported in NPU2 devices.",
    )
    argparser.add_argument("-M", type=int, default=0)
    argparser.add_argument("-K", type=int, default=0)
    argparser.add_argument("-N", type=int, default=0)
    argparser.add_argument("-m", type=int, default=0)
    argparser.add_argument("-k", type=int, default=0)
    argparser.add_argument("-n", type=int, default=0)
    args = argparser.parse_args()
    with mlir_mod_ctx() as ctx:
        my_matmul(args.M, args.K, args.N, args.m, args.k, args.n)
        print(ctx.module)

# raise ValueError(my_print_test)


def ceildiv(a, b):
    return (a + b - 1) // b


def my_matmul(M, K, N, m, k, n):

    n_aie_cols = 1
    n_aie_rows = 1

    # L1 tile sizes (compute level)
    a_m_l1 = m    # for A
    a_k_l1 = k    # for A
    b_k_l1 = k    # for B
    b_n_l1 = n    # for B
    c_m_l1 = m    # for C
    c_n_l1 = n    # for C

    a_m_l2 = m    # for A
    a_k_l2 = k      # for A
    b_k_l2 = k      # for B
    b_n_l2 = n      # for B
    c_m_l2 = n_aie_rows * m    # for C
    c_n_l2 = n      # for C

    r = 8
    s = 8
    t = 8

    enable_tracing = True
    # enable_tracing = False
    trace_size = 8192 * 16

    # Use bfloat16 for input/output and bfp16ebs8 for weights
    dtype_in = v8bfp16ebs8
    dtype_out = v8bfp16ebs8

    dev_ty = AIEDevice.npu2
    @device(dev_ty)
    def device_body():
        A_l2_ty = np.ndarray[(m, k // 8), np.dtype[dtype_in]]
        B_l2_ty = np.ndarray[(k, n // 8), np.dtype[v8bfp16ebs8]]  # Full B matrix in memory
        C_l2_ty = np.ndarray[(n_aie_rows * m , n // 8), np.dtype[dtype_out]]

        A_l1_ty = np.ndarray[(m // 8, k // 8), np.dtype[dtype_in]]
        B_l1_ty = np.ndarray[(k, n // 8), np.dtype[v8bfp16ebs8]]  # Use v8bfp16ebs8 for weights
        C_l1_ty = np.ndarray[(m, n // 8), np.dtype[dtype_out]]

        # AIE Core Function declarations
        zero = external_func(f"zero_kernel", inputs=[C_l1_ty])
        matmul = external_func( "matmul_vectorized_bfp16",  inputs=[A_l1_ty, B_l1_ty, C_l1_ty],)

        # Tile declarations as tile[row][col] 
        # using columns 0-7
        tiles = [[tile(col, row) for col in range(0, n_aie_cols)] for row in range(0, n_aie_rows + 2)]
        shim_tiles = tiles[0]
        mem_tiles = tiles[1]
        core_tiles = tiles[2:]

        shim_tile_trace = tile(1, 0)
        tiles_to_trace = [tile(0, 1), tile(0, 2), tile(0, 0)]  # Last compute tile and last mem tile
        if enable_tracing:
            trace_utils.configure_packet_tracing_flow(tiles_to_trace, shim_tile_trace)

        # AIE-array data movement with object fifos
        A_l3l2_fifos = [None] * n_aie_rows
        A_l2l1_fifos = [None] * n_aie_rows

        B_l3l2_fifos = [None] * n_aie_cols
        B_l2l1_fifos = [None] * n_aie_cols

        C_l1l2_fifos = [[None] * n_aie_cols for _ in range(n_aie_rows)]
        C_l2l3_fifos = [None] * n_aie_cols

        # Input A
        for row in range(1):
            A_transformations = [] #[(m // r, r * k),(k // s, s),(r, k),(s, 1),]
            A_l3l2_fifos[row] = object_fifo(
                f"A_L3L2_{row}",
                shim_tiles[row],
                mem_tiles[row],
                2,
                A_l2_ty,
                None,
                )
            
            A_l2l1_fifos[row] = object_fifo(f"A_L2L1_{row}", mem_tiles[2 * row], core_tiles[row][0:8], 2, A_l1_ty, A_transformations,)
            object_fifo_link(A_l3l2_fifos[row], A_l2l1_fifos[row])

        # Input B
        for col in range(1):
            B_transformations = [] # [(n // t, t * k),(k // s, s),(t, k),(s, 1),]
            B_l3l2_fifos[col] = object_fifo(f"B_L3L2_{col}", shim_tiles[col], mem_tiles[col], 2, B_l2_ty,)
            B_l2l1_fifos[col] = object_fifo(f"B_L2L1_{col}", mem_tiles[col], [core_tiles[j][col] for j in range(1)], 2, B_l1_ty, B_transformations,)
            object_fifo_link(B_l3l2_fifos[col], B_l2l1_fifos[col])

        # Output C
        for col in range(n_aie_cols):
            for row in range(n_aie_rows):
                C_l1l2_fifos[row][col] = object_fifo(f"C_L1L2_{col}_{row}", core_tiles[row][col], mem_tiles[col], 1, C_l1_ty,)
            C_transformations = [] #[(m // r, r * n), (r, t), (n // t, r * t), (t, 1)]
            C_l2l3_fifos[col] = object_fifo(f"C_L2L3_{col}", mem_tiles[col], shim_tiles[col], 2, C_l2_ty, C_transformations)
            of_offsets = [m * n // 8 * i for i in range(n_aie_rows)]
            object_fifo_link([C_l1l2_fifos[j][col] for j in range(n_aie_rows)], C_l2l3_fifos[col], of_offsets)  

        # Set up compute tiles
        for row in range(n_aie_rows):
            for col in range(n_aie_cols):
                @core(core_tiles[row][col], f"mm_{m}x{k}x{n}.o", stack_size=0xD00) # 0xF00? 
                def core_body():
                    for _ in range_(0xFFFFFFFF):
                        for _ in range((M // m) * (N // n) // (n_aie_cols * n_aie_rows)):
                            elem_out = C_l1l2_fifos[row][col].acquire(ObjectFifoPort.Produce, 1)
                            zero(elem_out)
                            for _ in range_(K // k):
                                elem_in_b = B_l2l1_fifos[col].acquire(ObjectFifoPort.Consume, 1)
                                for i in range(8):
                                    elem_in_a = A_l2l1_fifos[row].acquire(ObjectFifoPort.Consume, 1)
                                    matmul(elem_in_a, elem_in_b, elem_out)
                                    A_l2l1_fifos[row].release(ObjectFifoPort.Consume, 1)
                                B_l2l1_fifos[col].release(ObjectFifoPort.Consume, 1)
                            C_l1l2_fifos[row][col].release(ObjectFifoPort.Produce, 1)



        # To/from AIE-array data movement
        @runtime_sequence(
            np.ndarray[(M * K // 8,), np.dtype[dtype_in]],
            np.ndarray[(K * N // 8,), np.dtype[v8bfp16ebs8]],  # B0 for core1 (odd columns)
            np.ndarray[(M * N // 8,), np.dtype[dtype_out]],
        )
        def sequence(A, B, C):

            if enable_tracing:
                trace_utils.configure_packet_tracing_aie2(
                    tiles_to_trace,
                    shim_tile_trace,
                    trace_size, 
                    coretile_events=[
                        # captures input A (PORT_RUNNING_0, at port number 1, master for inputs)
                        trace_utils.PortEvent(
                            trace_utils.CoreEvent.PORT_RUNNING_0,
                            port_number=1,
                            master=True,
                        ),
                        # captures input B (PORT_RUNNING_1, at port number 2, master for inputs)
                        trace_utils.PortEvent(
                            trace_utils.CoreEvent.PORT_RUNNING_1,
                            port_number=2,
                            master=True,
                        ),
                        # captures output C (PORT_RUNNING_2, at port number 1, slave for outputs)
                        trace_utils.PortEvent(
                            trace_utils.CoreEvent.PORT_RUNNING_2,
                            port_number=1,
                            master=False,
                        ),
                        trace_utils.CoreEvent.INSTR_EVENT_0,
                        trace_utils.CoreEvent.INSTR_VECTOR,
                        trace_utils.CoreEvent.INSTR_EVENT_1,
                        trace_utils.CoreEvent.MEMORY_STALL,
                        trace_utils.CoreEvent.STREAM_STALL,
                        # trace_utils.CoreEvent.LOCK_STALL,
                    ],
                    memtile_events=[
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_0, 0, True), 
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_1, 1, True),
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_2, 2, True),  
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_3, 3, True),  
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_4, 0, False),  
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_5, 1, False),  
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_6, 2, False),  
                        trace_utils.MemTilePortEvent(MemTileEvent.PORT_RUNNING_7, 3, False),  
                    ],
                    shimtile_events=[
                        trace_utils.ShimTileEvent.DMA_S2MM_0_START_TASK,
                        trace_utils.ShimTileEvent.DMA_S2MM_0_FINISHED_TASK,
                        trace_utils.ShimTileEvent.DMA_S2MM_1_START_TASK,
                        trace_utils.ShimTileEvent.DMA_S2MM_1_FINISHED_TASK,
                        trace_utils.ShimTileEvent.DMA_MM2S_0_START_TASK,
                        trace_utils.ShimTileEvent.DMA_MM2S_0_FINISHED_TASK,
                        trace_utils.ShimTileEvent.DMA_MM2S_1_START_TASK,
                        trace_utils.ShimTileEvent.DMA_MM2S_1_FINISHED_TASK,
                        # trace_utils.ShimTileEvent.DMA_S2MM_0_STREAM_STARVATION,
                    ],
                )

            # This simplified version does not reuse BDs - each task gets its own BD
            # This makes the code much clearer and easier to understand

            # flat input (not correct, buf faster)
            A_taps = TensorTiler2D.group_tiler((1, M * K // 8)     , (1, m * K // 8)   , (1, 1))
            B_taps = TensorTiler2D.group_tiler((1, N * K // 8), (1, n * K // 8 ), (1, 1))
            # C_taps = TensorTiler2D.group_tiler((1, M * N // 8)     , (1, n_aie_rows * m * n // 8 )   , (1, 1))

            # non-flat input (correct, but slower)
            # A_taps = TensorTiler2D.group_tiler((M, K // 8)     , (m, mtk // 8)      , (1, K // mtk))
            # B_taps = TensorTiler2D.group_tiler((N, K // 8)     , (n, k // 8 )       , (1, K // k))
            C_taps = TensorTiler2D.group_tiler((M, N // 8)     , (n_aie_rows * m, n // 8)   , (1, 1))

            my_print_test["A_tiles length"] = len(A_taps)
            my_print_test["B_tiles length"] = len(B_taps)
            my_print_test["C_tiles length"] = len(C_taps)
            
            # Multi-group task lists for managing DMA IDs
            num_groups = 4  # Hardcoded for testing purposes (M*N/(n_aie_cols*n_aie_rows*m*n))
            input_task_groups = [[] for _ in range(num_groups)]
            output_task_groups = [[] for _ in range(num_groups)]
            # Create tasks for 4 groups - manually unrolled

            # Group 0 tasks - uses all 8 B FIFOs
            b_task_0_0 = shim_dma_single_bd_task(B_l3l2_fifos[0], B, tap=B_taps[0], issue_token=False)
            dma_start_task(b_task_0_0)
            input_task_groups[0].append(b_task_0_0)

            a_task_0_0 = shim_dma_single_bd_task(A_l3l2_fifos[0], A, tap=A_taps[0], issue_token=False)
            dma_start_task(a_task_0_0)
            input_task_groups[0].append(a_task_0_0)

            # Group 0 output tasks - uses all 8 C FIFOs
            c_task_0_0 = shim_dma_single_bd_task(C_l2l3_fifos[0], C, tap=C_taps[0], issue_token=True)
            dma_start_task(c_task_0_0)
            output_task_groups[0].append(c_task_0_0)

            # Process 4 groups with proper synchronization - manually unrolled
            dma_await_task(*output_task_groups[0])
            dma_free_task(*input_task_groups[0])

            if enable_tracing:
                trace_utils.gen_trace_done_aie2(shim_tile_trace)


main()
# raise ValueError(my_print_test)


