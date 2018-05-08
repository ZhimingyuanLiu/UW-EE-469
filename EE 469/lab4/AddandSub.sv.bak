`timescale 1ns/1ps
module Add (Cout, S, A, B, Cin);
output logic Cout, S; 
input logic A, B, Cin;

logic AB, ACin, BCin;

and #50 and1(AB,A,B);
and #50 and2(ACin,A,Cin);
and #50 and3(BCin, B, Cin);

or #50 carryout(Cout,AB,ACin,BCin);

xor #50 sum(S, A, B, Cin);

endmodule


module Sub (Cout, S, A, B, Cin);
output logic Cout, S; 
input logic A, B, Cin;

logic Bi;
logic AB, ACin, BCin;

not #50 not1(Bi, B);

and #50 and1(AB,A,Bi);
and #50 and2(ACin,A,Cin);
and #50 and3(BCin, Bi, Cin);

or #50 carryout(Cout,AB,ACin,BCin);

xor #50 sum(S, A, Bi, Cin);

endmodule
