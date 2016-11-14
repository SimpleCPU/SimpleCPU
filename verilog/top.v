// Top module connecting all the other modules

module top
    (
        input   wire    clk,
        input   wire    reset
    );
    
    wire[31:0]  instr_top;
    wire        wr_en_imem_top;
    wire[31:0]  curr_pc_top;
    wire[31:0]  wr_instr_imem_top;
    wire[31:0]  next_pc_top;
    wire[4:0]   rt_top;
    wire[4:0]   rs_top;
    wire[4:0]   rd_top;
    wire[5:0]   op_top;
    wire[5:0]   funct_top;
    wire[25:0]  target_top;
    wire[31:0]  sign_imm_top;

    pc_reg PC (
        .clk (clk),
        .reset (reset),
        .next_pc_pc_reg_i (next_pc_top),
        .next_pc_pc_reg_o (curr_pc_top)
    );

    instr_mem I1 (
        .clk (clk),
        .addr_imem_ram_i (curr_pc_top),
        .wr_instr_imem_ram_i (wr_instr_imem_top),
        .wr_en_imem_ram_i (wr_en_imem_top),
        .read_instr_imem_ram_o (instr_top)
    );

    decode D1 (
        .instr_dec_i (instr_top),
        .rt_dec_o (rt_top),
        .rs_dec_o (rs_top),
        .rd_dec_o (rd_top),
        .op_dec_o (op_top),
        .funct_dec_o (funct_top),
        .target_dec_o (target_top),
        .sign_imm_dec_o (sign_imm_top)
    );

    regfile R1 (
        .clk (clk),
        .reset (reset),
        .w_en_rf_i (),
        .w_data_rf_i (),
        .w_addr_rf_i (),
        .r_addr_p1_rf_i (),
        .r_addr_p2_rf_i (),
        .r_data_p1_rf_o (),
        .r_data_p2_rf_o ()
    );

endmodule
