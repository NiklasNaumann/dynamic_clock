# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"

  set num_leds [ipgui::add_param $IPINST -name "num_leds"]
  set_property tooltip {How many LEDs should blink in sequence} ${num_leds}
  set std_clk_rate [ipgui::add_param $IPINST -name "std_clk_rate"]
  set_property tooltip {Frequency at which the LEDs should blink blink_rate often per second} ${std_clk_rate}
  set blinks_per_sec [ipgui::add_param $IPINST -name "blinks_per_sec"]
  set_property tooltip {How often the LEDs should blink per second at <Standard Clock Frequency> Hz} ${blinks_per_sec}

}

proc update_PARAM_VALUE.blinks_per_sec { PARAM_VALUE.blinks_per_sec } {
	# Procedure called to update blinks_per_sec when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.blinks_per_sec { PARAM_VALUE.blinks_per_sec } {
	# Procedure called to validate blinks_per_sec
	return true
}

proc update_PARAM_VALUE.num_leds { PARAM_VALUE.num_leds } {
	# Procedure called to update num_leds when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_leds { PARAM_VALUE.num_leds } {
	# Procedure called to validate num_leds
	return true
}

proc update_PARAM_VALUE.std_clk_rate { PARAM_VALUE.std_clk_rate } {
	# Procedure called to update std_clk_rate when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.std_clk_rate { PARAM_VALUE.std_clk_rate } {
	# Procedure called to validate std_clk_rate
	return true
}


proc update_MODELPARAM_VALUE.num_leds { MODELPARAM_VALUE.num_leds PARAM_VALUE.num_leds } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_leds}] ${MODELPARAM_VALUE.num_leds}
}

proc update_MODELPARAM_VALUE.std_clk_rate { MODELPARAM_VALUE.std_clk_rate PARAM_VALUE.std_clk_rate } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.std_clk_rate}] ${MODELPARAM_VALUE.std_clk_rate}
}

proc update_MODELPARAM_VALUE.blinks_per_sec { MODELPARAM_VALUE.blinks_per_sec PARAM_VALUE.blinks_per_sec } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.blinks_per_sec}] ${MODELPARAM_VALUE.blinks_per_sec}
}

