// Declare all the ALU related defines here
// ALU select signal decoding
`define ADD_OP     6'b000_00_0
`define SUB_OP     6'b000_00_1
`define SHL_OP     6'b000_01_0
`define LSR_OP     6'b000_10_0
`define ASR_OP     6'b000_11_0
`define OR_OP      6'b001_00_0
`define AND_OP     6'b010_00_0
`define NOR_OP     6'b011_00_0
`define XOR_OP     6'b100_00_0
`define SLT_OP     6'b101_00_1
`define SLTU_OP    6'b110_00_1
`define BGEU_OP    6'b010_00_1
