`timescale 10 ns / 1 ns
`include "compare_8_bit.v"

module compare_test;
	reg [7:0] a, b;
	wire equal;
	
	initial
	begin
	a='b00000000;
    	b='b00000000;
    	#100 a='b00000000;b='b00000001;
    	#100 a='b00010001;b='b00000011;
    	#100 a='b00000001;b='b00000010;
    	#100 a=100;b=99;
    	#100 a=123;b=125;
    	#100 a=135;b=130;
    	#100 a=245;b=246;
    	#100 $stop;
	end

	compare_8_bit compare(.out(out), .a(a), .b(b));
endmodule

	