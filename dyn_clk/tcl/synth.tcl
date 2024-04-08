reset_run synth_1
synth_design -directive runtimeoptimized -resource_sharing off -keep_equivalent_registers -no_lc -rtl -name rtl_1
set_property flow {Vivado Synthesis 2012} [get_runs synth_1]
set_property strategy {Vivado Synthesis Defaults} [get_runs synth_1]
launch_runs synth_1
wait_on_run -timeout 360 synth_1