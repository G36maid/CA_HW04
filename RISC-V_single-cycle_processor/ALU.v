module ALU (
    input  [63:0] data1_i,
    input  [63:0] data2_i,
    input         ALU_src,
    input  [63:0] imm_data,
    input  [2:0]  ALUCtrl_i,
    output [63:0] data_o,
    output        zero_o
);

reg [63:0] result;
reg [63:0] alu_operand2;
assign data_o = result;
assign zero_o = (result == 0);

// if ALU source is immediate, use imm_data as second operand
// otherwise, use data2_i as second operand
always @(*) begin
    if (ALU_src) // ALU source is immediate
        alu_operand2 = imm_data;
    else
        alu_operand2 = data2_i;
    case (ALUCtrl_i)    
        3'b000: result = data1_i + alu_operand2; // Addition
        3'b001: result = data1_i - alu_operand2; // Subtraction
        3'b010: result = data1_i & alu_operand2; // Bitwise AND
        3'b011: result = data1_i | alu_operand2; // Bitwise OR
        3'b100: result = data1_i ^ alu_operand2; // Bitwise XOR
        3'b101: result = data1_i << alu_operand2[5:0]; // Left Shift
        3'b110: result = $signed(data1_i) >>> alu_operand2[5:0]; // Arithmetic Right Shift
        3'b111: result = data1_i >> alu_operand2[5:0]; // Logical Right Shift
        default: result = 64'b0;
    endcase
end

endmodule