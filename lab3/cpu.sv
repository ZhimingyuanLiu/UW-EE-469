`timescale 1ns/10ps
module cpu(clk,reset);
input logic clk,reset;

logic [31:0] inst;
logic [8:0] mux_sel,imm9;
logic [2:0] alu_op;
logic [1:0] alu_src,dw,shamt;
logic [3:0] xfer_size;
logic negative, overflow, zero,flag;
logic [25:0] imm26;
logic [18:0] imm19;
logic [11:0] imm12;
logic [15:0] imm16;
logic [4:0] rd,rt,rm,rn;
logic carry_out;
logic mr;

assign instruction = inst;

control cntrl_logic(inst,mux_sel,alu_op,alu_src,xfer_size,dw,negative,overflow,zero,imm26,imm19,imm12,imm9,rd,rt,rm,rn,shamt,flag,mr,imm16);
pc_inst instr(imm19,imm26,clk,mux_sel[8],mux_sel[7],inst,reset);
mem_reg mem(flag, clk, shamt, mux_sel[6], mux_sel[5], mr, rd, rt, mux_sel[1], rm, rn, mux_sel[0], imm16, dw, imm9, imm12, alu_src, alu_op, zero, overflow, negative, xfer_size, mux_sel[3], mux_sel[4], mux_sel[2],carry_out,reset);
endmodule

module cpu_testbench ();

	parameter ClockDelay = 20000;

	logic clk,reset;
	
	cpu dut (clk,reset);
	
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
	repeat(1000)@(posedge clk); 
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
