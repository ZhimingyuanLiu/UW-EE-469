`timescale 1ns/1ps
module eight_bits(din, vin, dout);
input logic [63:0] din,vin;
output logic [63:0] dout;

logic negative, zero, overflow, carry_out;
ALU add1({56'b0,din[7:0]}, {vin[63:8],8'b0}, 3'b010, dout, negative, zero, overflow, carry_out);

endmodule
