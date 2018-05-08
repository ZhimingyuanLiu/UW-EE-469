`timescale 1ns/1ps
module mux6_1(i0,i1,i2,i3,i4,i5,sel,out);
input i0,i1,i2,i3,i4,i5;
input[2:0] sel;
output out ;

logic out1;
logic out2;
mux4_1_bit Firstfour(out1, i0, i1, i2, i3, sel[1], sel[2]);
mux2_1_bit firstTwo(out2, i4, i5, sel[2]);
mux2_1_bit lastTwo(out, out1, out2, sel[0]);
endmodule



module mux4_1_bit(out, i00, i01, i10, i11, sel0, sel1);
 output logic out;
 input logic i00, i01, i10, i11, sel0, sel1;

 logic v0, v1;

 mux2_1_bit m0(.out(v0), .i0(i00), .i1(i01), .sel(sel1));
 mux2_1_bit m1(.out(v1), .i0(i10), .i1(i11), .sel(sel1));
 mux2_1_bit m(.out(out), .i0(v0), .i1(v1), .sel(sel0));
endmodule
