`timescale 1ns/1ps
module execute(A, B, cntrl, result, negative, zero, overflow, carry_out);

input logic[63:0] A;
input logic[63:0] B;
input logic [2:0] cntrl;
output logic overflow, zero, negative,carry_out;
output logic [63:0] result;

logic [63:0] Cout_a,Cout_s;
logic [1:0] Cout;
logic cntrli, temp1, temp2, temp3,temp4;

ALU_bitMiddle first(A[0], B[0], cntrl, 1'b0,1'b1,Cout_a[0],Cout_s[0], result[0]);
genvar i;
generate
for(i = 1; i < 64; i++) begin: check
ALU_bitMiddle middle(A[i], B[i],cntrl, Cout_a[i-1], Cout_s[i-1], Cout_a[i],Cout_s[i],result[i]);
end
endgenerate

not  NOT(cntrli, cntrl[0]);
and  AND1(temp1,cntrli,Cout_a[63]);
and  AND2(temp2,cntrl[0],Cout_s[63]);
or  OR1(Cout[0], temp1, temp2);

and  AND3(temp3,cntrli,Cout_a[62]);
and  AND4(temp4,cntrl[0],Cout_s[62]);
or  OR2(Cout[1], temp3, temp4);

xor  overFLOW(overflow, Cout[0], Cout[1]);
checkZero checkIt(result, zero);
assign negative = result[63];
assign carry_out = Cout[0];

endmodule
