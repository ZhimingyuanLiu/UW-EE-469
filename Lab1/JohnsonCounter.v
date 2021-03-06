module JohnsonCounter (clk, reset, out); 
    input clk;
    input reset;
    output [3:0] out;
    reg [3:0] outi;

    
    always @(negedge reset or posedge clk)
    begin
        if(reset == 1'b0)   begin  
            outi = 4'b0000;   end  
        else begin  
            outi = {~outi[0], outi[3:1]};  
        end 
    end
    
    
    assign out = outi;
    
endmodule