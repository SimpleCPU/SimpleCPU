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
        output  wire        is_j_type_dec_o
    );

    //Populate the output fields using the input instruction
    wire[4:0]   rs1_dec;
    wire[4:0]   rs2_dec;
    wire[4:0]   rd_dec;
    wire[6:0]   op_dec;
    wire[2:0]   funct3_dec;
    wire[6:0]   funct7_dec;
    wire        is_r_type_dec;
    wire        is_i_type_dec;
    wire        is_s_type_dec;
    wire        is_b_type_dec;
    wire        is_u_type_dec;
    wire        is_j_type_dec;


    assign rs1_dec_o          = rs1_dec;
    assign rs2_dec_o          = rs2_dec;
    assign rd_dec_o           = rd_dec;
    assign op_dec_o           = op_dec;
    assign funct3_dec_o       = funct3_dec;
    assign funct7_dec_o       = funct7_dec;
    assign is_r_type_dec_o    = is_r_type_dec;
    assign is_i_type_dec_o    = is_i_type_dec;
    assign is_i_type_dec_o    = is_s_type_dec;
    assign is_i_type_dec_o    = is_b_type_dec;
    assign is_i_type_dec_o    = is_u_type_dec;
    assign is_j_type_dec_o    = is_j_type_dec;

    assign rd_dec             = instr_dec_i[11:7];
    assign rs1_dec            = instr_dec_i[19:15];
    assign rs2_dec            = instr_dec_i[24:20];
    assign op_dec             = instr_dec_i[6:0];
    assign funct3_dec         = instr_dec_i[14:12];
    assign funct7_dec         = instr_dec_i[31:25];

    assign is_r_type_dec      = op_dec  == `R_TYPE;
    assign is_i_type_dec      = (op_dec == `I_TYPE_0) | (op_dec == `I_TYPE_1);
    assign is_s_type_dec      = op_dec  == `S_TYPE;
    assign is_b_type_dec      = op_dec  == `B_TYPE;
    assign is_u_type_dec      = (op_dec == `AUIPC) | (op_dec == `LUI);
    assign is_j_type_dec      = op_dec  == `J_TYPE;

endmodule
