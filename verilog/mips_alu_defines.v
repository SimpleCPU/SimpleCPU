// Declare all the ALU related defines here
// ALU select signal decoding
`define ADD_OP     5'bxx_xx_0
`define SUB_OP     5'bxx_xx_1
`define SHL_OP     5'bxx_00_x
`define LSR_OP     5'bxx_01_x
`define ASR_OP     5'bxx_10_x
`define OR_OP      5'b00_xx_x
`define AND_OP     5'b01_xx_x
`define NOR_OP     5'b10_xx_x
`define XOR_OP     5'b11_xx_x
