// ALU implementation
`include "verilog/mips_alu_defines.v"

module alu
    (
        input   wire[31:0]  opr_a_alu_i,
        input   wire[31:0]  opr_b_alu_i,
        input   wire[3:0]   op_alu_i,
        output  wire[31:0]  res_alu_o,
        output  wire        z_alu_o
    );

    reg[31:0]  res_alu;
    reg        z_alu;

    assign  res_alu_o = res_alu;
    assign  z_alu_o   = z_alu;

    always @ *
    case (op_alu_i)
        `ADD :
        `SUB :
        `SHL :
        `LSR :
        `ASR :
        `OR  :
        `AND :
        `NOR :
        `XOR :
    endcase

endmodule
