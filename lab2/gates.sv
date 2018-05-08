module AND1(out, a, b);

input logic a,b;
output logic out;

and and1(out, a, b);

endmodule 

module OR1(out, a, b);
input logic a,b;
output logic out;

or or1(out, a, b);

endmodule 

module XOR1(out, a, b);
input logic a,b;
output logic out;

xor xor1(out, a, b);

endmodule 

module XNOR1(out, a, b);
input logic a,b;
output logic out;

xnor xnor1(out, a, b);

endmodule 