module MUX_2to1_32(i0, i1, sel, out);
input [31:0] i0, i1;
input sel;
output reg [31:0] out;

always @ (*)
begin
	case (sel)
	1'b0: out = i0;
	1'b1: out = i1;
	default: out = 5'bx;
	endcase
end
endmodule


module MUX_2to1_5(i0, i1, sel, out);

input [4:0] i0, i1;
input sel;
output reg [4:0] out;

always @ (*)
begin
	case (sel)
	1'b0: out = i0;
	1'b1: out = i1;
	default: out = 32'bx;
	endcase
end

endmodule

module MUX_4to1_32 (i0, i1, i2, i3, sel, out);

input [31:0] i0, i1, i2, i3;
input [1:0] sel;
output reg [31:0] out;

always @ (*)
begin
	case (sel)
	2'b00: out = i0;
	2'b01: out = i1;
    2'b10: out = i2;
    2'b11: out = i3;
	default: out = 32'bx;
	endcase
end

endmodule

