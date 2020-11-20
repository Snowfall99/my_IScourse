`timescale 1ns / 1ns
module blocking(c, b, a, clk);
output reg [3:0] c, b;
input [3:0] a;
input clk;

always @(posedge clk) 
begin
b = a;
$display ("block assign: c = %d, b = %d, a = %d,", c, b, a);
end

always @(posedge clk) 
begin
c = b; 
$display ("block assign: c = %d, b = %d, a = %d,", c, b, a);
end

endmodule
