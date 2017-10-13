`include "verilog/riscv_instr_defines.v"

module sign_extnd_12bit
    (
        input   wire[11:0]  instr_imm_i,
        input   wire[6:0]   instr_type_i,
        output  wire[31:0]  sign_extnd_instr_imm_o
    );

    reg [31:0] sign_extnd_instr_imm;

    assign  sign_extnd_instr_imm_o = sign_extnd_instr_imm;

    always @ (instr_imm_i or instr_type_i)
    begin
        case (instr_type_i)
            `I_TYPE_0,
            `I_TYPE_1,
            `I_TYPE_2,
            `S_TYPE     : sign_extnd_instr_imm = {{20{instr_imm_i[11]}}, instr_imm_i};
            `B_TYPE     : sign_extnd_instr_imm = {{19{instr_imm_i[11]}}, instr_imm_i, 1'b0};
            default     : sign_extnd_instr_imm = {{20{instr_imm_i[11]}}, instr_imm_i};
        endcase
    end

endmodule
