set_property strategy {Performance_ExplorePostRoutePhysOpt} [get_runs impl_1]
set_property steps.write_bitstream.args.mask_file true [get_runs impl_1]
set_msg_config -suppress -id {Drc 23-20}
launch_runs impl_1 -to_step write_bitstream
wait_on_run -timeout 360 impl_1