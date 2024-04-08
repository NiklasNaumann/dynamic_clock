.PHONY: all
all:
	vivado -mode batch -source ./vivado/noelvmp_vivado.tcl ./vivado/noelvmp_vivado_run.tcl

gui:
	vivado -mode gui -source ./vivado/noelvmp_vivado.tcl ./vivado/noelvmp_vivado_run.tcl

clean:
	rm -rf $(PROJECT).cache
	rm -rf $(PROJECT).gen
	rm -rf $(PROJECT).hw
	rm -rf $(PROJECT).ip_user_files
	rm -rf $(PROJECT).runs
	rm -rf $(PROJECT).sim
	rm -rf $(PROJECT).srcs
	rm -rf $(PROJECT).xpr
	rm -rf vivado*
	rm -rf .Xil/
	rm -rf noelvmp.edn
	rm -rf noelvmp_stub.vhd
