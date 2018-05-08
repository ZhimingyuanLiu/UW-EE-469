`timescale 1ns/1ps
module movz(shamt,imm16,result,rd_result);
	input logic [1:0] shamt;
	
	input logic [15:0] imm16;
	
	output logic[63:0] result;
	output logic[63:0] rd_result;
	
	logic [63:0] multOutLow;
	logic [63:0] multOutHigh;
	logic [5:0] shiftAmount;
	logic [63:0] Imm64;
	logic [63:0] temp;

	mult one({62'b0,shamt}, 64'b0000000000000000000000000000000000000000000000000000000000010000, 1'b0, multOutLow, multOutHigh); 

	assign shiftAmount = multOutLow[5:0];
	
	assign Imm64 = {48'b0, imm16};

	assign temp = {48'b111111111111111111111111111111111111111111111111,16'b0};
	
	shifter moveIt(Imm64, 1'b0, shiftAmount, result);

	neg_shifter move(temp, 1'b0, shiftAmount, rd_result);
	
endmodule 



module movk(RegRd,datain, result, movz_temp);
input logic [63:0] RegRd;
input logic [63:0] datain, movz_temp;
output logic [63:0] result;

logic [63:0] temp;
generate
genvar i;
for ( i = 0; i<64; i++) begin:logic_loop
assign temp[i] = ((movz_temp[i]&RegRd[i])|datain[i]);
end
endgenerate
assign result = temp;
endmodule

