module sign_extnd_12bit
    (
        input   wire[11:0]  instr_imm_i,
        output  wire[31:0]  sign_extnd_instr_imm_o
    );

    assign  sign_extnd_instr_imm_o = {{18{instr_imm_i[11]}}, instr_imm_i, 1'b0};

endmodule
