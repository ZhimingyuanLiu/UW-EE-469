`timescale 1ns/1ps
module Add (Cout, S, A, B, Cin);
output logic Cout, S; 
input logic A, B, Cin;

logic AB, ACin, BCin;

and  and1(AB,A,B);
and  and2(ACin,A,Cin);
and  and3(BCin, B, Cin);

or  carryout(Cout,AB,ACin,BCin);

xor  sum(S, A, B, Cin);

endmodule

module adder(in1, in2, out);
input logic[63:0] in1;
input logic[63:0] in2;
output logic [63:0] out;

logic [63:0] carrier;

Add addFirst(carrier[0], out[0],in1[0],in2[0],1'b0);
genvar i;
			generate 
			for(i = 1; i < 64; i++) begin: storage
			Add other(carrier[i], out[i], in1[i], in2[i],carrier[i-1]);
			end
			endgenerate
endmodule 




module Sub (Cout, S, A, B, Cin);
output logic Cout, S; 
input logic A, B, Cin;

logic Bi;
logic AB, ACin, BCin;

not  not1(Bi, B);

and  and1(AB,A,Bi);
and  and2(ACin,A,Cin);
and  and3(BCin, Bi, Cin);

or  carryout(Cout,AB,ACin,BCin);

xor  sum(S, A, Bi, Cin);

endmodule
