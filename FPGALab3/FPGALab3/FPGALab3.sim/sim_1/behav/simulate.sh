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
ExecStep $xv_path/bin/xsim wallace_tb_behav -key {Behavioral:sim_1:Functional:wallace_tb} -tclbatch wallace_tb.tcl -log simulate.log
