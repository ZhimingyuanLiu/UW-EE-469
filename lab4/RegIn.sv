`timescale 1ns/1ps
module RegIn(Rd, Rt, RdorRt, Rm, Reg2Loc,Rn,Aw,Ab,Aa);
input logic [4:0] Rd,Rt,Rm,Rn;
input logic RdorRt, Reg2Loc;
output logic [4:0] Aw,Ab,Aa;

logic [4:0] temp;

mux2_1_4bit OutputToAw(temp,Rd,Rt,RdorRt);
mux2_1_4bit OutputToAb(Ab,temp,Rm,Reg2Loc);

assign Aa = Rn;
assign Aw = temp;

endmodule



module mux2_1_4bit(out, i0, i1, sel);
 output logic [4:0] out;
 input logic [4:0] i0, i1;
 input logic sel;

 logic [4:0] temp1,temp2;
 logic sel_i;
 
 not #50 not1(sel_i,sel);
 genvar i;
 generate
 for( i = 0;i<5;i++) begin: muxes1
 and #50 and1(temp1[i],i1[i],sel);
 and #50 and2(temp2[i],i0[i],sel_i);
 or #50 or1(out[i],temp1[i],temp2[i]);
 end
 endgenerate
endmodule
