# Create project
create_project noelvmp . -part xc7a100ticsg324-1L
set_property target_language VHDL [current_project]

add_files -norecurse ./noelvmp.edn
add_files -norecurse ./noelvmp_stub.vhd

ipx::package_project -root_dir ./../ip_repo/noelvmp -vendor user.org -library user -taxonomy {/Embedded_Processing/Processor /UserIP} -import_files -archive_source_project true
set_property display_name noelvmp [ipx::current_core]
set_property description noelvmp [ipx::current_core]

ipx::infer_bus_interface {ddr3_addr ddr3_ba ddr3_cas_n ddr3_ck_n ddr3_ck_p ddr3_cke ddr3_cs_n ddr3_dm ddr3_dq ddr3_dqs_n ddr3_dqs_p ddr3_odt ddr3_ras_n ddr3_reset_n ddr3_we_n} xilinx.com:interface:ddrx_rtl:1.0 [ipx::current_core]

set_property name DDR3 [ipx::get_bus_interfaces ddr3 -of_objects [ipx::current_core]]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]

ipx::save_core [ipx::current_core]
ipx::check_integrity -quiet -xrt [ipx::current_core]
ipx::archive_core ./../ip_repo/noelvmp/user.org_user_noelvmp_1.0.zip [ipx::current_core]
