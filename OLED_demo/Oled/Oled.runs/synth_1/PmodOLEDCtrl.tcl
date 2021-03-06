# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/hantaoz3/cs233git/OLED_demo/Oled/Oled.cache/wt [current_project]
set_property parent.project_path /home/hantaoz3/cs233git/OLED_demo/Oled/Oled.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files /home/hantaoz3/cs233git/OLED_demo/Oled/src/charLib.coe
add_files -quiet /home/hantaoz3/cs233git/OLED_demo/Oled/Oled.runs/charLib_synth_1/charLib.dcp
set_property used_in_implementation false [get_files /home/hantaoz3/cs233git/OLED_demo/Oled/Oled.runs/charLib_synth_1/charLib.dcp]
add_files -quiet /home/hantaoz3/cs233git/OLED_demo/Oled/Oled.runs/clk_wiz_synth_1/clk_wiz.dcp
set_property used_in_implementation false [get_files /home/hantaoz3/cs233git/OLED_demo/Oled/Oled.runs/clk_wiz_synth_1/clk_wiz.dcp]
read_verilog -library xil_defaultlib {
  /home/hantaoz3/cs233git/OLED_demo/Oled/src/Delay.v
  /home/hantaoz3/cs233git/OLED_demo/Oled/src/SpiCtrl.v
  /home/hantaoz3/cs233git/OLED_demo/Oled/src/OledEX.v
  /home/hantaoz3/cs233git/OLED_demo/Oled/src/OledInit.v
  /home/hantaoz3/cs233git/OLED_demo/Oled/src/PmodOLEDCtrl.v
}
read_xdc /home/hantaoz3/cs233git/OLED_demo/Oled/src/Basys3_Master.xdc
set_property used_in_implementation false [get_files /home/hantaoz3/cs233git/OLED_demo/Oled/src/Basys3_Master.xdc]

synth_design -top PmodOLEDCtrl -part xc7a35tcpg236-1
write_checkpoint -noxdef PmodOLEDCtrl.dcp
catch { report_utilization -file PmodOLEDCtrl_utilization_synth.rpt -pb PmodOLEDCtrl_utilization_synth.pb }
