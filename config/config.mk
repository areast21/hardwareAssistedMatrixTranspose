export DESIGN_NAME = toplevel
export PLATFORM    = sky130hd

export VERILOG_INCLUDE_DIRS = /OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl

export VERILOG_FILES = /OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_alu.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_and_gate.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_clock_gate.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_clock_module.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_clock_mux.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_dbg.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_dbg_hwbrk.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_dbg_i2c.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_dbg_uart.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_execution_unit.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_frontend.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_mem_backbone.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_multiplier.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_register_file.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_scan_mux.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_sfr.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_sync_cell.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_sync_reset.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_uart.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_wakeup_cell.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/omsp_watchdog.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/openMSP430.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/openMSP430_defines.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/openMSP430_undefines.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/periph/omsp_timerA.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/rtl/periph/omsp_gpio.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/software/mmreg/mmreg.v \
	/OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/software/mmreg/toplevel.v

export SDC_FILE      = /OpenROAD-flow-scripts/flow/mydesign/lab-2-develop/config/constraint.sdc

# These values must be multiples of placement site
export DIE_AREA    =  0    0  500  500
export CORE_AREA   =  10  10  490  490
