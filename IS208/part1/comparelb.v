`timescale 10 ns/ 1 ns

module comparelb (y, b, a);
	output y;
	input b, a;
	
	assign y= (a == b) ? 1 : 0;
endmodule