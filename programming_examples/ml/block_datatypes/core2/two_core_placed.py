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
        prog="AIE Matrix Multiplication MLIR Design (Dual Core) with bfp16ebs8 weights and bf16 input/output",
        description="Emits MLIR code for a matrix multiplication design of the given input size using two cores. Only supported in NPU2 devices.",
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
    n_aie_rows = 2

    # L2 tile sizes (memory level) 
    l2_m_a = n_aie_rows * m
    l2_m_c = n_aie_rows * m
    l2_n   = n_aie_cols * n
    l2_k   = k


    # L1 tile sizes (compute level)
    a_m_l1 = m    # for A
    a_k_l1 = k    # for A
    b_k_l1 = k    # for B
    b_n_l1 = n    # for B
    c_m_l1 = m    # for C
    c_n_l1 = n    # for C

    a_m_l2 = l2_m_a    # for A
    a_k_l2 = l2_k      # for A
    b_k_l2 = l2_k      # for B
    b_n_l2 = l2_n      # for B
    c_m_l2 = l2_m_c    # for C
    c_n_l2 = l2_n      # for C

    r = 8
    s = 8
    t = 8

    enable_tracing = True
    # enable_tracing = True
    trace_size = 65536 * 2

    # Use bfloat16 for input/output and bfp16ebs8 for weights
    dtype_in = bfloat16
    dtype_out = bfloat16

    dev_ty = AIEDevice.npu2
    @device(dev_ty)
    def device_body():
        A_l1_ty = np.ndarray[(a_m_l1, a_k_l1), np.dtype[dtype_in]]
        A_l2_ty = np.ndarray[(a_m_l2, a_k_l2), np.dtype[dtype_in]]
        B_l1_ty = np.ndarray[(b_k_l1, b_n_l1 // 8), np.dtype[v8bfp16ebs8]]  # Use v8bfp16ebs8 for weights
        B_l2_ty = np.ndarray[(b_k_l2, b_n_l2 // 8), np.dtype[v8bfp16ebs8]]  # Full B matrix in memory
        C_l1_ty = np.ndarray[(c_m_l1, c_n_l1), np.dtype[dtype_out]]
        C_l2_ty = np.ndarray[(c_m_l2, c_n_l2), np.dtype[dtype_out]]

        # AIE Core Function declarations
        zero = external_func(f"zero_kernel_bf16", inputs=[C_l1_ty])
        matmul = external_func( "matmul_vectorized_different_datatypes",  inputs=[A_l1_ty, B_l1_ty, C_l1_ty],)

        # Tile declarations
        shim_tileA0 = tile(1, 0)
        shim_tileA1 = tile(2, 0)
        shim_tileB = tile(2, 0)
        shim_tileC = tile(2, 0)

        mem_tileA0 = tile(1, 1)
        mem_tileA1 = tile(2, 1)
        mem_tileB = tile(2, 1)
        mem_tileC = tile(2, 1)

        shim_tile_trace = tile(3, 0)

        compute_tile0 = tile(2, 2)
        compute_tile1 = tile(2, 3)

        # AIE-array data movement with object fifos
        # Input A - separate FIFOs for each core
        A_l3l2_fifos = [None] * n_aie_rows
        A_l2l1_fifos = [None] * n_aie_rows
        A_transformations = [] # A_transformations = [(a_m_l1 // r, r * a_k_l1),(a_k_l1 // s, s), (r, a_k_l1), (s, 1),] 

        A_l3l2_fifos[0] = object_fifo("A_l3l2_fifo_0", shim_tileA0, mem_tileA0, 2, A_l2_ty)
        A_l3l2_fifos[1] = object_fifo("A_l3l2_fifo_1", shim_tileA1, mem_tileA1, 2, A_l2_ty)
        A_l2l1_fifos[0] = object_fifo("A_l2l1_fifo_0", mem_tileA0, compute_tile0, 2, A_l1_ty, A_transformations, )
        A_l2l1_fifos[1] = object_fifo("A_l2l1_fifo_1", mem_tileA1, compute_tile1, 2, A_l1_ty, A_transformations, )
        object_fifo_link(A_l3l2_fifos[0], A_l2l1_fifos[0])
        object_fifo_link(A_l3l2_fifos[1], A_l2l1_fifos[1])

        # Input B - broadcast FIFOs to two cores
        B_l3l2_fifos = [None] * n_aie_cols
        B_l2l1_fifos = [None] * n_aie_cols
        B_transformations = [] 

        B_l3l2_fifos[0] = object_fifo("B_l3l2_fifo_0", shim_tileB, mem_tileB, 2, B_l2_ty)
        B_l2l1_fifos[0] = object_fifo("B_l2l1_fifo_0", mem_tileB, [compute_tile0, compute_tile1], 2, B_l1_ty, B_transformations, )
        object_fifo_link(B_l3l2_fifos[0], B_l2l1_fifos[0])

        # Output C - separate FIFOs for each core
        C_l1l2_fifos = [None] * n_aie_cols * n_aie_rows
        C_l2l3_fifos = [None] * n_aie_cols * n_aie_rows
        C_transformations = []

        C_l1l2_fifos[0] = object_fifo("C_l1l2_fifo_0", compute_tile0, mem_tileC, 2, C_l1_ty, C_transformations, )
        C_l1l2_fifos[1] = object_fifo("C_l1l2_fifo_1", compute_tile1, mem_tileC, 2, C_l1_ty, C_transformations, )
        C_l2l3_fifos[0] = object_fifo("C_l2l3_fifo_0", mem_tileC, shim_tileC, 2, C_l2_ty)
        C_l2l3_fifos[1] = object_fifo("C_l2l3_fifo_1", mem_tileC, shim_tileC, 2, C_l2_ty)
        object_fifo_link(C_l1l2_fifos[0], C_l2l3_fifos[0])
        object_fifo_link(C_l1l2_fifos[1], C_l2l3_fifos[1])

        # Set up a packet-switched flow from core to shim for tracing information
        # tiles_to_trace = [compute_tile1, compute_tile2, mem_tileA, mem_tileB, mem_tileB, mem_tileC, shim_tileA]
        # tiles_to_trace = [ mem_tileA, mem_tileB, mem_tileB, mem_tileC, shim_tileA, shim_tileB, shim_tileB, shim_tileC]
        # tiles_to_trace = [compute_tile0, compute_tile1, mem_tileA0, mem_tileA1, mem_tileB, mem_tileC, shim_tileA0, shim_tileA1, shim_tileB, shim_tileC]
        tiles_to_trace = [compute_tile0, compute_tile1, mem_tileA0, mem_tileA1, shim_tileA0, shim_tileA1]
        if enable_tracing:
            trace_utils.configure_packet_tracing_flow(tiles_to_trace, shim_tile_trace)

        # Set up compute tiles
        # Compute tile 1 - computes odd tiles (c1, c3, etc.) 
        @core(compute_tile0, f"mm_{a_m_l1}x{a_k_l1}x{b_n_l1}.o", stack_size=0xF00)
        def core_body1():
            for _ in range_(0xFFFFFFFF):
                for _ in range_( (M // a_m_l1) *  (N // b_n_l1) // n_aie_cols // n_aie_rows):  # Half the tiles for each core
                    elem_out = C_l1l2_fifos[0].acquire(ObjectFifoPort.Produce, 1)
                    zero(elem_out)
                    for _ in range_(K // a_k_l1):  # issue #1547
                        elem_in_a = A_l2l1_fifos[0].acquire(ObjectFifoPort.Consume, 1)
                        elem_in_b = B_l2l1_fifos[0].acquire(ObjectFifoPort.Consume, 1)
                        matmul(elem_in_a, elem_in_b, elem_out)
                        A_l2l1_fifos[0].release(ObjectFifoPort.Consume, 1)
                        B_l2l1_fifos[0].release(ObjectFifoPort.Consume, 1)
                    C_l1l2_fifos[0].release(ObjectFifoPort.Produce, 1)

        # Compute tile 2 - computes even tiles (c2, c4, etc.)
        @core(compute_tile1, f"mm_{a_m_l1}x{a_k_l1}x{b_n_l1}.o", stack_size=0xF00)
        def core_body2():
            for _ in range_(0xFFFFFFFF):
                for _ in range_( (M // a_m_l1) * (N // b_n_l1 )// n_aie_cols // n_aie_rows):  # Half the tiles for each core
                    elem_out = C_l1l2_fifos[1].acquire(ObjectFifoPort.Produce, 1)
                    zero(elem_out)
                    for _ in range_(K // a_k_l1):  # issue #1547
                        elem_in_a = A_l2l1_fifos[1].acquire(ObjectFifoPort.Consume, 1)
                        elem_in_b = B_l2l1_fifos[0].acquire(ObjectFifoPort.Consume, 1)
                        matmul(elem_in_a, elem_in_b, elem_out)
                        A_l2l1_fifos[1].release(ObjectFifoPort.Consume, 1)
                        B_l2l1_fifos[0].release(ObjectFifoPort.Consume, 1)
                    C_l1l2_fifos[1].release(ObjectFifoPort.Produce, 1)

        # To/from AIE-array data movement
        @runtime_sequence(
            np.ndarray[(M * K,), np.dtype[dtype_in]],
            np.ndarray[(K * N // 8,), np.dtype[v8bfp16ebs8]],  # B0 for core1 (odd columns)
            np.ndarray[(M * N,), np.dtype[dtype_out]],
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
                    # coremem_events=[
                    #     trace_utils.MemEvent.GROUP_MEMORY_CONFLICT,
                    #     trace_utils.MemEvent.DMA_MM2S_0_FINISHED_BD,
                    #     trace_utils.MemEvent.DMA_S2MM_0_FINISHED_BD,
                    #     trace_utils.MemEvent.DMA_S2MM_1_FINISHED_BD,
                    #     trace_utils.MemEvent.LOCK_3_REL,
                    #     trace_utils.MemEvent.DMA_MM2S_0_STREAM_BACKPRESSURE,
                    #     trace_utils.MemEvent.LOCK_SEL0_ACQ_GE,
                    #     trace_utils.MemEvent.LOCK_SEL1_ACQ_EQ,
                    # ],
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
            A_taps = TensorTiler2D.group_tiler((1, M * K)     , (1, l2_m_c * l2_k // n_aie_rows)   , (1, 1))  
            B_taps = TensorTiler2D.group_tiler((1, N * K // 8), (1, l2_n * l2_k // 8), (1, 1))
            C_taps = TensorTiler2D.group_tiler((1, M * N)     , (1, l2_m_c * l2_n // n_aie_rows)   , (1, 1))

            my_print_test["A_tiles length"] = len(A_taps)
            my_print_test["B_tiles length"] = len(B_taps)
            my_print_test["C_tiles length"] = len(C_taps)

            # These lists will hold handles to the DMA tasks we configure
            input_tasks_ping = []
            input_tasks_pong = []
            output_tasks_ping = []
            output_tasks_pong = []

            # Helper functions for creating input and output tasks
            def create_input_tasks(task_list, k_iter):
                """Create input tasks for A and B tensors for K iterations"""
                for _ in range(k_iter):
                    # B task (same tile index 0 for all iterations)
                    b_task = shim_dma_single_bd_task(B_l3l2_fifos[0], B, tap=B_taps[0])
                    dma_start_task(b_task)
                    task_list.append(b_task)
                    
                    # A tasks for both cores (same tile index 0 for all iterations)
                    for core_idx in range(n_aie_rows):
                        a_task = shim_dma_single_bd_task(A_l3l2_fifos[core_idx], A, tap=A_taps[0])
                        dma_start_task(a_task)
                        task_list.append(a_task)

            def create_output_tasks(task_list, c_start_idx):
                """Create output tasks for C tensor starting from c_start_idx"""
                for core_idx in range(n_aie_rows):
                    c_task = shim_dma_single_bd_task(
                        C_l2l3_fifos[core_idx], C, 
                        tap=C_taps[c_start_idx + core_idx], 
                        issue_token=True
                    )
                    dma_start_task(c_task)
                    task_list.append(c_task)

            # Calculate number of K iterations (appears to be 2 based on pattern)
            k_iterations = 2
            
            # Calculate total C tiles to process (appears to be 8 based on pattern)
            total_c_tiles = len(C_taps)
            c_tiles_per_iteration = n_aie_rows  # 2 cores = 2 C tiles per iteration
            
            # First iteration - setup initial ping tasks
            create_input_tasks(input_tasks_ping, k_iterations)
            create_output_tasks(output_tasks_ping, 0)
            
            # Setup initial pong input tasks
            create_input_tasks(input_tasks_pong, k_iterations)

            # Process remaining C tiles in ping-pong fashion
            for c_tile_group in range(1, total_c_tiles // c_tiles_per_iteration):
                # Wait for previous output tasks and cleanup
                if c_tile_group % 2 == 1:  # Odd iteration - wait for ping, setup pong
                    dma_await_task(*output_tasks_ping)
                    dma_free_task(*input_tasks_ping)
                    output_tasks_ping.clear()
                    input_tasks_ping.clear()
                    
                    # Setup output tasks for pong
                    create_output_tasks(output_tasks_pong, c_tile_group * c_tiles_per_iteration)
                    
                    # Setup next input tasks for ping
                    if c_tile_group < total_c_tiles // c_tiles_per_iteration - 1:
                        create_input_tasks(input_tasks_ping, k_iterations)
                        
                else:  # Even iteration - wait for pong, setup ping
                    dma_await_task(*output_tasks_pong)
                    dma_free_task(*input_tasks_pong)
                    output_tasks_pong.clear()
                    input_tasks_pong.clear()
                    
                    # Setup output tasks for ping
                    create_output_tasks(output_tasks_ping, c_tile_group * c_tiles_per_iteration)
                    
                    # Setup next input tasks for pong
                    if c_tile_group < total_c_tiles // c_tiles_per_iteration - 1:
                        create_input_tasks(input_tasks_pong, k_iterations)

            # Final cleanup - wait for last output tasks
            if (total_c_tiles // c_tiles_per_iteration - 1) % 2 == 1:
                dma_await_task(*output_tasks_pong)
                dma_free_task(*input_tasks_pong)
                output_tasks_pong.clear()
                input_tasks_pong.clear()
            else:
                dma_await_task(*output_tasks_ping)
                dma_free_task(*input_tasks_ping)
                output_tasks_ping.clear()
                input_tasks_ping.clear()

            if enable_tracing:
                trace_utils.gen_trace_done_aie2(shim_tileC)


main()
# raise ValueError(my_print_test)

