# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {HDL-1065} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/47872/Desktop/Gauss/system_ability_2018/MIPSfpga_axi4_ddr/CarController/CarController.cache/wt [current_project]
set_property parent.project_path C:/Users/47872/Desktop/Gauss/system_ability_2018/MIPSfpga_axi4_ddr/CarController/CarController.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib C:/Users/47872/Desktop/Gauss/system_ability_2018/MIPSfpga_axi4_ddr/CarController/CarController.srcs/sources_1/imports/system_ability_2018/car.v
synth_design -top mainController -part xc7a100tcsg324-1
write_checkpoint -noxdef mainController.dcp
catch { report_utilization -file mainController_utilization_synth.rpt -pb mainController_utilization_synth.pb }
