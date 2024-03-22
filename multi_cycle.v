
module multi_cycle (clk, rst_n);

input clk;
input rst_n;

wire [31:0]instruction;
wire PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUSrcA, RegDst, RegWrite;
wire [1:0] ALUOp, ALUSrcB;
wire zero;
wire [4:0] write_reg;
wire [31:0] A, B, write_data, ALU_in1, ALU_in2, ALUOut, PC_choose, MDR, PC, ALU_result, snex;
wire [31:0] IR;

assign snex = {instruction[15],instruction[15],instruction[15],instruction[15],instruction[15],instruction[15],instruction[15] ,instruction[15] ,  instruction[15] ,instruction[15] ,instruction[15] ,instruction[15] ,instruction[15] ,instruction[15] ,instruction[15] ,instruction[15] ,instruction[15:0]};

wire [31:0] shift;
assign shift = snex<<2;

wire PC_change;
assign PC_change = (Zero & PCWriteCond) | PCWrite;

control C (.opcode(instruction[31:26]), .clk(clk), .rst_n(rst_n), .PCWriteCond(PCWriteCond), .PCWrite(PCWrite), .IorD(IorD), .MemRead(MemRead), .MemWrite(MemWrite), .MemtoReg(MemtoReg), .IRWrite(IRWrite), .PCSource(PCSource), .ALUOp(ALUOp), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .RegDst(RegDst), .RegWrite(RegWrite));
mem I (.clk(clk), .rst_n(rst_n), .Write_data(B), .ALUOut(ALUOut), .IorD(IorD), .MemRead(MemRead), .MemWrite(MemWrite), .PC_change(PC_change), .PC_choose(PC_choose), .IRWrite(IRWrite), .IR(instruction), .MDR(MDR), .PC(PC));
MUX_2to1_5 M1 (.i0(instruction[20:16]), .i1(instruction[15:11]), .sel(RegDst), .out(write_reg));
MUX_2to1_32 M2 (.i0(ALUOut), .i1(MDR), .sel(MemtoReg), .out(write_data));
RegisterFile R1 (.rs(instruction[25:21]), .rt(instruction[20:16]), .rd(write_reg), .RegWrite(RegWrite), .write_data(write_data), .clk(clk), .A(A), .B(B));
MUX_2to1_32 M3 (.i0(PC), .i1(A), .sel(ALUSrcA), .out(ALU_in1));
MUX_4to1_32 M4 (.i0(B), .i1(4), .i2(snex), .i3(shift), .sel(ALUSrcB), .out(ALU_in2));
ALU_Top A1 (.clk(clk), .ALUOp(ALUOp), .F(instruction[5:0]), .in_1(ALU_in1), .in_2(ALU_in2), .ALUOut(ALUOut), .Zero(Zero), .ALU_result(ALU_result));
MUX_2to1_32 M5 (.i0(ALU_result), .i1(ALUOut), .sel(PCSource), .out(PC_choose));

endmodule
