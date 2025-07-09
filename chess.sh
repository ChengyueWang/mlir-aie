#!/bin/bash
#################################################################################
# Setup Vitis (which includes aiecompiler and xchessde)
#################################################################################
export MYXILINX_VER=2024.2
export MYXILINX_BASE=/proj/xbuilds/${MYXILINX_VER}_INT_daily_latest
export XILINX_LOC=$MYXILINX_BASE/installs/lin64/Vitis/$MYXILINX_VER
export AIETOOLS_ROOT=$XILINX_LOC/aietools
export PATH=$PATH:${AIETOOLS_ROOT}/bin:$XILINX_LOC/bin
export LM_LICENSE_FILE=2100@aiengine
export VITIS=${XILINX_LOC}
export XILINX_VITIS=${XILINX_LOC}
export VITIS_ROOT=${XILINX_LOC}