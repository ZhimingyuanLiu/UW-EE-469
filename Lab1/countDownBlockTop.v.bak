`include "countDownBlock.bdf"
`include "dff.v"

module testBench;

  wire clk, reset;
  wire [3:0] out;

  countDownBlock BCounter(.clk(clk), .reset(reset), .out(out));

  Tester BCounterTester(clk, reset, out);

  initial
    begin
      $dumpfile("BCounter.vcd");
      $dumpvars(1, BCounter);
    end 

endmodule

module Tester (clk, reset, out);
	output clk, reset;
	input [3:0] out;
	reg clk, reset;

	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	
	always begin
	#(CLOCK_PERIOD / 2); clk = ~clk;
	end
	
	initial 
		begin
			$display("\t\t  clk \t reset \t out \t\t Time ");
			$monitor("\t\t  %b\t %b \t %b", clk, reset, out, $time );
		end

	initial begin	
						@(posedge clk);
		reset <= 1;		@(posedge clk);
		reset <= 0;		@(posedge clk);
		reset <= 1;		@(posedge clk);
		repeat(40) begin
						@(posedge clk);
                end
		                 @(posedge clk);
						@(posedge clk);
		$finish;
	end
endmodule