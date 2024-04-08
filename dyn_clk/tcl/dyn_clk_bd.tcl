# Create Block Design
create_bd_design "dyn_clk"

# Add IPs
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0
create_bd_cell -type ip -vlnv user.org:user:sfl:1.1 sfl_0
create_bd_cell -type ip -vlnv user.org:user:noelvmp:1.0 noelvmp_0

# Configure IPs
set_property CONFIG.USE_DYN_RECONFIG {true} [get_bd_cells clk_wiz_0]
set_property CONFIG.PROTOCOL {2} [get_bd_cells jtag_axi_0]

# Clock input
create_bd_port -dir I -type clk -freq_hz 100000000 CLK100MHZ
connect_bd_net [get_bd_ports CLK100MHZ] [get_bd_pins clk_wiz_0/s_axi_aclk]
connect_bd_net [get_bd_ports CLK100MHZ] [get_bd_pins clk_wiz_0/clk_in1]
connect_bd_net [get_bd_ports CLK100MHZ] [get_bd_pins jtag_axi_0/aclk]

# Reset input
create_bd_port -dir I -type rst resetn
set_property CONFIG.POLARITY ACTIVE_LOW [get_bd_ports resetn]
connect_bd_net [get_bd_ports resetn] [get_bd_pins proc_sys_reset_0/ext_reset_in]
connect_bd_net [get_bd_ports resetn] [get_bd_pins jtag_axi_0/aresetn]
connect_bd_net [get_bd_ports resetn] [get_bd_pins clk_wiz_0/s_axi_aresetn]

# Clocking Wizard
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins noelvmp_0/CLK100MHZ]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins sfl_0/clk]
connect_bd_net [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]

# Processor System Reset
connect_bd_net [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins sfl_0/reset]

# AXI
connect_bd_intf_net [get_bd_intf_pins clk_wiz_0/s_axi_lite] [get_bd_intf_pins jtag_axi_0/M_AXI]
assign_bd_address -target_address_space /jtag_axi_0/Data [get_bd_addr_segs clk_wiz_0/s_axi_lite/Reg] -force

# NOELVMP ports
create_bd_port -dir I eth_col
connect_bd_net [get_bd_pins /noelvmp_0/eth_col] [get_bd_ports eth_col]
create_bd_port -dir I eth_crs
connect_bd_net [get_bd_pins /noelvmp_0/eth_crs] [get_bd_ports eth_crs]
create_bd_port -dir I -type clk -freq_hz 100000000 eth_rx_clk
connect_bd_net [get_bd_pins /noelvmp_0/eth_rx_clk] [get_bd_ports eth_rx_clk]
create_bd_port -dir I eth_rx_dv
connect_bd_net [get_bd_pins /noelvmp_0/eth_rx_dv] [get_bd_ports eth_rx_dv]
create_bd_port -dir I eth_rxerr
connect_bd_net [get_bd_pins /noelvmp_0/eth_rxerr] [get_bd_ports eth_rxerr]
create_bd_port -dir I -type clk -freq_hz 100000000 eth_tx_clk
connect_bd_net [get_bd_pins /noelvmp_0/eth_tx_clk] [get_bd_ports eth_tx_clk]
create_bd_port -dir I uart_txd_in
connect_bd_net [get_bd_pins /noelvmp_0/uart_txd_in] [get_bd_ports uart_txd_in]
create_bd_port -dir I -from 3 -to 0 btn
connect_bd_net [get_bd_pins /noelvmp_0/btn] [get_bd_ports btn]
create_bd_port -dir I -from 3 -to 0 eth_rxd
connect_bd_net [get_bd_pins /noelvmp_0/eth_rxd] [get_bd_ports eth_rxd]
create_bd_port -dir I -from 3 -to 0 sw
connect_bd_net [get_bd_pins /noelvmp_0/sw] [get_bd_ports sw]

create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 ddr3
connect_bd_intf_net [get_bd_intf_pins noelvmp_0/DDR3] [get_bd_intf_ports ddr3]
create_bd_port -dir O eth_mdc
connect_bd_net [get_bd_pins /noelvmp_0/eth_mdc] [get_bd_ports eth_mdc]
create_bd_port -dir IO eth_mdio
connect_bd_net [get_bd_pins /noelvmp_0/eth_mdio] [get_bd_ports eth_mdio]
create_bd_port -dir O -type clk eth_ref_clk
connect_bd_net [get_bd_pins /noelvmp_0/eth_ref_clk] [get_bd_ports eth_ref_clk]
create_bd_port -dir O -type rst eth_rstn
connect_bd_net [get_bd_pins /noelvmp_0/eth_rstn] [get_bd_ports eth_rstn]
create_bd_port -dir O eth_tx_en
connect_bd_net [get_bd_pins /noelvmp_0/eth_tx_en] [get_bd_ports eth_tx_en]
create_bd_port -dir O uart_rxd_out
connect_bd_net [get_bd_pins /noelvmp_0/uart_rxd_out] [get_bd_ports uart_rxd_out]
create_bd_port -dir O -from 3 -to 0 eth_txd
connect_bd_net [get_bd_pins /noelvmp_0/eth_txd] [get_bd_ports eth_txd]
create_bd_port -dir IO -from 7 -to 0 ja
connect_bd_net [get_bd_pins /noelvmp_0/ja] [get_bd_ports ja]
create_bd_port -dir O -from 3 -to 0 led
connect_bd_net [get_bd_pins /sfl_0/led] [get_bd_ports led]

# Validate and regenerate
validate_bd_design
regenerate_bd_layout