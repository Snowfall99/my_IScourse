module freq_div20 (output reg clk_500k, input clk_10m, input reset);
reg [4:0] cnt;
always @(posedge clk_10m)
begin
if (!reset)
begin
clk_500k <= 1'b0;
cnt <= 5'b0;
end
else
begin
if (cnt == 5'd19)
begin
cnt <= 5'b0;
clk_500k <= ~clk_500k;
end
else
cnt <= cnt + 1'b1;
end
end
endmodule