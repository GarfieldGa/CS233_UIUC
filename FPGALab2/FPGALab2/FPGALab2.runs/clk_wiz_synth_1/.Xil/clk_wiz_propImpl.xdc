set_property SRC_FILE_INFO {cfile:/home/hantaoz3/cs233git/FPGALab2/FPGALab2/FPGALab2.srcs/sources_1/ip/clk_wiz/clk_wiz.xdc rfile:../../../FPGALab2.srcs/sources_1/ip/clk_wiz/clk_wiz.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.1
