// ALU implementation
`include "verilog/riscv_alu_defines.v"

module alu
    (
        input   wire[31:0]  opr_a_alu_i,
        input   wire[31:0]  opr_b_alu_i,
        input   wire[5:0]   op_alu_i,
        output  wire[31:0]  res_alu_o,
        output  wire        z_alu_o,
        output  wire        n_alu_o
    );

    wire[31:0] res_alu;
    wire       z_alu;
    wire       n_alu;
    wire       v_alu;
    wire[31:0] opr_b_negated_alu;
    wire       cin_alu;
    wire[31:0] adder_out_alu;
    wire       carry_out_alu;
    wire[31:0] logical_out_alu;
    wire[31:0] shifter_out_alu;
    wire       comparator_out_alu;

    assign  res_alu_o           = res_alu;
    assign  z_alu_o             = z_alu;
    assign  n_alu_o             = n_alu;
    assign  opr_b_negated_alu   = op_alu_i[0] ? ~opr_b_alu_i : opr_b_alu_i;
    assign  cin_alu             = op_alu_i[0];
    assign  z_alu               = ~|adder_out_alu;
    assign  n_alu               = (v_alu) ? opr_a_alu_i[31] : adder_out_alu[31];

    assign res_alu              = ((op_alu_i == `ADD_OP) || (op_alu_i == `SUB_OP)) ?   adder_out_alu :
                                  ((op_alu_i == `SHL_OP) || (op_alu_i == `LSR_OP) || (op_alu_i == `ASR_OP)) ? shifter_out_alu :
                                  ((op_alu_i == `OR_OP) || (op_alu_i == `AND_OP) || (op_alu_i == `NOR_OP) || (op_alu_i == `XOR_OP)) ? logical_out_alu :
                                  ((op_alu_i == `SLTU_OP)) ? comparator_out_alu :
                                  ((op_alu_i == `SLT_OP)) ? {{31{1'b0}}, n_alu}:
                                  32'hxxxx_xxxx;
    adder A1 (
        .op1 (opr_a_alu_i), 
        .op2 (opr_b_negated_alu), 
        .cin (cin_alu), 
        .sum (adder_out_alu), 
        .carry (carry_out_alu),
        .v_flag (v_alu)
    );

    shifter S1 (
        .op1 (opr_a_alu_i),
        .shamt (opr_b_alu_i[4:0]),
        .operation (op_alu_i[2:1]),
        .res (shifter_out_alu)
    );

    logical L1 (
        .op1 (opr_a_alu_i),
        .op2 (opr_b_alu_i),
        .operation (op_alu_i[5:3]),
        .res (logical_out_alu)
    );

    comparator C1 (
        .op1 (opr_a_alu_i),
        .op2 (opr_b_alu_i),
        .operation (op_alu_i[5:3]),
        .res (comparator_out_alu)
    );

endmodule
