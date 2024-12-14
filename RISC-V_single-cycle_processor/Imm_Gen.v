module Imm_Gen
(
    input  [31:0] instr_i,
    output reg [63:0] imm_o
);

always @(*) begin
    case (instr_i[6:0])
        7'b0010011: begin // I-type instructions
            imm_o = {{52{instr_i[31]}}, instr_i[31:20]}; // Sign-extend 12-bit immediate
        end
        default: begin
            imm_o = 64'b0;
        end
    endcase
end

endmodule