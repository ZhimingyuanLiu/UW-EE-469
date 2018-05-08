// Top-level module that defines the I/Os for the DE-1 SoC board
`timescale 1ns/10ps
module regfile (ReadData1, ReadData2, WriteData, 
					 ReadRegister1, ReadRegister2, WriteRegister,
					 RegWrite, clk,reset);
input logic RegWrite, clk,reset;
input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister;
input logic [63:0] WriteData;
output logic [63:0] ReadData1, ReadData2;

logic [63:0] reg_out [31:0];
logic [31:0] we;

decoder5_32 decoder(WriteRegister, RegWrite, we);
Registers storage(reg_out,WriteData,clk,we,reset);
mux32_1 mux1(ReadData1,reg_out,ReadRegister1);
mux32_1 mux2(ReadData2,reg_out,ReadRegister2);
endmodule 




