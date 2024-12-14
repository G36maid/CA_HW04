module Control
(
    input  [6:0] opcode,
    output reg       RegWrite,
    output reg [1:0] ALUOp,
    output reg       ALUSrc
);

always @(*) begin
    case (opcode)
        7'b0110011: begin // R-type (add, sub, and, or, xor, sll, srl, sra)
            RegWrite = 1;
            ALUSrc  = 0;
            ALUOp    = 2'b10;
        end
        7'b0010011: begin // I-type (addi, xori, ori, andi, slli, srli, srai)
            RegWrite = 1;
            ALUSrc  = 1;
            ALUOp    = 2'b00;
        end
        default: begin 
            RegWrite = 0;
            ALUOp    = 2'b00;
        end
    endcase
end

endmodule