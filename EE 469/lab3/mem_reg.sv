`timescale 1ns/10ps
module mem_reg(flag, clk, shamt, rw, mw, mr, rd, rt, rdt, rm, rn, r2l, imm16, store, imm9, imm12, alusrc, aluop, zero, overflow, negative, size, mtr, loadb, storeb,carry_out,reset);
input logic clk, rw, mw, mr, rdt, r2l, mtr, loadb, storeb,reset;
output logic zero, overflow, negative,carry_out;
input logic [1:0] store,alusrc;
input logic [4:0] rd, rt, rm, rn;
input logic [15:0] imm16;
input logic [1:0] shamt;
input logic [8:0] imm9;
input logic [11:0] imm12;
input logic [3:0] size;
input logic [2:0] aluop;
input logic flag;


logic [63:0] movk_out,movz_temp,movz_out,shamt16,alu_in,alu_out,mem_din,mem_dout,eight_load_out,eight_store_out,load_mux_out,mem2reg, read_b, read_a, reg_dw,extend_9;
logic [4:0] aa,ab,aw;
logic n_ps,o_ps,n_ns,o_ns;

datamem mem(alu_out, mw, mr,mem_din,clk,size,mem_dout);

eight_bits load(mem_dout, 64'b0,eight_load_out);

eight_bits store1(read_b, mem_dout,eight_store_out);

mux2_1 load_mux(load_mux_out, mem_dout, eight_load_out, loadb);

mux2_1 store_mux(mem_din, read_b, eight_store_out, storeb);

mux2_1 mem2reg_mux(mem2reg,alu_out,load_mux_out, mtr);

mux4_1 reg_write(reg_dw, movz_out, movk_out, mem2reg, 64'b0, store[0], store[1]);

mux4_1 alu_mux(alu_in, read_b, extend_9, {52'b0,imm12}, 64'b0, alusrc[0], alusrc[1]);

ALU alu(read_a, alu_in, aluop, alu_out, n_ns,zero,o_ns,carry_out);

genvar i;
generate
for(i = 9;i < 64; i++) begin: sefor9
assign extend_9[i] = imm9[8];
end
endgenerate
assign extend_9[8:0] = imm9[8:0];

assign negative = n_ps;
assign overflow = o_ps;

D_FF_h neg(n_ps, n_ns, flag, clk);
D_FF_h ove(o_ps, o_ns, flag, clk);

RegIn reg_in(rd, rt, rdt, rm, r2l,rn,aw,ab,aa);

regfile register(read_a, read_b, reg_dw, aa, ab, aw, rw, clk,reset);

movz movz1(shamt,imm16,movz_out,movz_temp);

movk movk1(alu_out,movz_out, movk_out, movz_temp);
endmodule
