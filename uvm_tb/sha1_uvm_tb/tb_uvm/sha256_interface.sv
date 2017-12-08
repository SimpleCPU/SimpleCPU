`ifndef SHA256_INTERFACE_SV
`define SHA256_INTERFACE_SV
// The sha256 Interface
// The interface declares both the input and the
// output ports of the sha256 module.

interface sha256_interface (
   input  wire          clk,
   input  wire          reset
);
    logic [31:0]        text_i; 
    logic [31:0]        text_o; 
    logic [2:0]         cmd_i; 
    logic               cmd_w_i; 
    logic [3:0]         cmd_o;
    logic [255:0]       sha256_hash;

endinterface
`endif
