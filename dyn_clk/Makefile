PROJECT:=dyn_clk
.PHONY: all
all:
	vivado -mode batch -source tcl/run.tcl

gui:
	vivado -mode gui -source tcl/run.tcl

clean:
	rm -rf $(PROJECT).cache
	rm -rf $(PROJECT).gen
	rm -rf $(PROJECT).hw
	rm -rf $(PROJECT).ip_user_files
	rm -rf $(PROJECT).runs
	rm -rf $(PROJECT).sim
	rm -rf $(PROJECT).srcs
	rm -rf $(PROJECT).xpr
	rm -rf $(PROJECT).hwdef
	rm -rf vivado*
	rm -rf .Xil/