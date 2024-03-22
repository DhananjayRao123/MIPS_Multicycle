module RegisterFile(
	input [4:0] rs,
	input [4:0] rt,
	input [4:0] rd,
	input RegWrite,
	input [31:0] write_data,
	input clk,
	output reg [31:0] A,
	output reg [31:0] B
);

reg [31:0] read_data_rs;
reg [31:0] read_data_rt;

reg [31:0] registers[15:0];

initial
begin
registers[2] = 32'h00F34E5B;
registers[3] = 32'h0001A45F;
//registers[4] = 32'h0004E317;
//registers[5] = 32'h0004AE33;
registers[4] = 32'd0;
registers[5] = 32'd0;
end

// Write operation is synchronized with the clock
always @ (posedge clk) begin
	if (RegWrite) begin
    	registers[rd] <= write_data;
	end
    A <= read_data_rs;
    B <= read_data_rt;
end

// Read operation is purely combinational
always @ (*) begin
	read_data_rs = registers[rs];
	read_data_rt = registers[rt];
end

endmodule