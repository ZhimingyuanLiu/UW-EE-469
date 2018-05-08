`timescale 1ns/1ps
module inst2reg(instructionIn, instructionOut, clk, reset);
input logic clk, reset;
input logic[31:0] instructionIn; // PC+OPP
output logic [31:0] instructionOut;
//203
genvar i;
			generate 
			for(i = 0; i <32 ; i++) begin: firstStage
			D_FF D_ff1(instructionOut[i],instructionIn[i] , reset, clk);
			end
			endgenerate
endmodule



module reg2alu(instructionIn, instructionOut, clk, reset);
input logic clk, reset;
input logic[189:0] instructionIn; // PC+OPP
output logic[189:0] instructionOut;

genvar i;
			generate 
			for(i = 0; i <190 ; i++) begin: secondstage
			D_FF D_ff2(instructionOut[i],instructionIn[i] , reset, clk);
			end
			endgenerate
endmodule



module alu2mem(instructionIn, instructionOut, clk, reset);
input logic clk, reset;
input logic[210:0] instructionIn; // PC+OPP
output logic[210:0] instructionOut;

genvar i;
			generate 
			for(i = 0; i <211 ; i++) begin: thirdstage
			D_FF D_ff3(instructionOut[i],instructionIn[i] , reset, clk);
			end
			endgenerate
endmodule



module mem2reg(instructionIn, instructionOut, clk, reset);
input logic clk, reset;
input logic[73:0] instructionIn; // PC+OPP
output logic[73:0] instructionOut;

genvar i;
			generate 
			for(i = 0; i <74 ; i++) begin: fourthstage
			D_FF D_ff4(instructionOut[i],instructionIn[i] , reset, ~clk);
			end
			endgenerate
endmodule
