`timescale 1ns/1ps
module pc_inst(imm19,imm26,clk,un_br,br_taken,inst,reset);
input logic clk,un_br,br_taken,reset;
input logic [18:0] imm19;
input logic [25:0] imm26;
output logic [31:0] inst;

logic [63:0] br_addr,sh_br_addr,pc_ps,br_res,pc_res,pc_ns,extend_19,extend_26;
logic negative, zero, overflow, carry_out,negative1, zero1, overflow1, carry_out1;

genvar i;
generate
for(i = 19;i < 64; i++) begin: sefor19
assign extend_19[i] = imm19[18];
end
for(i = 26; i < 64; i++) begin: sefor26
assign extend_26[i] = imm26[25];
end
endgenerate
assign extend_19[18:0] = imm19[18:0];
assign extend_26[25:0] = imm26[25:0];
mux2_1 cond_br(br_addr, extend_19,extend_26, un_br);
shifter shift_br(br_addr,1'b0,6'b000010,sh_br_addr);
ALU adder1(sh_br_addr, pc_ps, 3'b010, br_res, negative, zero, overflow, carry_out);
ALU adder2(64'b0000000000000000000000000000000000000000000000000000000000000100, pc_ps, 3'b010, pc_res, negative1, zero1, overflow1, carry_out1);
mux2_1 br_tak(pc_ns, pc_res,br_res, br_taken);
Register pc(pc_ps,pc_ns,clk,1'b1,reset);
instructmem inst_mem(pc_ps,inst,clk);

endmodule
