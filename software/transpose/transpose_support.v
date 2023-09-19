module transpose_support (
              	  output [15:0] per_dout,  	// data output
		          input         mclk,      		// system clock
		          input  [13:0] per_addr,  		// address bus  
		          input  [15:0] per_din,   		// data input
		          input         per_en,   		// active bus cycle enable
		          input [1:0]   per_we,    		// write control
		          input         puc_rst    		// power-up clear reset 
		         );

   reg [15:0] 		    done_rdy;    			// mapped to 0x110
   reg [15:0] 		    done_rdy_next;     
   reg [15:0] 		    r3;         	 		// mapped to 0x114
   reg [15:0] 		    r3_next;
   reg [15:0] 		    r4;          			// mapped to 0x116
   reg [15:0] 		    r4_next;
   reg [15:0] 		    r5;          			// mapped to 0x118
   reg [15:0] 		    r5_next;
   reg [15:0] 		    r6;          			// mapped to 0x11A
   reg [15:0] 		    r6_next;
   reg [15:0] 		    dmux;
   integer i, j;
   
   always @(posedge mclk or posedge puc_rst)
    begin
       if (puc_rst)
	 begin
	    done_rdy <= 16'b0;
	    r3       <= 16'b0;
	    r4       <= 16'b0;
	    r5       <= 16'b0;
	    r6       <= 16'b0;
	 end else begin
	    done_rdy <= done_rdy_next;
	    r3       <= r3_next;
	    r4       <= r4_next;
	    r5       <= r5_next;
	    r6       <= r6_next;
	 end
    end
    
   always @(posedge mclk)
     begin   
       if(done_rdy == 1'b1)
         begin
	   r3[0]    <= r3[0]; 
	   r3[1]    <= r3[8];
	   r3[2]    <= r4[0];
	   r3[3]    <= r4[8];
	   r3[4]    <= r5[0];
	   r3[5]    <= r5[8];
	   r3[6]    <= r6[0];
	   r3[7]    <= r6[8];
	   r3[8]    <= r3[1];
	   r3[9]    <= r3[9];
	   r3[10]   <= r4[1];
	   r3[11]   <= r4[9];
	   r3[12]   <= r5[1];
	   r3[13]   <= r5[9];
	   r3[14]   <= r6[1];
	   r3[15]   <= r6[9];
	   r4[0]    <= r3[2];
	   r4[1]    <= r3[10];
	   r4[2]    <= r4[2];
	   r4[3]    <= r4[10];
	   r4[4]    <= r5[2];
	   r4[5]    <= r5[10];
	   r4[6]    <= r6[2];
	   r4[7]    <= r6[10];
	   r4[8]    <= r3[3];
	   r4[9]    <= r3[11];
	   r4[10]   <= r4[3];
	   r4[11]   <= r4[11];
	   r4[12]   <= r5[3];
	   r4[13]   <= r5[11];
	   r4[14]   <= r6[3];
	   r4[15]   <= r6[11];
	   r5[0]    <= r3[4]; 
	   r5[1]    <= r3[12];
	   r5[2]    <= r4[4];
	   r5[3]    <= r4[12];
	   r5[4]    <= r5[4];
	   r5[5]    <= r5[12];
	   r5[6]    <= r6[4];
	   r5[7]    <= r6[12];
	   r5[8]    <= r3[5];
	   r5[9]    <= r3[13];
	   r5[10]   <= r4[5];
	   r5[11]   <= r4[13];
	   r5[12]   <= r5[5];
	   r5[13]   <= r5[13];
	   r5[14]   <= r6[5];
	   r5[15]   <= r6[13];
	   r6[0]    <= r3[6]; 
	   r6[1]    <= r3[14];
	   r6[2]    <= r4[6];
	   r6[3]    <= r4[14];
	   r6[4]    <= r5[6];
	   r6[5]    <= r5[14];
	   r6[6]    <= r6[6];
	   r6[7]    <= r6[14];
	   r6[8]    <= r3[7];
	   r6[9]    <= r3[15];
	   r6[10]   <= r4[7];
	   r6[11]   <= r4[15];
	   r6[12]   <= r5[7];
	   r6[13]   <= r5[15];
	   r6[14]   <= r6[7];
	   r6[15]   <= r6[15];
       done_rdy <= 16'h0100;
         end
     end
   
   always @*
     begin	
	done_rdy_next  = done_rdy;
	r3_next   = r3;
	r4_next   = r4;
	r5_next   = r5;
	r6_next   = r6;
	dmux      = 16'h0;	
	if (per_en)
	  begin
	     // write
	     case (per_addr)
	       14'h88 : done_rdy_next   =  ( per_we[0] &  per_we[1] ) ? per_din : done_rdy;
	       14'h8a : r3_next         =  ( per_we[0] &  per_we[1] ) ? per_din : r3;
	       14'h8b : r4_next         =  ( per_we[0] &  per_we[1] ) ? per_din : r4;
	       14'h8c : r5_next         =  ( per_we[0] &  per_we[1] ) ? per_din : r5;
	       14'h8d : r6_next         =  ( per_we[0] &  per_we[1] ) ? per_din : r6;
	     endcase
	     // read
	     case (per_addr)
	       14'h88 : dmux = ( ~per_we[0] & ~per_we[1] ) ? done_rdy : 16'h0;
	       14'h8a : dmux = ( ~per_we[0] & ~per_we[1] ) ? r3       : 16'h0;
	       14'h8b : dmux = ( ~per_we[0] & ~per_we[1] ) ? r4       : 16'h0;
	       14'h8c : dmux = ( ~per_we[0] & ~per_we[1] ) ? r5       : 16'h0;
	       14'h8d : dmux = ( ~per_we[0] & ~per_we[1] ) ? r6       : 16'h0;
	     endcase
	  end
     end
   
   assign per_dout = dmux;

endmodule
