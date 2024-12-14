module ALU_Control
(
    input      [6:0] funct7,
    input      [2:0] funct3,
    input      [1:0] ALUOp,
    output reg [2:0] ALUCtrl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUCtrl = 3'b000; // add for addi
        2'b01: ALUCtrl = 3'b001; // sub for beq
        2'b10: begin
            case (funct3)
                3'b000: ALUCtrl = (funct7[5] == 1'b1) ? 3'b001 : 3'b000; // sub : add
                3'b111: ALUCtrl = 3'b010; // and
                3'b110: ALUCtrl = 3'b011; // or
                3'b100: ALUCtrl = 3'b100; // xor
                3'b001: ALUCtrl = 3'b101; // sll
                3'b101: ALUCtrl = (funct7[5] == 1'b1) ? 3'b110 : 3'b111; // sra : srl
                default: ALUCtrl = 3'b000;
            endcase
        end
        default: ALUCtrl = 3'b000;
    endcase
end

endmodule