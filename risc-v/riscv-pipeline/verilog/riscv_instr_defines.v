// Declare all the instruction related defines here
// funct3/funct7 field for all the supported instructions
// R Type
`define ADD         6'h0
`define AND         6'h7
`define OR          6'h6
`define SLL         6'h1
`define SLT         6'h2
`define SLTU        6'h3
`define SRA         6'hd
`define SRL         6'h5
`define SUB         6'h8
`define XOR         6'h4
// I Type
`define LB          6'h0
`define LBU         6'h4
`define LH          6'h1
`define LHU         6'h5
`define LW          6'h2
`define ADDI        6'h10   // Formed using {opcode[4], {1'b0,funct3}}
`define ANDI        6'h1c
`define ORI         6'h16
`define SLLI        6'h11
`define SRLI        6'h15
`define SLTI        6'h12
`define SLTIU       6'h13
`define SRAI        6'h15
`define XORI        6'h14   
`define JALR        6'h7    // Uses a different opcode field
// S Type
`define SB          6'h0
`define SH          6'h1
`define SW          6'h2
// B Type
`define BEQ         6'h0
`define BNE         6'h1
`define BLT         6'h4
`define BGE         6'h5
`define BLTU        6'h6
`define BGEU        6'h7
// U Type
`define AUIPC       6'h27   // Gives the opcode value itself
`define LUI         6'h37
// J Type
`define JAL         6'h3

`define R_TYPE      7'h33
`define I_TYPE_0    7'h03   // LW
`define I_TYPE_1    7'h13   // Data processing
`define I_TYPE_2    7'h67   // JALR
`define S_TYPE      7'h23
`define B_TYPE      7'h63
`define J_TYPE      7'h6F
