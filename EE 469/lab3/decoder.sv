`timescale 1ns/1ps
module decoder5_32(WR, RW, DES);
input logic [4:0] WR;
input logic RW;
output logic [31:0] DES;
logic [3:0] en;

logic [31:0] temp;

decoder2_4 ONE(en[3:0], {WR[3],WR[4]});
decoder3_8 TWO(temp[31:24], WR[2:0], en[3]);
decoder3_8 THREE(temp[23:16], WR[2:0], en[2]);
decoder3_8 FOUR(temp[15:8], WR[2:0], en[1]);
decoder3_8 FIVE(temp[7:0], WR[2:0], en[0]);

// Never write to register 31
assign DES[31] = 1'b0; 

genvar i;
generate
for(i = 0; i < 31; i++) begin: check
and AndC(DES[i], temp[i], RW);
end
endgenerate
endmodule

module decoder5_32_testbench();
logic [4:0] WR;
logic RW;
logic [31:0] DES;

 decoder5_32 dut(WR, RW, DES);

 integer i;
 initial begin
 RW = 1;
 for(i=0; i<32; i++) begin
 WR = i; #50;
 end
 end
endmodule 

module decoder3_8 (d, sel, en);
   input logic [2:0] sel;
   input logic en;
   output logic [7:0] d;
   logic [2:0] seln;

   not #50 n0(seln[0], sel[0]);
   not #50 n1(seln[1], sel[1]);
   not #50 n2(seln[2], sel[2]);

   and #50 d0(d[0], en, seln[2], seln[1], seln[0]);
   and #50 d1(d[1], en, seln[2], seln[1], sel[0]);
   and #50 d2(d[2], en, seln[2], sel[1],  seln[0]);
   and #50 d3(d[3], en, seln[2], sel[1],  sel[0]);
   and #50 d4(d[4], en, sel[2],  seln[1], seln[0]);
   and #50 d5(d[5], en, sel[2],  seln[1], sel[0]);
   and #50 d6(d[6], en, sel[2],  sel[1],  seln[0]);
   and #50 d7(d[7], en, sel[2],  sel[1],  sel[0]);
endmodule

module decoder3_8_testbench();
logic [2:0] sel;
logic en;
logic [7:0] d;

decoder3_8 dut(d, sel, en);

 integer i;
 initial begin
 en = 1;
 for(i=0; i<7; i++) begin
 sel = i; #10;
 end
 end
 
 integer k;
 initial begin
 en = 0;
 for(k=0; k<7; k++) begin
 sel = k; #10;
 end
 end
endmodule 

module decoder2_4 (d,sel); 
input logic [1:0] sel;
output logic [3:0] d;
logic not1,not2;

not #50 not1g(not1,sel[0]);
not #50 not2g(not2,sel[1]);
and #50 and1(d[0],not1,not2);
and #50 and2(d[1],not1,sel[1]);
and #50 and3(d[2],sel[0],not2);
and #50 and4(d[3],sel[0],sel[1]);

endmodule

module decoder2_4_testbench();
logic [1:0] sel;
logic [3:0] d;

decoder3_8 dut(d, sel);

 integer i;
 initial begin
 for(i=0; i<3; i++) begin
 sel = i; #10;
 end
 end
 
endmodule 