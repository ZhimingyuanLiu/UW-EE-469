module mux5_1 (i0,i1,i2,i3,i4,sel,out);
input i0,i1,i2,i3,i4;
input[2:0] sel;
output out ;

logic out1;
mux4_1 Firstfour(out1, i0, i1, i2, i3, sel[0], sel[1]);
mux2_1 LastTwO(out, out1, out, sel[2]);

endmodule



module mux4_1(out, i00, i01, i10, i11, sel0, sel1);
 output logic out;
 input logic i00, i01, i10, i11, sel0, sel1;

 logic v0, v1;

 mux2_1 m0(.out(v0), .i0(i00), .i1(i01), .sel(sel0));
 mux2_1 m1(.out(v1), .i0(i10), .i1(i11), .sel(sel0));
 mux2_1 m (.out(out), .i0(v0), .i1(v1), .sel(sel1));
endmodule

module mux2_1(out, i0, i1, sel);
 output logic out;
 input logic i0, i1, sel;

 logic temp1,temp2;
 logic sel_i;
 
 not  not1(sel_i,sel);
 and  and1(temp1,i1,sel);
 and  and2(temp2,i0,sel_i);
 or  or1(out,temp1,temp2);
 
endmodule
