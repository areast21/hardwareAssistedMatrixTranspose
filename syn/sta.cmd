read_liberty /mnt/volume_nyc1_01/skywater-pdk/libraries/sky130_fd_sc_hd/latest/timing/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog toplevel_gl.v
link_design toplevel
create_clock -name clk -period 50 {clk_sys}
set_input_delay -clock clk 0 {reset_n p1_din user_uart_rx dmem_dout pmem_dout }
set_output_delay -clock clk 0 {p1_dout_en p1_dout user_uart_tx dmem_addr dmem_cen dmem_wen dmem_din pmem_din}
set_output_delay -clock clk 0 {pmem_addr pmem_cen pmem_wen puc_rst}
report_checks
report_power
exit


