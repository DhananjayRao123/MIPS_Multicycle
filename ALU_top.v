

module ALU_Top(clk, ALUOp, F, in_1,in_2, ALUOut, ALU_result, Zero);
input [5:0] F;
input clk;
input [1:0] ALUOp;
input [31:0] in_1, in_2;
output Zero;
output reg [31:0] ALUOut;

output [31:0] ALU_result;
wire [3:0] op;

always @ (posedge clk) begin
    ALUOut <= ALU_result;
end

ALU_control A1 (.ALUOp(ALUOp), .F(F), .Operation(op));
ALU_MIPS A2 (in_1,in_2, Zero, ALU_result,op);

endmodule
