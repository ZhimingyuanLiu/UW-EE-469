`timescale 1ns/10ps
module control(inst,mux_sel,alu_op,alu_src,xfer_size,dw,negative,overflow,zero,imm26,imm19,imm12,imm9,rd,rt,rm,rn,shamt,flag,mr,imm16);
input logic [31:0] inst;
input logic negative, overflow, zero;
output logic [8:0] mux_sel,imm9;
output logic [1:0] dw, alu_src,shamt;
output logic [2:0] alu_op;
output logic [3:0] xfer_size;
output logic [25:0] imm26;
output logic [18:0] imm19;
output logic [11:0] imm12;
output logic [4:0] rd,rt,rm,rn;
output logic flag,mr;
output logic [15:0] imm16;

always_comb begin

if(inst[31:26]==6'b000101) begin //B
mux_sel = 9'b110000000;
dw = 2'b00;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
imm26 = inst[25:0];
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = 9'b0;
rd = 5'b0;
rt = 5'b0;
rm = 5'b0;
rn = 5'b0;
shamt = 2'b0;
flag = 0;
mr = 0;
imm16 = 16'b0;
end

else if(inst[31:24] == 8'b01010100) begin //B.LT
mux_sel = {1'b0,(negative !== overflow), 7'b0000000};
dw = 2'b00;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = inst[23:5];
imm12 = 12'b0;
imm9 = 9'b0;
rd = 5'b0;
rt = 5'b0;
rm = 5'b0;
rn = 5'b0;
shamt = 2'b0;
flag = 0;
mr = 0;
imm16 = 16'b0;
end

else if(inst[31:24] == 8'b10110100) begin // CBZ
mux_sel = {1'b0,zero,7'b0000010};
dw = 2'b00;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = inst[23:5];
imm12 = 12'b0;
imm9 = 9'b0;
rd = 5'b0;
rt = inst[4:0];
rm = 5'b0;
rn = 5'b0;
shamt = 2'b0;
flag = 0;
mr = 0;
imm16 = 16'b0;
end

else if(inst[31:22] == 10'b1001000100) begin //ADDI
mux_sel = 9'b001000000;
dw = 2'b10;
alu_src = 2'b10;
alu_op = 3'b010;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = inst[21:10];
imm9 = 9'b0;
rd = inst[4:0];
rt = 5'b0;
rm = 5'b0;
rn = inst[9:5];
shamt = 2'b0;
flag = 0;
mr = 0;
imm16 = 16'b0;
end

else if(inst[31:21] == 11'b10101011000) begin //ADDS
mux_sel = 9'b001000001;
dw = 2'b10;
alu_src = 2'b00;
alu_op = 3'b010;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = 9'b0;
rd = inst[4:0];
rt = 5'b0;
rm = inst[20:16];
rn = inst[9:5];
shamt = 2'b0;
flag = 1;
mr = 0;
imm16 = 16'b0;
end

else if(inst[31:21] == 11'b11101011000) begin //SUBS
mux_sel = 9'b001000001;
dw = 2'b10;
alu_src = 2'b00;
alu_op = 3'b011;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = 9'b0;
rd = inst[4:0];
rt = 5'b0;
rm = inst[20:16];
rn = inst[9:5];
shamt = 2'b0;
flag = 1;
mr = 0;
imm16 = 16'b0;
end

else if(inst[31:21] == 11'b11111000010) begin //LDUR
mux_sel = 9'b001001010;
dw = 2'b10;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = inst[20:12];
rd = 5'b0;
rt = inst[4:0];
rm = 5'b0;
rn = inst[9:5];
shamt = 2'b0;
flag = 0;
mr = 1;
imm16 = 16'b0;
end

else if(inst[31:21] == 11'b00111000010) begin //LDURB
mux_sel = 9'b001011010;
dw = 2'b10;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b0001;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = inst[20:12];
rd = 5'b0;
rt = inst[4:0];
rm = 5'b0;
rn = inst[9:5];
shamt = 2'b0;
flag = 0;
mr = 1;
imm16 = 16'b0;
end

else if(inst[31:21] == 11'b11111000000) begin //STUR
mux_sel = 9'b000100010;
dw = 2'b00;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = inst[20:12];
rd = 5'b0;
rt = inst[4:0];
rm = 5'b0;
rn = inst[9:5];
shamt = 2'b0;
flag = 0;
mr = 1;
imm16 = 16'b0;
end

else if(inst[31:21] == 11'b00111000000) begin //STURB
mux_sel = 9'b000100110;
dw = 2'b00;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b0001;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = inst[20:12];
rd = 5'b0;
rt = inst[4:0];
rm = 5'b0;
rn = inst[9:5];
shamt = 2'b0;
flag = 0;
mr = 1;
imm16 = 16'b0;
end

else if(inst[31:23] == 9'b110100101) begin //MOVZ
mux_sel = 9'b001000000;
dw = 2'b00;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = 9'b0;
rd = inst[4:0];
rt = 5'b0;
rm = 5'b0;
rn = 5'b0;
shamt = inst[22:21];
flag = 0;
mr = 0;
imm16 = inst[20:5];
end

else if(inst[31:23] == 9'b111100101) begin //MOVK
mux_sel = 9'b001000000;
dw = 2'b01;
alu_src = 2'b00;
alu_op = 3'b0;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = 9'b0;
rd = inst[4:0];
rt = 5'b0;
rm = 5'b0;
rn = 5'b0;
shamt = inst[22:21];
flag = 0;
mr = 0;
imm16 = inst[20:5];
end
else begin
mux_sel = 9'b000000000;
dw = 2'b00;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
imm26 = 26'b0;
imm19 = 19'b0;
imm12 = 12'b0;
imm9 = 9'b0;
rd = 5'b0;
rt = 5'b0;
rm = 5'b0;
rn = 5'b0;
shamt = 2'b0;
flag = 0;
mr = 0;
imm16 = 16'b0;

end
end

endmodule
