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
ExecStep $xv_path/bin/xsim tutorial_tb_time_impl -key {Post-Implementation:sim_1:Timing:tutorial_tb} -tclbatch tutorial_tb.tcl -log simulate.log
