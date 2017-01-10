// Top module connecting all the other modules

module top
    (
        input   wire    clk,
        input   wire    reset
    );
    
    wire[31:0]  instr_top;
    wire        wr_en_imem_top;
    wire[31:0]  curr_pc_top;
    wire[31:0]  next_pc_top;
    wire[31:0]  next_seq_pc_top;
    wire[31:0]  next_beq_pc_top;
    wire        next_seq_pc_carry_top;
    wire        next_beq_pc_carry_top;
    wire[31:0]  next_brn_eq_pc_top;
    wire[31:0]  next_jmp_pc_top;
    wire[31:0]  wr_instr_imem_top;
    wire[4:0]   rt_top;
    wire[4:0]   rs_top;
    wire[4:0]   rd_top;
    wire[4:0]   rd_dec_top;
    wire[5:0]   op_top;
    wire[5:0]   funct_top;
    wire[25:0]  target_top;
    wire[31:0]  sign_imm_top;
    wire        is_r_type_top;
    wire        is_i_type_top;
    wire        is_j_type_top;
    wire        reg_dst_top;
    wire        jump_top;
    wire        branch_top;
    wire        mem_read_top;
    wire        mem_to_reg_top;
    wire[5:0]   alu_op_top;
    wire        mem_wr_top;
    wire        alu_src_top;
    wire        reg_wr_top;
    wire        sign_ext_top;
    wire[31:0]  r_data_p1_top;
    wire[31:0]  r_data_p2_top;
    wire[31:0]  r_data_p2_rf_top;
    wire[31:0]  res_alu_top;
    wire        z_top;
    wire        n_top;
    wire[31:0]  read_data_dmem_ram_top;
    wire[31:0]  wr_data_rf_top;

    pc_reg PC (
        .clk (clk),
        .reset (reset),
        .next_pc_pc_reg_i (next_pc_top),
        .next_pc_pc_reg_o (curr_pc_top)
    );

    adder ADD1 (
        .op1 (curr_pc_top),
        .op2 (32'h4),
        .cin (1'b0),
        .sum (next_seq_pc_top),
        .carry (next_seq_pc_carry_top)
    );

    adder ADD2 (
        .op1 (next_seq_pc_top),
        .op2 (sign_imm_top << 2),
        .cin (1'b0),
        .sum (next_beq_pc_top),
        .carry (next_beq_pc_carry_top)
    );

    assign next_brn_eq_pc_top = (branch_top & z_top) ? next_beq_pc_top : next_seq_pc_top;
    assign next_jmp_pc_top = {instr_top[25:0] << 2, next_seq_pc_top[31:28]};
    assign next_pc_top = jump_top ? next_jmp_pc_top : next_brn_eq_pc_top;

    instr_mem I_MEM1 (
        .clk (clk),
        .addr_imem_ram_i (curr_pc_top),
        .wr_instr_imem_ram_i (wr_instr_imem_top),
        .wr_en_imem_ram_i (wr_en_imem_top),
        .read_instr_imem_ram_o (instr_top)
    );

    decode D1 (
        .instr_dec_i (instr_top),
        .sign_ext_i (sign_ext_top),
        .rt_dec_o (rt_top),
        .rs_dec_o (rs_top),
        .rd_dec_o (rd_dec_top),
        .op_dec_o (op_top),
        .funct_dec_o (funct_top),
        .target_dec_o (target_top),
        .sign_imm_dec_o (sign_imm_top),
        .is_r_type_dec_o (is_r_type_top),
        .is_i_type_dec_o (is_i_type_top),
        .is_j_type_dec_o (is_j_type_top)
    );

    assign rd_top = reg_dst_top ? rd_dec_top : rt_top;

    regfile R1 (
        .clk (clk),
        .reset (reset),
        .w_en_rf_i (reg_wr_top),
        .w_data_rf_i (wr_data_rf_top),
        .w_reg_rf_i (rd_top),
        .r_reg_p1_rf_i (rs_top),
        .r_reg_p2_rf_i (rt_top),
        .r_data_p1_rf_o (r_data_p1_top),
        .r_data_p2_rf_o (r_data_p2_rf_top)
    );

    assign r_data_p2_top = alu_src_top ? sign_imm_top : r_data_p2_rf_top;

    alu A1 (
        .opr_a_alu_i (r_data_p1_top),
        .opr_b_alu_i (r_data_p2_top),
        .op_alu_i (alu_op_top),
        .res_alu_o (res_alu_top),
        .z_alu_o (z_top),
        .n_alu_o (n_top)
    );

    data_mem D_MEM1 (
        .clk (clk),
        .addr_dmem_ram_i (res_alu_top),
        .wr_data_dmem_ram_i (r_data_p2_rf_top),
        .wr_strb_dmem_ram_i (4'hF),
        .wr_en_dmem_ram_i (mem_wr_top),
        .read_data_dmem_ram_o (read_data_dmem_ram_top)
    );

    assign wr_data_rf_top = mem_to_reg_top ? read_data_dmem_ram_top : res_alu_top;

    control C1 (
        .instr_op_ctl_i (op_top),
        .instr_funct_ctl_i (funct_top),
        .reg_dst_ctl_o (reg_dst_top),
        .jump_ctl_o (jump_top),
        .branch_ctl_o (branch_top),
        .mem_read_ctl_o (mem_read_top),
        .mem_to_reg_ctl_o (mem_to_reg_top),
        .alu_op_ctl_o (alu_op_top),
        .mem_wr_ctl_o (mem_wr_top),
        .alu_src_ctl_o (alu_src_top),
        .reg_wr_ctl_o (reg_wr_top),
        .sign_ext_ctl_o (sign_ext_top)
    );

endmodule
