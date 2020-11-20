`timescale 10 ns / 1 ns
`include "comparelb.v"

module tb_comparelb;
	wire p_y;
	reg p_a, p_b;

	comparelb m_cmplb(.y(p_y), .b(p_b), .a(p_a));
	initial
	begin
		p_a = 0; p_b = 0;
		#100 p_a = 0; p_b = 1;
		#100 p_a = 1; p_b = 0;
		#100 p_a = 1; p_b = 1;
		#100 $stop;
	end

	initial
	begin
		$monitor("current time: %tns,", $time, "<----> y=%b, b=%b, a=%b", p_y, p_b, p_a);
	end
endmodule