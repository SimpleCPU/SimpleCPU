//Instruction decoder
`include "verilog/riscv_instr_defines.v"

module decode 
    (
        input   wire[31:0]  instr_dec_i,
        output  wire[4:0]   rs1_dec_o,
        output  wire[4:0]   rs2_dec_o,
        output  wire[4:0]   rd_dec_o,
        output  wire[6:0]   op_dec_o,
        output  wire[2:0]   funct3_dec_o,
        output  wire[6:0]   funct7_dec_o,
        output  wire        is_r_type_dec_o,
        output  wire        is_i_type_dec_o,
        output  wire        is_s_type_dec_o,
        output  wire        is_b_type_dec_o,
        output  wire        is_u_type_dec_o,
        output  wire        is_j_type_dec_o,
        output  wire[11:0]  i_type_imm_dec_o,
        output  wire[11:0]  s_type_imm_dec_o,
        output  wire[11:0]  b_type_imm_dec_o,
        output  wire[19:0]  u_type_imm_dec_o,
        output  wire[19:0]  j_type_imm_dec_o
    );

    //Populate the output fields using the input instruction
    wire[4:0]   rs1_dec;
    wire[4:0]   rs2_dec;
    wire[4:0]   rd_dec;
    wire[6:0]   op_dec;
    wire[2:0]   funct3_dec;
    wire[6:0]   funct7_dec;
    reg         is_r_type_dec;
    reg         is_i_type_dec;
    reg         is_s_type_dec;
    reg         is_b_type_dec;
    reg         is_u_type_dec;
    reg         is_j_type_dec;
    wire[11:0]  i_type_imm_dec;
    wire[11:0]  s_type_imm_dec;
    wire[11:0]  b_type_imm_dec;
    wire[19:0]  u_type_imm_dec;
    wire[19:0]  j_type_imm_dec;


    assign rs1_dec_o          = rs1_dec;
    assign rs2_dec_o          = rs2_dec;
    assign rd_dec_o           = rd_dec;
    assign op_dec_o           = op_dec;
    assign funct3_dec_o       = funct3_dec;
    assign funct7_dec_o       = funct7_dec;
    assign is_r_type_dec_o    = is_r_type_dec;
    assign is_i_type_dec_o    = is_i_type_dec;
    assign is_s_type_dec_o    = is_s_type_dec;
    assign is_b_type_dec_o    = is_b_type_dec;
    assign is_u_type_dec_o    = is_u_type_dec;
    assign is_j_type_dec_o    = is_j_type_dec;
    assign i_type_imm_dec_o   = i_type_imm_dec;
    assign s_type_imm_dec_o   = s_type_imm_dec;
    assign b_type_imm_dec_o   = b_type_imm_dec;
    assign u_type_imm_dec_o   = u_type_imm_dec;
    assign j_type_imm_dec_o   = j_type_imm_dec;

    assign rd_dec             = instr_dec_i[11:7];
    assign rs1_dec            = instr_dec_i[19:15];
    assign rs2_dec            = instr_dec_i[24:20];
    assign op_dec             = instr_dec_i[6:0];
    assign funct3_dec         = instr_dec_i[14:12];
    assign funct7_dec         = instr_dec_i[31:25];

    always @ *
    begin
        is_r_type_dec = 1'b0;
        is_i_type_dec = 1'b0;
        is_s_type_dec = 1'b0;
        is_b_type_dec = 1'b0;
        is_u_type_dec = 1'b0;
        is_j_type_dec = 1'b0;
        case (op_dec)
            `R_TYPE:    is_r_type_dec = 1'b1;
            `I_TYPE_0,
            `I_TYPE_1:  is_i_type_dec = 1'b1;
            `S_TYPE:    is_s_type_dec = 1'b1;
            `B_TYPE:    is_b_type_dec = 1'b1;
            `AUIPC,
            `LUI:       is_u_type_dec = 1'b1;
            `J_TYPE:    is_j_type_dec = 1'b1;
        endcase
    end

    assign i_type_imm_dec     = instr_dec_i[31:20];
    assign s_type_imm_dec     = {instr_dec_i[31:25], instr_dec_i[11:7]};
    assign b_type_imm_dec     = {instr_dec_i[31], instr_dec_i[7],
                                 instr_dec_i[30:25], 
                                 instr_dec_i[11:8]};
    assign u_type_imm_dec     = instr_dec_i[31:12];
    assign j_type_imm_dec     = {instr_dec_i[31], instr_dec_i[19:12],
                                 instr_dec_i[20], instr_dec_i[30:21]};

endmodule
