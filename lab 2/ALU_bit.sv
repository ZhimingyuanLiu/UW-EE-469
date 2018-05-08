module ALU_bitMiddle(a, b, sel, Cin, Sub, Cout, out);
input logic a, b, Cin, Sub;
input logic[2:0]sel;
output logic Cout;
output logic out;

logic [4:0] totalOut;


AddandSub fourth(Cout, totalOut[4], Sub, a, b, Cin);
AND1 third(totalOut[3], a, b);
OR1 second(totalOut[2], a, b);
XOR1 first(totalOut[1], a, b);
XNOR1 zero (totalOut[0], a, b);

mux5_1 select (totalOut[0], totalOut[1], totalOut[2], totalOut[3], totalOut[4], sel, out);

endmodule 


