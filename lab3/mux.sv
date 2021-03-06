`timescale 1ns/1ps
// Traditional 2 to 1 Mux for one bit input
module mux2_1_bit(out, i0, i1, sel);
 output logic out;
 input logic i0, i1, sel;

 logic temp1,temp2;
 logic sel_i;
 
 not #50 not1(sel_i,sel);
 and #50 and1(temp1,i1,sel);
 and #50 and2(temp2,i0,sel_i);
 or #50 or1(out,temp1,temp2);
 
endmodule

// 2 to 1 mux with 64 bit inputs at a time
module mux2_1(out, i0, i1, sel);
 output logic [63:0] out;
 input logic [63:0] i0, i1;
 input logic sel;

 logic [63:0] temp1,temp2;
 logic sel_i;
 
 not #50 not1(sel_i,sel);
 genvar i;
 generate
 for( i = 0;i<64;i++) begin: muxes1
 and #50 and1(temp1[i],i1[i],sel);
 and #50 and2(temp2[i],i0[i],sel_i);
 or #50 or1(out[i],temp1[i],temp2[i]);
 end
 endgenerate
endmodule

// 4 to 1 mux with 64 bit inputs at a time
module mux4_1(out, i00, i01, i10, i11, sel0, sel1);
 output logic [63:0] out;
 input logic [63:0] i00, i01, i10, i11;
 input logic sel0, sel1;

 logic [63:0] v0, v1;

 mux2_1 m0(v0, i00, i01, sel0);
 mux2_1 m1(v1, i10, i11, sel0);
 mux2_1 m (out, v0, v1, sel1);
 
endmodule

// 32 to 1 mux with 32 amount of 64 bit inputs
module mux32_1(out,i,sel);
output logic [63:0] out;
input logic [63:0] i [31:0];
input logic [4:0] sel;

logic [63:0] v1,v2,v3,v4,v5,v6,v7,v8,v9,v10;

mux4_1 mux1(v1, i[0], i[1], i[2], i[3], sel[0], sel[1]);
mux4_1 mux2(v2, i[4], i[5], i[6], i[7], sel[0], sel[1]);
mux4_1 mux3(v3, i[8], i[9], i[10], i[11], sel[0], sel[1]);
mux4_1 mux4(v4, i[12], i[13], i[14], i[15], sel[0], sel[1]);
mux4_1 mux5(v5, i[16], i[17], i[18], i[19], sel[0], sel[1]);
mux4_1 mux6(v6, i[20], i[21], i[22], i[23], sel[0], sel[1]);
mux4_1 mux7(v7, i[24], i[25], i[26], i[27], sel[0], sel[1]);
mux4_1 mux8(v8, i[28], i[29], i[30], i[31], sel[0], sel[1]);
mux4_1 mux9(v9, v1, v2, v3, v4, sel[2], sel[3]);
mux4_1 mux10(v10, v5, v6, v7, v8, sel[2], sel[3]);
mux2_1 mux11(out,v9,v10,sel[4]);
endmodule 

module mux2_1_bit_testbench();
 logic i0, i1, sel;
 logic out;

 mux2_1 dut (out, i0, i1, sel);

 initial begin
 sel=0; i0=0; i1=0; #10;
 sel=0; i0=0; i1=1; #10;
 sel=0; i0=1; i1=0; #10;
 sel=0; i0=1; i1=1; #10;
 sel=1; i0=0; i1=0; #10;
 sel=1; i0=0; i1=1; #10;
 sel=1; i0=1; i1=0; #10;
 sel=1; i0=1; i1=1; #10;
 end
endmodule 

module mux2_1_testbench();
logic [63:0] out;
logic [63:0] i0, i1;
logic sel;

 mux2_1 dut(out, i0, i1, sel);

 initial begin
 i0 = 256; 
 i1 = 128;
 sel = 0; #10;
 sel = 1; #10;
 end
endmodule 

module mux4_1_testbench();
logic [63:0] out;
logic [63:0] i00, i01, i10, i11;
logic sel0, sel1;

mux4_1 dut(out, i00, i01, i10, i11, sel0, sel1);

 initial begin
 {i11,i10,i01,i00} = 256; 
 {i11,i10,i01,i00} = 128;
 {sel1,sel0} = 00; #10;
 {sel1,sel0} = 01; #10;
 {sel1,sel0} = 10; #10;
 {sel1,sel0} = 11; #10;
 end
endmodule 

module mux32_1_testbench();
logic [63:0] out;
logic [63:0] i [31:0];
logic [4:0] sel;

mux32_1 dut(out,i,sel);

 integer k;
 initial begin
 i = {64'b0,64'b0,64'b0,64'b0,64'b0,64'b0,64'b1,64'b0,64'b0,64'b0,64'b0,64'b0,64'b0,64'b0,64'b1,64'b0,64'b0,64'b0,64'b0,64'b0,64'b0,64'b0,64'b1,64'b0,64'b0,64'b0,64'b0,64'b0,64'b0,64'b0,64'b1,64'b0};
 for(k=0; k<32; k++) begin
 sel = k; #50;
 end
 end
endmodule 