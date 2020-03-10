# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/msm6/Oled/Oled.cache/wt [current_project]
set_property parent.project_path /home/msm6/Oled/Oled.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_ip /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz.xci
set_property used_in_implementation false [get_files -all /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz.dcp]
set_property is_locked true [get_files /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz.xci]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top clk_wiz -part xc7a35tcpg236-1 -mode out_of_context
rename_ref -prefix_all clk_wiz_
write_checkpoint -noxdef clk_wiz.dcp
catch { report_utilization -file clk_wiz_utilization_synth.rpt -pb clk_wiz_utilization_synth.pb }
if { [catch {
  file copy -force /home/msm6/Oled/Oled.runs/clk_wiz_synth_1/clk_wiz.dcp /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if {[file isdir /home/msm6/Oled/Oled.ip_user_files/ip/clk_wiz]} {
  catch { 
    file copy -force /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz_stub.v /home/msm6/Oled/Oled.ip_user_files/ip/clk_wiz
  }
}

if {[file isdir /home/msm6/Oled/Oled.ip_user_files/ip/clk_wiz]} {
  catch { 
    file copy -force /home/msm6/Oled/Oled.srcs/sources_1/ip/clk_wiz/clk_wiz_stub.vhdl /home/msm6/Oled/Oled.ip_user_files/ip/clk_wiz
  }
}