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
assign data_o = result;
assign zero_o = (result == 0);

always @(*) begin
    if (ALU_src)
        data2_i = imm_data;
    case (ALUCtrl_i)    
        3'b000: result = data1_i + data2_i; // Addition
        3'b001: result = data1_i - data2_i; // Subtraction
        3'b010: result = data1_i & data2_i; // Bitwise AND
        3'b011: result = data1_i | data2_i; // Bitwise OR
        3'b100: result = data1_i ^ data2_i; // Bitwise XOR
        3'b101: result = data1_i << data2_i[5:0]; // Left Shift
        3'b110: result = $signed(data1_i) >>> data2_i[5:0]; // Arithmetic Right Shift
        3'b111: result = data1_i >> data2_i[5:0]; // Logical Right Shift
        default: result = 64'b0;
    endcase
end

endmodule