module Control
(
    input  [6:0] opcode,
    output reg       RegWrite,
    output reg [1:0] ALUOp
);

always @(*) begin
    case (opcode)
        7'b0110011: begin // R-type
            RegWrite = 1;
            ALUOp    = 2'b10;
        end
        7'b0010011: begin // I-type (addi, xori, ori, andi)
            RegWrite = 1;
            ALUOp    = 2'b00;
        end
        default: begin
            RegWrite = 0;
            ALUOp    = 2'b00;
        end
    endcase
end

endmodule