module Control
(
    input  [6:0] opcode,
    output reg       RegWrite,
    output reg [2:0] ALUCtrl
);

// Since branch and load/store instructions are not required for this assignment, you may omit
// components that are not needed

// branch (dont need to implement)
// MemoryRead
// MemtoReg
// ALUOp
// MemoryWrite
// ALUSrc
// RegWrite

// Control logic
always @(*) begin
    case (opcode)
        7'b0110011: begin // R-type
            RegWrite = 1;
            ALUCtrl  = 3'b000; // Default to add, will be overridden by ALU Control
        end
        7'b0010011: begin // I-type (addi, xori, ori, andi)
            RegWrite = 1;
            ALUCtrl  = 3'b000; // Default to addi, will be overridden by ALU Control
        end
        default: begin
            RegWrite = 0;
            ALUCtrl  = 3'b000;
        end
    endcase
end

endmodule