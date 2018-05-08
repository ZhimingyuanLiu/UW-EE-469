module ALU(a, b, sel, Cin, Sub, Negative, overflow, Cout, zero, out);
input logic[63:0]a;
input logic[63:0]b;
input logic Cin,Sub;
input logic [2:0] sel;
output logic overflow, zero, Negative;
output logic [63:0] Cout, out;




logic connect;


ALU_bitMiddle first (a[0], b[0], sel, 1'b0, Sub, Cout[0], out[0]);
assign zero[0] = out[0];
genvar i;
generate
for(i = 1; i < 63; i++) begin: check
ALU_bitMiddle middle(a[i], b[i], sel, Cout[i-1], out[i]);

end
endgenerate

ALU_bitMiddle last (a[63], b[63], sel, Cout[62], Sub, Cout[63], out[63]);

xor overFLOW (overflow, Cout[62], Cout[63]);

nor checkLast(zero[63], out[62], zero[62]);


assign connect = Cout[63];
assign Negative = connect;



endmodule
