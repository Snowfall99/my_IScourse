`timescale 1 ns / 1 ns

module compare_8_bit(a, b, out);
	output out;
	input [7:0] a, b;
	
	assign out = (a[7:0]>b[7:0])?1:0;
endmodule
	