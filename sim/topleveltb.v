`include "timescale.v"
`ifdef OMSP_NO_INCLUDE
`else
`include "openMSP430_defines.v"
`endif

module  topleveltb;

   //
   // Wire & Register definition
   //------------------------------
   
   // Data Memory interface
   wire [`DMEM_MSB:0] dmem_addr;
   wire               dmem_cen;
   wire [15:0] 	      dmem_din;
   wire [1:0] 	      dmem_wen;
   wire [15:0] 	      dmem_dout;
   
   // Program Memory interface
   wire [`PMEM_MSB:0] pmem_addr;
   wire               pmem_cen;
   wire [15:0] 	      pmem_din;
   wire [1:0] 	      pmem_wen;
   wire [15:0] 	      pmem_dout;
   
   // Digital I/O
   wire [7:0] 	      p1_dout;
   wire [7:0] 	      p1_dout_en;
   reg [7:0] 	      p1_din;
   
   // Clock / Reset & Interrupts
   reg                dco_clk;
   wire               mclk;
   reg                reset_n;
   wire               puc_rst;

   // Core testbench debuging signals
   wire [8*32-1:0]    i_state;
   wire [8*32-1:0]    e_state;
   wire [31:0] 	      inst_cycle;
   wire [8*32-1:0]    inst_full;
   wire [31:0] 	      inst_number;
   wire [15:0] 	      inst_pc;
   wire [8*32-1:0]    inst_short;
   
   // Testbench variables
   integer            tb_idx;
   integer            tmp_seed;
   integer            error;
   reg                stimulus_done;
   
   // user uart signals
   wire 	      user_uart_rx;
   wire 	      user_uart_tx;
   
   
   //
   // Include files
   //------------------------------
   
`ifndef GATELEVEL
   
   // CPU & Memory registers
 `include "registers.v"
   
   
`endif
   
   //
   // Initialize Memory
   //------------------------------
   initial
     begin
	// Initialize data memory
	for (tb_idx=0; tb_idx < `DMEM_SIZE/2; tb_idx=tb_idx+1)
	  dmem_0.mem[tb_idx] = 16'h0000;
	
	// Initialize program memory
	#10 $readmemh("./pmem.mem", pmem_0.mem);
     end
   
   
   //
   // Generate Clock & Reset
   //------------------------------
   initial
     begin
	dco_clk          = 1'b0;
	forever
	  begin
             #25;   // 20 MHz
             dco_clk = ~dco_clk;
	  end
     end
   
   initial
     begin
	reset_n       = 1'b1;
	#93;
	reset_n       = 1'b0;
	#593;
	reset_n       = 1'b1;
     end
   
   initial
     begin
	tmp_seed                = `SEED;
	tmp_seed                = $urandom(tmp_seed);
	error                   = 0;
	stimulus_done           = 1;
	p1_din                  = 8'h00;
     end

   
   // monitor user uart
   assign user_uart_rx = 1'b1;

`define USER_UART_BAUD 10000000
`define DCO_FREQ  20000000
`define USER_UART_CNT ((`DCO_FREQ/`USER_UART_BAUD)-1)

`define USER_UART_PERIOD (1000000000/`USER_UART_BAUD)
   
   reg [7:0] user_uart_buf;
   reg       user_uart_rx_busy;
   
   task task_user_uart_rx;
      reg [7:0]    rxbuf;
      integer 	   rxcnt;
      begin
	 #(1);
	 user_uart_rx_busy = 1'b1;
	 @(negedge user_uart_tx);  
	 rxbuf = 0;      
	 #(3*`USER_UART_PERIOD/2);
	 for (rxcnt = 0; rxcnt < 8; rxcnt = rxcnt + 1)
	   begin
	      rxbuf = {user_uart_tx, rxbuf[7:1]};
	      #(`USER_UART_PERIOD);
	   end
	 user_uart_buf = rxbuf;	 
	 user_uart_rx_busy = 1'b0;
      end
   endtask

   initial
     begin
	repeat(20) @(posedge mclk);	
	forever
	  begin
	     task_user_uart_rx;
	     $display("UART: %c", user_uart_buf);
	  end
     end
   
   //
   // Program Memory
   //----------------------------------
   
   ram #(`PMEM_MSB, `PMEM_SIZE) pmem_0 (
					
					// OUTPUTs
					.ram_dout          (pmem_dout),            // Program Memory data output
					
					// INPUTs
					.ram_addr          (pmem_addr),            // Program Memory address
					.ram_cen           (pmem_cen),             // Program Memory chip enable (low active)
					.ram_clk           (mclk),                 // Program Memory clock
					.ram_din           (pmem_din),             // Program Memory data input
					.ram_wen           (pmem_wen)              // Program Memory write enable (low active)
					);
   
   
   //
   // Data Memory
   //----------------------------------
   
   ram #(`DMEM_MSB, `DMEM_SIZE) dmem_0 (
					
					// OUTPUTs
					.ram_dout          (dmem_dout),            // Data Memory data output
					
					// INPUTs
					.ram_addr          (dmem_addr),            // Data Memory address
					.ram_cen           (dmem_cen),             // Data Memory chip enable (low active)
					.ram_clk           (mclk),                 // Data Memory clock
					.ram_din           (dmem_din),             // Data Memory data input
					.ram_wen           (dmem_wen)              // Data Memory write enable (low active)
					);
   
   
   //
   // openMSP430 Instance
   //----------------------------------
   
   toplevel dut (
		 .clk_sys(dco_clk),
		 .reset_n(reset_n),
		 .p1_din(p1_din),
		 .p1_dout_en(p1_dout_en),
		 .p1_dout(p1_dout),
		 .user_uart_rx(user_uart_rx),
		 .user_uart_tx(user_uart_tx),
		 .dmem_addr(dmem_addr),
		 .dmem_cen(dmem_cen),
		 .dmem_din(dmem_din),
		 .dmem_wen(dmem_wen),
		 .dmem_dout(dmem_dout),
		 .pmem_addr(pmem_addr),
		 .pmem_cen(pmem_cen),
		 .pmem_din(pmem_din),
		 .pmem_wen(pmem_wen),
		 .pmem_dout(pmem_dout),
		 .mclk(mclk),
		 .puc_rst(puc_rst)
		 );
   

   
`ifndef GATELEVEL
   
   //
   // Debug utility signals
   //----------------------------------------
   msp_debug msp_debug_0 (
			  
			  // OUTPUTs
			  .e_state           (e_state),              // Execution state
			  .i_state           (i_state),              // Instruction fetch state
			  .inst_cycle        (inst_cycle),           // Cycle number within current instruction
			  .inst_full         (inst_full),            // Currently executed instruction (full version)
			  .inst_number       (inst_number),          // Instruction number since last system reset
			  .inst_pc           (inst_pc),              // Instruction Program counter
			  .inst_short        (inst_short),           // Currently executed instruction (short version)
			  
			  // INPUTs
			  .mclk              (mclk),                 // Main system clock
			  .puc_rst           (puc_rst)               // Main system reset
			  );
   
`endif // 
   
   //
   // Generate Waveform
   //----------------------------------------
   initial
     begin
        $dumpfile("topleveltb.vcd");
        $dumpvars(0, topleveltb);
     end
   
   //
   // End of simulation
   //----------------------------------------   
   always @(p1_dout)
     if (p1_dout == 8'hF0)
       begin
	  $display("end of simulation (%d instructions)", inst_number);
	  $finish;
       end	

   // instruction traces -- this is very verbose. Use with caution
   //   always @(inst_number)
   //      $display("%6d %4x %s", inst_number, inst_pc, inst_full);
   
endmodule
