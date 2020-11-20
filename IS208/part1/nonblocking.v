`timescale 1ns / 1ns
module nonblocking(output reg [3:0] c,
output reg [3:0] b,
input [3:0] a,
input clk);

always @(posedge clk)
begin
b <= a;
c <= b;
$display("nonblocking assign: c = %d, b = %d, a = %d,", c, b, a);
end
endmodule
