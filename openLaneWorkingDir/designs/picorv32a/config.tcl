
# Design
set ::env(DESIGN_NAME) "picorv32a"

set ::env(VERILOG_FILES) "./designs/picorv32a/src/picorv32a.v"
set ::env(SDC_FILE) "./designs/picorv32a/src/picorv32a.sdc"

set ::env(CLOCK_PERIOD) "40.000"
set ::env(CLOCK_PORT) "clk"
#overriding PL_TARGET_DENSITY to .45
set ::env(PL_TARGET_DENSITY) 0.45
set ::env(FP_CORE_UTIL) 45

set ::env(CLOCK_NET) $::env(CLOCK_PORT)




set filename $::env(OPENLANE_ROOT)/designs/$::env(DESIGN_NAME)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}
