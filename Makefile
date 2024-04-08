.PHONY: noelv ip dyn_clk

all: noelvmp ip dyn_clk

noelv: noelvmp/noelvmp.edn
	cp ./noelvmp/noelvmp.edn ./noelvmp_ip/noelvmp.edn
	cp ./noelvmp/noelvmp_stub.vhd ./noelvmp_ip/noelvmp_stub.vhd

noelvmp/noelvmp.edn:
	make -C noelvmp all

dyn_clk:
	make -C dyn_clk all

ip:
	make -C noelvmp_ip all

clean:
	make -C noelvmp clean
	make -C noelvmp_ip clean
	make -C dyn_clk clean