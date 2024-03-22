module mem(clk, rst_n, Write_data, ALUOut, IorD, MemRead, MemWrite, PC_change, PC_choose, IRWrite, IR, MDR, PC);

input clk, rst_n;
input [31:0] Write_data;
input [31:0] ALUOut;
input IorD;
input PC_change;
input MemRead, MemWrite;
input [31:0] PC_choose;
input IRWrite;

output reg [31:0] IR;
output reg [31:0] MDR;
output reg [31:0] PC; 

reg [31:0] instr;
reg [31:0] Read_data;

reg [7:0] mem [0:49];
reg [31:0] address;

initial begin
	// AND reg1, reg2, reg3
	mem[0] = 8'h00;
	mem[1] = 8'h43;
	mem[2] = 8'h08;
	mem[3] = 8'h04;
    
	// BEQ reg4, reg5, 8
	mem[4] = 8'h04;
	mem[5] = 8'h85;
	mem[6] = 8'h00;
	mem[7] = 8'h08;
    
end

always @ (posedge clk, negedge rst_n)
begin
    if(!rst_n) PC <= 32'h00000000;
    else
        if(PC_change) PC <= PC_choose;
        else begin end

    if(IRWrite) IR <= instr;
    else begin end

    MDR <= Read_data;
end

// BIG Endianess is followed by MIPS
always @ (*) begin

    case (IorD)
        1'b0: address = PC;
        1'b1: address = ALUOut;
    endcase

    instr = {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]};    
	
end

always @(*)
begin
	if(MemWrite) {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} = Write_data;
	else begin end
    
	if(MemRead) Read_data = {mem[address], mem[address + 1], mem[address + 2], mem[address + 3]} ;
	else begin end
    
end

endmodule

