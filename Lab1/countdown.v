module counterDown(clk, reset, out);

input  clk,reset;
output [3:0] out;
wire [3:0] outi;
wire [3:0] outi_bar;
wire [3:0] d;

assign d[0] = outi_bar[0];
assign d[1] = (outi_bar[0] & outi_bar[1]) | (outi[0] & outi[1]);
assign d[2] = (outi_bar[0] & outi_bar[1] & outi_bar[2]) | (outi[0] & outi[2]) | (outi[1] & outi_bar[0] & outi[2]);
assign d[3] = (outi_bar[0] & outi_bar[1] & outi_bar[2] & outi_bar[3]) | (outi_bar[0] & outi_bar[2] & outi[1] & outi[3]) | (outi[3] & outi[2]) | (outi[3] & outi_bar[2] & outi[0]);

assign out = outi;

DFlipFlop zero (outi[0], outi_bar[0], d[0], clk, reset);
DFlipFlop one (outi[1], outi_bar[1], d[1], clk, reset);
DFlipFlop two (outi[2], outi_bar[2], d[2], clk, reset);
DFlipFlop three (outi[3], outi_bar[3], d[3], clk, reset);



endmodule

