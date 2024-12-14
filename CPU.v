module CPU
(
    input clk_i, 
    input rst_i
);

// TODO: Implement your CPU here

// Do not change the name of these module instances.


wire [63:0] pc_i;
wire [63:0] pc_o;

// PC instance
PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .pc_i       (pc_i),
    .pc_o       (pc_o)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (pc_o), 
    .instr_o    (instr)
);

// Decode instruction fields
assign rs1_addr = instr[19:15];
assign rs2_addr = instr[24:20];
assign rd_addr  = instr[11:7];

Control Control(
    .opcode     (instr[6:0]),
    .RegWrite   (reg_write),
    .ALUCtrl    (alu_ctrl)
);

// Registers instance
Registers Registers(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .RS1addr_i  (rs1_addr),
    .RS2addr_i  (rs2_addr),
    .RDaddr_i   (rd_addr), 
    .RDdata_i   (rd_data),
    .RegWrite_i (reg_write), 
    .RS1data_o  (rs1_data), 
    .RS2data_o  (rs2_data)
);
// ALU Control instance
ALU_Control ALU_Control(
    .funct7     (funct7),
    .funct3     (funct3),
    .ALUOp      (2'b10), // Example: R-type instructions
    .ALUCtrl    (alu_ctrl)
);

// ALU instance
ALU ALU(
    .data1_i    (rs1_data),
    .data2_i    (rs2_data),
    .ALUCtrl_i  (alu_ctrl),
    .data_o     (alu_result),
    .zero_o     (alu_zero)
);

endmodule
