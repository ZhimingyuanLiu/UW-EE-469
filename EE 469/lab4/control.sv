`timescale 1ns/10ps
module control(inst,alu_op,r2l,storeb,rw,mw,mr,loadb,m2r,uncond,brtaken,alu_src,xfer_size,negative,overflow,zero,flag,zkSelect,mov);
input logic [31:0] inst;
input logic negative,overflow,zero;
output logic [1:0]  alu_src;
output logic [2:0] alu_op;
output logic [3:0] xfer_size;
output logic r2l,storeb,rw,mw,mr,loadb,m2r,mov,uncond,brtaken,flag,zkSelect;

always_comb begin

if(inst[31:26]==6'b000101) begin //B
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b0;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b1;
brtaken = 1'b1;
mov = 1'b0;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
flag = 0;
mr = 0;
end

else if(inst[31:24] == 8'b01010100) begin //B.LT
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b0;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = (negative !== overflow);
mov = 1'b0;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
flag = 0;
mr = 0;
end

else if(inst[31:24] == 8'b10110100) begin // CBZ
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b0;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = zero;
mov = 1'b0;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
flag = 0;
mr = 0;
end

else if(inst[31:22] == 10'b1001000100) begin //ADDI
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b10;
alu_op = 3'b010;
xfer_size = 4'b1000;
flag = 0;
mr = 0;
end

else if(inst[31:21] == 11'b10101011000) begin //ADDS
zkSelect = 1'b0;
r2l = 1'b1;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b00;
alu_op = 3'b010;
xfer_size = 4'b1000;
flag = 1;
mr = 0;
end

else if(inst[31:21] == 11'b11101011000) begin //SUBS
zkSelect = 1'b0;
r2l = 1'b1;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b00;
alu_op = 3'b011;
xfer_size = 4'b1000;
flag = 1;
mr = 0;
end

else if(inst[31:21] == 11'b11111000010) begin //LDUR
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b1;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b1000;
flag = 0;
mr = 1;
end

else if(inst[31:21] == 11'b00111000010) begin //LDURB
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b1;
m2r = 1'b1;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b0001;
flag = 0;
mr = 1;
end

else if(inst[31:21] == 11'b11111000000) begin //STUR
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b0;
mw = 1'b1;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b1000;
flag = 0;
mr = 1;
end

else if(inst[31:21] == 11'b00111000000) begin //STURB
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b1;
rw = 1'b0;
mw = 1'b1;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b01;
alu_op = 3'b010;
xfer_size = 4'b0001;
flag = 0;
mr = 1;
end

else if(inst[31:23] == 9'b110100101) begin //MOVZ
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b1;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
flag = 0;
mr = 0;
end

else if(inst[31:23] == 9'b111100101) begin //MOVK
zkSelect = 1'b1;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b1;
alu_src = 2'b00;
alu_op = 3'b0;
xfer_size = 4'b1000;
flag = 0;
mr = 0;
end

else begin
zkSelect = 1'b0;
r2l = 1'b0;
storeb = 1'b0;
rw = 1'b1;
mw = 1'b0;
loadb = 1'b0;
m2r = 1'b0;
uncond = 1'b0;
brtaken = 1'b0;
mov = 1'b0;
alu_src = 2'b00;
alu_op = 3'b000;
xfer_size = 4'b1000;
flag = 0;
mr = 0;
end

end

endmodule