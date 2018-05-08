module rippleCounter(clk, reset, out);

input  clk,reset;
output [3:0] out;
wire [3:0] outi;
wire [3:0] outi_bar;

assign out = outi;

DFlipFlop zero (outi[0], outi_bar[0], outi_bar[0], clk, reset);
DFlipFlop one (outi[1], outi_bar[1], outi_bar[1], outi_bar[0], reset);
DFlipFlop two (outi[2], outi_bar[2], outi_bar[2], outi_bar[1], reset);
DFlipFlop three (outi[3], outi_bar[3], outi_bar[3], outi_bar[2], reset);



endmodule

