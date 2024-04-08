# Create project
create_project dyn_clk . -part XC7A100TI-csg324-1L -force
get_property source_mgmt_mode [current_project]
set_property source_mgmt_mode DisplayOnly [current_project]
get_property source_mgmt_mode [current_project]

set_property target_language VHDL [current_project]
set_property  ip_repo_paths  /home/user/vivado/dynamic_clock/ip_repo [current_project]
update_ip_catalog

# Create Block Design
source tcl/dyn_clk_bd.tcl

generate_target all [get_files ./dyn_clk.srcs/sources_1/bd/dyn_clk/dyn_clk.bd]
make_wrapper -files [get_files ./dyn_clk.srcs/sources_1/bd/dyn_clk/dyn_clk.bd] -top
add_files -norecurse ./dyn_clk.gen/sources_1/bd/dyn_clk/hdl/dyn_clk_wrapper.vhd

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# Arty contraints
read_xdc ./Arty-XC7A100TI.xdc
set_property used_in_synthesis true [get_files ./Arty-XC7A100TI.xdc]
set_property used_in_implementation true [get_files ./Arty-XC7A100TI.xdc]

# Voltage constraints
read_xdc ./voltage_config.xdc
set_property used_in_synthesis true [get_files ./voltage_config.xdc]
set_property used_in_implementation true [get_files ./voltage_config.xdc]

# MIG constraints
read_xdc ./mig-XC7A100TI.xdc
set_property used_in_synthesis true [get_files ./mig-XC7A100TI.xdc]
set_property used_in_implementation true [get_files ./mig-XC7A100TI.xdc]

# JTAG constraints
read_xdc ./noelvmp_jtag.xdc
set_property used_in_synthesis true [get_files ./noelvmp_jtag.xdc]
set_property used_in_implementation true [get_files ./noelvmp_jtag.xdc]

# Synthesis
set_property strategy Flow_AreaOptimized_High [get_runs synth_1]

synth_design -rtl -name rtl_1

launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name netlist_1

# HW Design for SDK
write_hwdef -force -file ./dyn_clk.hwdef

source tcl/synth.tcl
# source tcl/impl.tcl