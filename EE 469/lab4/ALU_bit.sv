`timescale 1ns/1ps
module ALU_bitMiddle(a, b, sel, Cin_a,Cin_s,Cout_a,Cout_s, out);
input logic a, b, Cin_a,Cin_s;
input logic [2:0] sel;
output logic Cout_a, Cout_s;
output logic out;
logic [5:0] totalOut;

assign totalOut[0] = b;
and  AND0(totalOut[1], a, b);
Add adder(Cout_a,totalOut[2], a, b, Cin_a);
xor  XOR(totalOut[3], a, b);
Sub SUBSTRACTOR(Cout_s, totalOut[4], a, b, Cin_s);
or  OR(totalOut[5], a, b);

mux6_1 select(totalOut[0], totalOut[1],totalOut[2],totalOut[3],totalOut[4],totalOut[5],sel,out);

endmodule 


