module u_type_sign_extnd
    (
        input   wire[19:0]  instr_imm_i,
        output  wire[31:0]  sign_extnd_instr_imm_o
    );

    assign  sign_extnd_instr_imm_o = {{12{instr_imm_i[19]}}, instr_imm_i};

endmodule
