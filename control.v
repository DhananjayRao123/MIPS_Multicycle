
module control (
    input [5:0] opcode,
    input clk,
    input rst_n,
    output reg PCWriteCond,
    output reg PCWrite,
    output reg IorD,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg IRWrite,
    output reg PCSource,
    output reg [1:0] ALUOp,
    output reg ALUSrcA,
    output reg [1:0] ALUSrcB,
    output reg RegDst,
    output reg RegWrite
);

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

reg [2:0] PS, NS;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        PS <= S0;
    else
        PS <= NS;
end

always @* begin
    case (PS)
        S0: begin
            MemRead <= 1'b1;
            PCWrite <= 1'b1;
            IorD <= 1'b0;
            IRWrite <= 1'b1;
            ALUSrcA <= 1'b0;
            ALUSrcB <= 2'b01;
            ALUOp <= 2'b00;
            PCSource <= 1'b0;
            PCWriteCond <= 1'b0;
            MemWrite <= 1'b0;
            MemtoReg <= 1'b0;
            RegDst <= 1'b0;
            RegWrite <= 1'b0;
            NS <= S1;
        end

        S1: begin
            PCWriteCond <= 1'b0;
            PCWrite <= 1'b0;
            IorD <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            MemtoReg <= 1'b0;
            IRWrite <= 1'b0;
            PCSource <= 1'b0;
            RegDst <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcA <= 1'b0;
            ALUSrcB <= 2'b11;
            ALUOp <= 2'b00;
            case (opcode)
                6'd0: NS <= S3;
                6'd1: NS <= S2;
                default: NS <= S0;
            endcase
        end

        S2: begin
            PCWrite <= 1'b0;
            IorD <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            MemtoReg <= 1'b0;
            IRWrite <= 1'b0;
            RegDst <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcA <= 1'b1;
            ALUSrcB <= 2'b00;
            ALUOp <= 2'b01;
            PCSource <= 1'b1;
            PCWriteCond <= 1'b1;
            NS <= S0;
        end

        S3: begin
            PCWriteCond <= 1'b0;
            PCWrite <= 1'b0;
            IorD <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            MemtoReg <= 1'b0;
            IRWrite <= 1'b0;
            PCSource <= 1'b0;
            RegDst <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrcA <= 1'b1;
            ALUSrcB <= 2'b00;
            ALUOp <= 2'b10;
            NS <= S4;
        end

        S4: begin
            PCWriteCond <= 1'b0;
            PCWrite <= 1'b0;
            IorD <= 1'b0;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            IRWrite <= 1'b0;
            PCSource <= 1'b0;
            ALUSrcA <= 1'b0;
            ALUSrcB <= 2'b00;
            ALUOp <= 2'b00;
            RegDst <= 1'b1;
            RegWrite <= 1'b1;
            MemtoReg <= 1'b0;
            NS <= S0;
        end
    endcase
end

endmodule
