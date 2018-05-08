module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input CLOCK_50; // 50MHz clock.
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY; // True when not pressed, False when pressed
	input [9:0] SW;
	reg [21:0] tBase; // set up the clock divider
	wire [3:0][3:0] out; // set up different output for different counters 
	wire [3:0] reset;
	
	always@(posedge CLOCK_50) tBase <= tBase + 1'b1;
	
	assign HEX2 = 7'b1111111;
   assign HEX3 = 7'b1111111;
   assign HEX4 = 7'b1111111;
   assign HEX5 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX0 = 7'b1111111;
   
	
	// wire withces to other counter as reset 
	assign reset = {SW[9], SW[8], SW[7], SW[6]};
	
	
	// wire the output of counters to LEDR display, 
	// when the switch[6] is triggered, the countDown block 
	// triggered, etc. and the LEDR will be assigned with 
	// different array of output.
	assign LEDR[3:0] = out[0] | out[1] | out[2] | out[3];	
   
	// call different counters, which controlled by different buttons 
	rippleCounter rCount(tBase[21], reset[3], out[0]);
	
	counterDown downcount (tBase[21], reset[2], out[1]);
	
	JohnsonCounter Jcount(tBase[21], reset[1], out[2]);
	
	countDownBlock a1(.clk(tBase[21]), .reset(reset[0]), .out(out[3]));
	
endmodule 
