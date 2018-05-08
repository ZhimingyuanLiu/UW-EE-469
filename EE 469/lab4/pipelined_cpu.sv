`timescale 1ns/10ps
module pipelined_cpu(clk, reset);
input logic clk, reset;
logic [63:0] da_temp,db_temp,da,da1,db1,db,pc_ps,pc_ns,se_imm19,se_imm26,se_imm9,se_imm12,bran_imm,bran_sh,pc_bran,pc_next,dbTemp,dbTemp1,aluOut,aluOut1,movzOut, rd_result,movkOut,mkmzOut,mem_dout,load_out,rd_out,rd_out1,m2r_out,m2r_out1,alusrcTemp,imm19mins1,imm19mins1_1,imm26mins1,imm26mins1_1;
logic [31:0] inst,inst1;
logic [4:0] ab,rd,rd1,rd2,rm,rd3,rn;
logic brtaken,brtaken_1,uncond,uncond_1,r2l,storeb,rw,mr,mw,loadb,m2r,zero,negative,overflow,flag,carry_out,mov,mov1,mov2;
logic zkSelect,zkSelect1,storeb1,rw1,mr1,mw1,loadb1,m2r1,flag1;
logic negativeNew,negativeNew1,negativeNew2,overflowNew,overflowNew1,overflowNew2,rw2,rw3,mw2,loadb2,m2r2,mr2;
logic zero_alu,negative_forward,overflow_forward,flag2,flag3,loadb3,m2r3,mr3,mw3,r2l1,zkSelect2,rw4,storeb2,zero_aluNew,zero_aluNew1,zero_aluNew2,carry_outNew,carry_outNew1,carry_outNew2;
logic [2:0] aluop,aluop1,aluop2;
logic [1:0] alusrc,alusrc1,alusrc2,shamt,da_mux,db_mux,flag_mux,shamt1;
logic [3:0] xfer_size,xfer_size1,xfer_size2,xfer_size3;
logic [8:0] imm9,imm9_1;
logic [11:0] imm12,imm12_1;
logic [15:0] imm16,imm16_1; 


Register pc(pc_ps,pc_ns,clk,1'b1,reset);
instructmem inst_mem(pc_ps,inst,clk);

//control cntrl_signal(inst,aluop,r2l,storeb,rw,mw,mr,loadb,m2r,uncond,brtaken,alusrc,xfer_size,negative_forward,overflow_forward,zero,flag,zkSelect,mov);
control cntrl_signal(inst1,aluop1,r2l1,storeb1,rw1,mw1,mr1,loadb1,m2r1,uncond_1,brtaken_1,alusrc1,xfer_size1,negative_forward,overflow_forward,zero,flag1,zkSelect1,mov1);

flag_forward cntrl_flag(flag2,flag3,flag_mux);
mux4_1_bit neg_sel(negative_forward,negativeNew2,negativeNew1,negativeNew,1'b0,flag_mux[1],flag_mux[0]);
mux4_1_bit over_sel(overflow_forward,overflowNew2,overflowNew1,overflowNew,1'b0,flag_mux[1],flag_mux[0]);

//signExtend #(.DATA_WIDTH(19)) se_19(inst[23:5],se_imm19);
signExtend #(.DATA_WIDTH(19)) se_19(inst1[23:5],se_imm19);
adder mins1_19(se_imm19,64'b1111111111111111111111111111111111111111111111111111111111111111,imm19mins1);

//signExtend #(.DATA_WIDTH(26)) se_26(inst[25:0],se_imm26);
signExtend #(.DATA_WIDTH(26)) se_26(inst1[25:0],se_imm26);
adder mins1_26(se_imm26,64'b1111111111111111111111111111111111111111111111111111111111111111,imm26mins1);


//mux2_1 cond_bran(bran_imm, imm19mins1_1, imm26mins1_1, uncond_1);
mux2_1 cond_bran(bran_imm, imm19mins1, imm26mins1, uncond_1);
shifter bran_x4(bran_imm,1'b0,6'b000010,bran_sh);
adder branch_pc(pc_ps, bran_sh, pc_bran);
adder pc_4(pc_ps,64'b0000000000000000000000000000000000000000000000000000000000000100,pc_next);
mux2_1 next_br(pc_ns,pc_next,pc_bran, brtaken_1);

//inst2reg buffer1({brtaken,uncond,imm19mins1,imm26mins1,inst[21:10],inst[20:12],inst[20:5],inst[22:21],inst[4:0],inst[20:16],inst[9:5],aluop,r2l,storeb,rw,mw,mr,loadb,m2r,alusrc,xfer_size,flag,zkSelect,mov},{brtaken_1,uncond_1,imm19mins1_1,imm26mins1_1,imm12,imm9,imm16,shamt,rd,rm,rn,aluop1,r2l1,storeb1,rw1,mw1,mr1,loadb1,m2r1,alusrc1,xfer_size1,flag1,zkSelect1,mov1},clk,reset);
inst2reg buffer1(inst,inst1,clk,reset);

//mux2_1_5bit r2l_mux(ab,rd,rm,r2l1);
mux2_1_5bit r2l_mux(ab,inst1[4:0],inst1[20:16],r2l1);
//regfile register(da_temp, db_temp, m2r_out1,rn, ab, rd3, rw4, clk,reset);
regfile register(da_temp, db_temp, m2r_out1,inst1[9:5], ab, rd3, rw4, clk,reset);
checkZero cbz_cntrl(db, zero);

//reg_forward da_forward(rw2,rw3,rn,rd1,rd2,da_mux);
reg_forward da_forward(rw2,rw3,inst1[9:5],rd1,rd2,da_mux);
reg_forward db_forward(rw2,rw3,ab,rd1,rd2,db_mux);
mux4_1 da_sel(da,da_temp,rd_out,m2r_out,64'b0,da_mux[0],da_mux[1]);
mux4_1 db_sel(db,db_temp,rd_out,m2r_out,64'b0,db_mux[0],db_mux[1]);

//reg2alu buffer2({da,db,imm12,imm9,imm16,shamt,rd,aluop1,storeb1,rw1,mw1,mr1,loadb1,m2r1,alusrc1,xfer_size1,flag1,zkSelect1,mov1},{da1,db1,imm12_1,imm9_1,imm16_1,shamt1,rd1,aluop2,storeb2,rw2,mw2,mr2,loadb2,m2r2,alusrc2,xfer_size2,flag2,zkSelect2,mov2}, clk, reset);
reg2alu buffer2({da,db,inst1[21:10],inst1[20:12],inst1[20:5],inst1[22:21],inst1[4:0],aluop1,storeb1,rw1,mw1,mr1,loadb1,m2r1,alusrc1,xfer_size1,flag1,zkSelect1,mov1},{da1,db1,imm12_1,imm9_1,imm16_1,shamt1,rd1,aluop2,storeb2,rw2,mw2,mr2,loadb2,m2r2,alusrc2,xfer_size2,flag2,zkSelect2,mov2}, clk, reset);

signExtend #(.DATA_WIDTH(9)) imm_9(imm9_1, se_imm9);
//signExtend #(.DATA_WIDTH(12)) imm_12(imm12_1, se_imm12);

mux4_1 aluSrc(alusrcTemp, db1, se_imm9, {52'b0,imm12_1}, 64'b0, alusrc2[0], alusrc2[1]);
mux2_1 storeB(dbTemp,db1,{56'b0,db1[7:0]},storeb2);
ALU exe(da1, alusrcTemp, aluop2, aluOut, negative, zero_alu, overflow, carry_out);
movz mz(shamt1,imm16_1,movzOut,rd_result);

mux2_1_bit negativeSelect(negativeNew,negativeNew2,negative,flag2);
mux2_1_bit overflowSelect(overflowNew,overflowNew2,overflow,flag2);
mux2_1_bit zero_aluSelect(zero_aluNew,zero_aluNew2,zero_alu,flag2);
mux2_1_bit carry_outSelect(carry_outNew,carry_outNew2,carry_out,flag2);

movk movk1(aluOut,movzOut, movkOut, rd_result);
mux2_1 mkOrmz(mkmzOut, movzOut, movkOut, zkSelect2);
mux2_1 rdSelect(rd_out,aluOut,mkmzOut,mov2);

alu2mem buffer3({aluOut,rd_out,dbTemp,negativeNew,overflowNew,rw2,loadb2,m2r2,mr2,mw2,xfer_size2,rd1,flag2,zero_aluNew,carry_outNew},{aluOut1,rd_out1,dbTemp1,negativeNew1,overflowNew1,rw3,loadb3,m2r3,mr3,mw3,xfer_size3,rd2,flag3,zero_aluNew1,carry_outNew1},clk,reset);
datamem mem(aluOut1,mw3,mr3,dbTemp1,clk,xfer_size3,mem_dout);
mux2_1 loadb_mux(load_out,mem_dout,{56'b0,mem_dout[7:0]},loadb3);
mux2_1 m2r_mux(m2r_out,rd_out1,load_out,m2r3);

mem2reg buffer4({m2r_out,negativeNew1,overflowNew1,rw3,rd2,zero_aluNew1,carry_outNew1}, {m2r_out1, negativeNew2,overflowNew2,rw4,rd3,zero_aluNew2,carry_outNew2},clk,reset);


endmodule

module flag_forward(alu_flag,mem_flag,flag_mux);
input logic alu_flag, mem_flag;
output logic [1:0] flag_mux;

always_comb begin
if (alu_flag) 
flag_mux = 2'b10;
else if (mem_flag)
flag_mux = 2'b01;
else
flag_mux = 2'b00;
end

endmodule

module reg_forward(rw_alu,rw_mem,curr_reg,alu_reg,mem_reg,reg_mux);
input logic [4:0] curr_reg,alu_reg,mem_reg;
input logic rw_alu,rw_mem;
output logic [1:0] reg_mux;

always_comb begin
if (rw_alu&&(curr_reg==alu_reg)&&(alu_reg!==5'b11111))
reg_mux = 2'b01;
else if (rw_mem&&(curr_reg==mem_reg)&&(mem_reg!==5'b11111))
reg_mux = 2'b10;
else 
reg_mux = 2'b0;
end
endmodule


module signExtend #(parameter DATA_WIDTH = 1)(in,extend);
input logic [DATA_WIDTH-1:0] in;
output logic [63:0] extend;

          
genvar i;
generate
for(i = DATA_WIDTH;i < 64; i++) begin: se
assign extend[i] = in[DATA_WIDTH-1];
end
endgenerate
assign extend[DATA_WIDTH-1:0] = in[DATA_WIDTH-1:0];

endmodule 



module pipelined_cpu_testbench ();

	parameter ClockDelay = 2000;

	logic clk,reset;
	
	pipelined_cpu dut (clk,reset);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
	reset <= 1;
	@(posedge clk);
	reset <= 0;
	@(posedge clk); 
	repeat(1020)@(posedge clk); 
	@(posedge clk); 
	@(posedge clk);
	@(posedge clk); 
	@(posedge clk); 
	@(posedge clk);
	@(posedge clk); 
	@(posedge clk); 
	@(posedge clk);
	@(posedge clk); 
	@(posedge clk); 
	@(posedge clk);
	@(posedge clk); 
	@(posedge clk); 
	@(posedge clk);
	@(posedge clk); 
	@(posedge clk);
	$stop;
		
	end
endmodule



