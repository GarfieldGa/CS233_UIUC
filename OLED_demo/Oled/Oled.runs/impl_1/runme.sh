#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/software/xilinx-2015/SDK/2015.4/bin:/software/xilinx-2015/Vivado/2015.4/ids_lite/ISE/bin/lin64:/software/xilinx-2015/Vivado/2015.4/bin
else
  PATH=/software/xilinx-2015/SDK/2015.4/bin:/software/xilinx-2015/Vivado/2015.4/ids_lite/ISE/bin/lin64:/software/xilinx-2015/Vivado/2015.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/software/xilinx-2015/Vivado/2015.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/software/xilinx-2015/Vivado/2015.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/hantaoz3/cs233git/OLED_demo/Oled/Oled.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log PmodOLEDCtrl.vdi -applog -m64 -messageDb vivado.pb -mode batch -source PmodOLEDCtrl.tcl -notrace


