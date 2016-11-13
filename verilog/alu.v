// ALU implementation
`include "verilog/mips_alu_defines.v"

module alu
    (
        input   wire[31:0]  opr_a_alu_i,
        input   wire[31:0]  opr_b_alu_i,
        input   wire[4:0]   op_alu_i,
        output  wire[31:0]  res_alu_o,
        output  wire        z_alu_o
    );

    reg[31:0]  res_alu;
    reg        z_alu;

    wire[31:0] opr_b_negated_alu;
    wire       cin_alu;
    wire[31:0] adder_out_alu;
    wire       carry_out_alu;
    wire[31:0] logical_out_alu;
    wire[31:0] shifter_out_alu;

    assign  res_alu_o           = res_alu;
    assign  z_alu_o             = z_alu;
    assign  opr_b_negated_alu   = op_alu_i[0] ? ~opr_b_alu_i : opr_b_alu_i;
    assign  cin_alu             = op_alu_i[0] ? 1'b1 : 1'b0;

    always @ *
    case (op_alu_i)
        `ADD_OP,
        `SUB_OP : res_alu = adder_out_alu;
        `SHL_OP,
        `LSR_OP,
        `ASR_OP : res_alu = shifter_out_alu;
        `OR_OP,
        `AND_OP,
        `NOR_OP,
        `XOR_OP : res_alu = logical_out_alu;
    endcase

    adder A1 (
        .op1 (opr_a_alu_i), 
        .op2 (opr_b_negated_alu), 
        .cin (cin_alu), 
        .sum (adder_out_alu), 
        .carry (carry_out_alu)
    );

    shifter S1 (
        .op1 (opr_a_alu_i),
        .shamt (opr_b_alu_i[5:0]),
        .operation (op_alu_i[2:1]),
        .res (shifter_out_alu)
    );

    logical L1 (
        .op1 (opr_a_alu_i),
        .op2 (opr_b_alu_i),
        .operation (op_alu_i[4:3]),
        .res (logical_out_alu)
    );

endmodule
