#!/bin/bash -f
xv_path="/software/xilinx-2015/Vivado/2015.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 76685b99b608465983ffcdaf3f75c9de -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot DecimalDigitDecoder_tb_behav xil_defaultlib.DecimalDigitDecoder_tb xil_defaultlib.glbl -log elaborate.log
