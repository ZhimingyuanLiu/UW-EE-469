`timescale 1ns/1ps
module D_FF (q, d, reset, clk);
	output reg q;
	input d, reset, clk;
	
	always_ff @(posedge clk)
	if (reset)
		q <= 0; // On reset, set to 0
	else
		q <= d; // Otherwise out = d

endmodule

module D_FF_h (q, d, unhold, clk);
	output reg q;
	input d, unhold, clk;
	
	always_ff @(posedge clk)
	if (unhold)
		q <= d; // On reset, set to 0
	else
		q <= q; // Otherwise out = d

endmodule

// single 64 bit register
module Register (q,d,clk,we,reset);
input logic clk,we,reset;
input logic [63:0] d;
output logic [63:0] q;

logic [63:0] r_ps;
logic [63:0] r_ns;

		genvar i;
			generate 
			for(i = 0; i < 64; i++) begin: storage
			mux2_1_bit select(r_ns[i],r_ps[i] , d[i], we);
			D_FF dff1(r_ps[i],r_ns[i],reset,clk);
			assign q[i] = r_ps[i];
			end
			endgenerate
endmodule

// The large memeory with 32 counts of 64 bit registers
module Registers (q,d,clk,we,reset);

input logic clk,reset;
input logic [31:0] we;
input logic [63:0] d;
output logic [63:0] q [31:0];

genvar i;			
generate
for(i = 0; i < 31; i++)	begin: quantity
Register reg1(q[i],d,clk,we[i],reset);
end
endgenerate

assign q[31] = 0;
endmodule


		