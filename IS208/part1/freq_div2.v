`timescale 1 ns / 1 ns

module freq_div2(output reg clk_out,
		input clk_in,
		input reset);

always @ (posedge clk_in)
begin 
	if (!reset) clk_out <= 1;
	else clk_out <= ~clk_out;
end

endmodule
