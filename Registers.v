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


// TODO: Implement your register file here.
// All registers should be reset to 0 when rst_i is high.
// Make sure that register[0] is always 0.

reg signed [63:0] register [0:31];
integer i; // Loop variable

// Read data
assign RS1data_o = register[RS1addr_i];
assign RS2data_o = register[RS2addr_i];

// Write data
always @(negedge clk_i or negedge rst_i) begin
    if (rst_i) begin
        for (i = 0; i < 32; i = i + 1)
            register[i] <= 64'b0; // Reset all registers to 0
    end
    else if (RegWrite_i && RDaddr_i != 5'b0) begin
        register[RDaddr_i] <= RDdata_i; // Write data to register, except register[0]
    end
end

// Ensure register[0] is always 0
always @(negedge clk_i) begin
    register[0] <= 64'b0;
end

endmodule 
