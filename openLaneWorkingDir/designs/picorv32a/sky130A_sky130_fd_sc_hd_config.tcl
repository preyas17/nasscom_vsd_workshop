# SCL Configs
set ::env(GLB_RT_ADJUSTMENT) 0.1

set ::env(SYNTH_MAX_FANOUT) 6
set ::env(CLOCK_PERIOD) "40"
set ::env(FP_CORE_UTIL) 35
set ::env(PL_TARGET_DENSITY) [ expr ($::env(FP_CORE_UTIL)+5) / 100.0 ]
#overriding PL_TARGET_DENSITY to .45
set ::env(PL_TARGET_DENSITY) 0.45
set ::env(FP_CORE_UTIL) 45

