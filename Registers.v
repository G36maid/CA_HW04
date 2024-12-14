module Registers
( // Do not modify port names
    input         clk_i,
    input         rst_i,
    input  [4:0]  RS1addr_i,
    input  [4:0]  RS2addr_i,
    input  [4:0]  RDaddr_i,
    input  [63:0] RDdata_i,
    input         RegWrite_i,
    output [63:0] RS1data_o, 
    output [63:0] RS2data_o
);

// Store the content of registers here.
// Do not change the name.
reg signed [63:0] register [0:31];

// TODO: Implement your register file here.
// All registers should be reset to 0 when rst_i is high.
// Make sure that register[0] is always 0.

endmodule 
