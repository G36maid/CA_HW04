module CPU
(
    input clk_i, 
    input rst_i
);

// Internal signals
wire [63:0] pc_i;
wire [63:0] pc_o;
wire [31:0] instr;
wire [4:0]  rs1_addr, rs2_addr, rd_addr;
wire [63:0] rs1_data, rs2_data, rd_data;
wire [63:0] imm_data;
wire        reg_write;
wire [1:0]  alu_op;
wire [2:0]  alu_ctrl;
wire        alu_src;
wire [6:0]  funct7;
wire [2:0]  funct3;
wire [63:0] alu_result;
wire        alu_zero;
wire [6:0]  opcode;

// PC instance
PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .pc_i       (pc_i),
    .pc_o       (pc_o)
);

// Instruction Memory instance
Instruction_Memory Instruction_Memory(
    .addr_i     (pc_o), 
    .instr_o    (instr) // [31:0]
);

// Decode instruction fields
assign opcode   = instr[6:0];
assign rd_addr  = instr[11:7];
assign funct3   = instr[14:12];
assign rs1_addr = instr[19:15];
assign rs2_addr = instr[24:20];
assign funct7   = instr[31:25];


// Control instance
Control Control(
    .opcode     (opcode),
    .RegWrite   (reg_write),
    .ALUOp      (alu_op)
    .ALUSrc     (alu_src)
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

// Immediate Generator instance
Imm_Gen Imm_Gen(
    .instr_i    (instr),
    .imm_o      (imm_data)
);

// ALU Control instance
ALU_Control ALU_Control(
    .funct3     (funct3),
    .funct7     (funct7),
    .ALUOp      (alu_op),
    .ALUCtrl    (alu_ctrl)
);

// ALU instance
ALU ALU(
    .data1_i    (rs1_data),
    .data2_i    (rs2_data), //imm_data and rs2_data deside by alu_src
    .ALU_src    (alu_src),
    .imm_data   (imm_data),
    .ALUCtrl_i  (alu_ctrl),
    .data_o     (alu_result),
    .zero_o     (alu_zero)
);

// add pc_o with 4
assign pc_i = pc_o + 4;

// Write back to register
assign rd_data = alu_result;

endmodule