// Top module connecting all the other modules

module top
    (
        input   wire    clk,
        input   wire    reset
    );
    
    wire[31:0]  next_pc_fetch_iss;
    wire[31:0]  next_cal_pc_fetch_iss;
    wire[31:0]  next_pred_pc_fetch_iss;
    wire[31:0]  curr_pc_pc_reg_fetch;
    wire[31:0]  next_seq_pc_pc_reg_fetch;
    wire        next_seq_pc_carry_pc_reg_fetch;
    wire[31:0]  instr_pc_reg_fetch;
    wire        brn_pred_fetch_iss;

    wire[31:0]  next_seq_pc_iss_ex;
    wire[31:0]  next_brn_eq_pc_iss_ex;
    wire        next_brn_eq_pc_carry_iss_ex;
    wire[31:0]  next_jmp_pc_iss_ex;
    wire        brn_pred_iss_ex;

    wire[31:0]  instr_iss_ex;
    wire        sign_ext_iss;
    wire[4:0]   rt_iss_ex; 
    wire[4:0]   rs_iss_ex; 
    wire[4:0]   rd_iss_ex; 
    wire[5:0]   op_iss_ex; 
    wire[5:0]   funct_iss_ex;
    wire[5:0]   shamt_iss_ex;
    wire[25:0]  target_iss_ex;
    wire[31:0]  sign_imm_iss_ex;
    wire        is_r_type_iss_ex;
    wire        is_i_type_iss_ex;
    wire        is_j_type_iss_ex;
    wire[4:0]   rs_dec_iss_ex; 
    wire[4:0]   rd_dec_iss_ex; 
    wire        reg_src_iss_ex;
    wire        reg_dst_iss_ex;
    wire        jump_iss_ex;
    wire        branch_iss_ex;
    wire        mem_read_iss_ex;
    wire        mem_to_reg_iss_ex;
    wire[5:0]   alu_op_iss_ex;
    wire        mem_wr_iss_ex;
    wire[2:0]   alu_src_iss_ex;
    wire        reg_wr_iss_ex;
    wire        sign_ext_iss_ex;
    wire[31:0]  r_data_p1_rf_iss_ex;
    wire[31:0]  r_data_p2_rf_iss_ex;
    wire[31:0]  curr_pc_iss_ex;
    wire[5:0]   op_ex_mem;
    wire        jump_ex_mem;
    wire        branch_ex_mem;
    wire        branch_taken_ex_mem;
    wire        brn_pred_ex_mem;
    wire        brn_fdback_ex_mem;
    wire        reg_wr_ex_mem;
    wire        mem_to_reg_ex_pipe_reg;
    wire        mem_wr_ex_mem;
    wire[5:0]   alu_op_ex_mem;
    wire[2:0]   alu_src_ex_mem;
    wire        reg_dst_ex_mem;
    wire[4:0]   rt_ex_mem;
    wire[4:0]   rs_ex_mem;
    wire[4:0]   rd_ex_mem;
    wire[31:0]  r_data_p1_rf_ex_mem;
    wire[31:0]  r_data_p2_rf_ex_mem;
    wire[31:0]  r_data_p2_ex_mem;
    wire[31:0]  next_brn_eq_pc_ex_mem;
    wire[31:0]  sign_imm_ex_mem;
    wire[31:0]  r_data_p1_alu_ex_mem;
    wire[31:0]  r_data_p2_alu_ex_mem;
    wire[31:0]  res_alu_ex_mem;
    wire        z_ex_mem;
    wire        n_ex_mem;
    wire[5:0]   shamt_ex_mem;
    wire[31:0]  curr_pc_ex_mem;
    wire        reg_wr_mem_wb;
    wire        mem_to_reg_mem_wb;
    wire        mem_wr_mem_wb;
    wire[4:0]   rd_mem_wb;
    wire[31:0]  res_alu_mem_wb;
    wire[31:0]  read_data_dmem_ram_mem_wb;
    wire[31:0]  r_data_p2_mem_wb;
    wire        reg_wr_wb_ret;
    wire        mem_to_reg_wb_ret;
    wire[4:0]   rd_wb_ret;
    wire[31:0]  res_alu_wb_ret;
    wire[31:0]  read_data_wb_ret;
    wire[31:0]  wr_data_rf_wb_ret;
    wire[1:0]   fwd_r_data_p1_alu_ex;
    wire[1:0]   fwd_r_data_p2_alu_ex;
    wire        stall_iss;
    wire        stall_fetch;
    wire        flush_ex;
    wire        flush_iss;
    wire        instr_retired;
    wire        valid_iss_ex;
    wire        valid_ex_mem;
    wire        valid_mem_wb;
    wire        valid_wb_ret;

    // FETCH STAGE
    fetch_pipe_reg FETCH_REG (
        .clk (clk),
        .reset (reset),
        .enable (stall_fetch),
        .next_pc_pc_reg_i (next_pc_fetch_iss),
        .next_pc_pc_reg_o (curr_pc_pc_reg_fetch)
    );

    instr_mem I_MEM1 (
        .clk (clk),
        .addr_imem_ram_i (curr_pc_pc_reg_fetch),
        .wr_instr_imem_ram_i (),
        .wr_en_imem_ram_i (wr_en_imem_top),
        .read_instr_imem_ram_o (instr_pc_reg_fetch)
    );

    adder ADD1 (
        .op1 (curr_pc_pc_reg_fetch),
        .op2 (32'h4),
        .cin (1'b0),
        .sum (next_seq_pc_pc_reg_fetch),
        .carry (next_seq_pc_carry_pc_reg_fetch)
    );
    
    one_level_bpred #(1024) BPRED (
        .clk (clk),
        .reset (reset),
        .brn_addr_bpred_i (curr_pc_pc_reg_fetch[9:0]),
        .brn_ex_mem_bpred_i (branch_ex_mem),
        .brn_fdback_addr_bpred_i (curr_pc_ex_mem[9:0]),
        .brn_fdback_bpred_i (brn_fdback_ex_mem),
        .brn_btb_addr_bpred_i (next_brn_eq_pc_ex_mem),
        .brn_takeness_bpred_o (brn_pred_fetch_iss),
        .brn_target_addr_bpred_o (next_pred_pc_fetch_iss)
    );

    assign next_cal_pc_fetch_iss    = jump_iss_ex ? next_jmp_pc_iss_ex : 
                                      (branch_taken_ex_mem & ~brn_pred_ex_mem) ? next_brn_eq_pc_ex_mem : 
                                      next_seq_pc_pc_reg_fetch;
    assign next_pred_pc_fetch_iss   = brn_pred_fetch_iss ? next_pred_pc_fetch_iss : next_cal_pc_fetch_iss;

    // ISSUE STAGE
    iss_pipe_reg FETCH_ISS_REG (
        .clk (clk),
        .reset (reset),
        .enable (stall_iss),
        .clr (flush_iss),
        .next_pc_iss_pipe_reg_i (next_seq_pc_pc_reg_fetch),
        .instr_iss_pipe_reg_i (instr_pc_reg_fetch),
        .brn_pred_iss_pipe_reg_i (brn_pred_fetch_iss),
        .curr_pc_iss_pipe_reg_i (curr_pc_pc_reg_fetch),
        .next_pc_iss_pipe_reg_o (next_seq_pc_iss_ex),
        .instr_iss_pipe_reg_o (instr_iss_ex),
        .brn_pred_iss_pipe_reg_o (brn_pred_iss_ex),
        .curr_pc_iss_pipe_reg_o (curr_pc_iss_ex)
    );

    decode D1 (
        .instr_dec_i (instr_iss_ex),
        .sign_ext_i (sign_ext_iss_ex),
        .rt_dec_o (rt_iss_ex),
        .rs_dec_o (rs_dec_iss_ex),
        .rd_dec_o (rd_dec_iss_ex),
        .op_dec_o (op_iss_ex),
        .funct_dec_o (funct_iss_ex),
        .shamt_dec_o (shamt_iss_ex),
        .target_dec_o (target_iss_ex),
        .sign_imm_dec_o (sign_imm_iss_ex),
        .is_r_type_dec_o (is_r_type_iss_ex),
        .is_i_type_dec_o (is_i_type_iss_ex),
        .is_j_type_dec_o (is_j_type_iss_ex)
    );
    assign rd_iss_ex        = reg_dst_iss_ex ? rd_dec_iss_ex : rt_iss_ex;
    assign rs_iss_ex        = reg_src_iss_ex ? rt_iss_ex     : rs_dec_iss_ex;
    assign valid_iss_ex     = (is_r_type_iss_ex | is_i_type_iss_ex | is_j_type_iss_ex) & ~reset; 

    control C1 (
        .instr_op_ctl_i (op_iss_ex),
        .instr_funct_ctl_i (funct_iss_ex),
        .reg_src_ctl_o (reg_src_iss_ex),
        .reg_dst_ctl_o (reg_dst_iss_ex),
        .jump_ctl_o (jump_iss_ex),
        .branch_ctl_o (branch_iss_ex),
        .mem_read_ctl_o (mem_read_iss_ex),
        .mem_to_reg_ctl_o (mem_to_reg_iss_ex),
        .alu_op_ctl_o (alu_op_iss_ex),
        .mem_wr_ctl_o (mem_wr_iss_ex),
        .alu_src_ctl_o (alu_src_iss_ex),
        .reg_wr_ctl_o (reg_wr_iss_ex),
        .sign_ext_ctl_o (sign_ext_iss_ex)
    );

    adder ADD2 (
        .op1 (next_seq_pc_iss_ex),
        .op2 (sign_imm_iss_ex << 2),
        .cin (1'b0),
        .sum (next_brn_eq_pc_iss_ex),
        .carry (next_brn_eq_pc_carry_iss_ex)
    );

    regfile R1 (
        .clk (clk),
        .reset (reset),
        .w_en_rf_i (reg_wr_wb_ret),
        .w_data_rf_i (wr_data_rf_wb_ret),
        .w_reg_rf_i (rd_wb_ret),
        .r_reg_p1_rf_i (rs_iss_ex),
        .r_reg_p2_rf_i (rt_iss_ex),
        .r_data_p1_rf_o (r_data_p1_rf_iss_ex),
        .r_data_p2_rf_o (r_data_p2_rf_iss_ex)
    );
    
    assign next_jmp_pc_iss_ex = {next_seq_pc_iss_ex[31:28], instr_iss_ex[25:0] << 2};

    // EXECUTE STAGE
    ex_pipe_reg ISS_EX_REG (
        .clk (clk),
        .reset (reset),
        .clr (flush_ex),
        .valid_ex_pipe_reg_i (valid_iss_ex),
        .op_ex_pipe_reg_i (op_iss_ex),
        .jump_ex_pipe_reg_i (jump_iss_ex),
        .branch_ex_pipe_reg_i (branch_iss_ex),
        .reg_wr_ex_pipe_reg_i (reg_wr_iss_ex),
        .mem_to_reg_ex_pipe_reg_i (mem_to_reg_iss_ex),
        .mem_wr_ex_pipe_reg_i (mem_wr_iss_ex),
        .alu_op_ex_pipe_reg_i (alu_op_iss_ex),
        .alu_src_ex_pipe_reg_i (alu_src_iss_ex),
        .reg_dst_ex_pipe_reg_i (reg_dst_iss_ex),
        .rt_ex_pipe_reg_i (rt_iss_ex),
        .rs_ex_pipe_reg_i (rs_iss_ex),
        .rd_ex_pipe_reg_i (rd_iss_ex),
        .r_data_p1_ex_pipe_reg_i (r_data_p1_rf_iss_ex),
        .r_data_p2_ex_pipe_reg_i (r_data_p2_rf_iss_ex),
        .brn_eq_pc_ex_pipe_reg_i (next_brn_eq_pc_iss_ex),
        .sign_imm_ex_pipe_reg_i (sign_imm_iss_ex),
        .shamt_ex_pipe_reg_i (shamt_iss_ex),
        .brn_pred_ex_pipe_reg_i (brn_pred_iss_ex),
        .curr_pc_ex_pipe_reg_i (curr_pc_iss_ex),
        .valid_ex_pipe_reg_o (valid_ex_mem),
        .op_ex_pipe_reg_o (op_ex_mem),
        .jump_ex_pipe_reg_o (jump_ex_mem),
        .branch_ex_pipe_reg_o (branch_ex_mem),
        .reg_wr_ex_pipe_reg_o (reg_wr_ex_mem),
        .mem_to_reg_ex_pipe_reg_o (mem_to_reg_ex_mem),
        .mem_wr_ex_pipe_reg_o (mem_wr_ex_mem),
        .alu_op_ex_pipe_reg_o (alu_op_ex_mem),
        .alu_src_ex_pipe_reg_o (alu_src_ex_mem),
        .reg_dst_ex_pipe_reg_o (reg_dst_ex_mem),
        .rt_ex_pipe_reg_o (rt_ex_mem),
        .rs_ex_pipe_reg_o (rs_ex_mem),
        .rd_ex_pipe_reg_o (rd_ex_mem),
        .r_data_p1_ex_pipe_reg_o (r_data_p1_rf_ex_mem),
        .r_data_p2_ex_pipe_reg_o (r_data_p2_rf_ex_mem),
        .brn_eq_pc_ex_pipe_reg_o (next_brn_eq_pc_ex_mem),
        .sign_imm_ex_pipe_reg_o (sign_imm_ex_mem),
        .shamt_ex_pipe_reg_o (shamt_ex_mem),
        .brn_pred_ex_pipe_reg_o (brn_pred_ex_mem),
        .curr_pc_ex_pipe_reg_o (curr_pc_ex_mem)
    );

    assign r_data_p1_alu_ex_mem = fwd_r_data_p1_alu_ex[1] ? res_alu_mem_wb :
                                  fwd_r_data_p1_alu_ex[0] ? wr_data_rf_wb_ret :
                                  r_data_p1_rf_ex_mem;
    assign r_data_p2_ex_mem     = fwd_r_data_p2_alu_ex[1] ? res_alu_mem_wb :
                                  fwd_r_data_p2_alu_ex[0] ? wr_data_rf_wb_ret :
                                  r_data_p2_rf_ex_mem;
    
    assign r_data_p2_alu_ex_mem = alu_src_ex_mem[2] ? 32'h0 :
                                  alu_src_ex_mem[1] ? {{27{1'b0}}, shamt_ex_mem} : 
                                  alu_src_ex_mem[0] ? sign_imm_ex_mem : r_data_p2_ex_mem;


    assign branch_taken_ex_mem  = (branch_ex_mem & ((op_ex_mem == `BEQ))  & z_ex_mem) |
                                  (branch_ex_mem & ((op_ex_mem == `BVAR)  & ((rt_ex_mem == `BGEZ)| 
                                                    (rt_ex_mem == `BGEZAL))) & (~n_ex_mem | z_ex_mem)) |
                                  (branch_ex_mem & ((op_ex_mem == `BLEZ)) & (n_ex_mem  | z_ex_mem)) |
                                  (branch_ex_mem & ((op_ex_mem == `BGTZ)) & ~(n_ex_mem | z_ex_mem)) |
                                  (branch_ex_mem & ((op_ex_mem == `BVAR)  & ((rt_ex_mem == `BLTZ) | 
                                                    (rt_ex_mem == `BLTZAL))) & (n_ex_mem & ~z_ex_mem))|
                                  (branch_ex_mem & ((op_ex_mem == `BNE))  & ~z_ex_mem);
                                
    assign brn_fdback_ex_mem    = brn_pred_ex_mem & branch_taken_ex_mem;

    alu A1 (
        .opr_a_alu_i (r_data_p1_alu_ex_mem),
        .opr_b_alu_i (r_data_p2_alu_ex_mem),
        .op_alu_i (alu_op_ex_mem),
        .res_alu_o (res_alu_ex_mem),
        .z_alu_o (z_ex_mem),
        .n_alu_o (n_ex_mem)
    );

    // MEMORY STAGE
    mem_pipe_reg EX_MEM_REG (
        .clk (clk),
        .reset (reset),
        .clr (),
        .valid_mem_pipe_reg_i (valid_ex_mem),
        .reg_wr_mem_pipe_reg_i (reg_wr_ex_mem),
        .mem_to_reg_mem_pipe_reg_i (mem_to_reg_ex_mem),
        .mem_wr_mem_pipe_reg_i (mem_wr_ex_mem),
        .rd_mem_pipe_reg_i (rd_ex_mem),
        .res_alu_mem_pipe_reg_i (res_alu_ex_mem),
        .r_data_p2_mem_pipe_reg_i (r_data_p2_ex_mem),
        .valid_mem_pipe_reg_o (valid_mem_wb),
        .reg_wr_mem_pipe_reg_o (reg_wr_mem_wb),
        .mem_to_reg_mem_pipe_reg_o (mem_to_reg_mem_wb),
        .mem_wr_mem_pipe_reg_o (mem_wr_mem_wb),
        .rd_mem_pipe_reg_o (rd_mem_wb),
        .res_alu_mem_pipe_reg_o (res_alu_mem_wb),
        .r_data_p2_mem_pipe_reg_o (r_data_p2_mem_wb)
    );

    data_mem D_MEM1 (
        .clk (clk),
        .addr_dmem_ram_i (res_alu_mem_wb),
        .wr_data_dmem_ram_i (r_data_p2_mem_wb),
        .wr_strb_dmem_ram_i (4'hF),
        .wr_en_dmem_ram_i (mem_wr_mem_wb),
        .read_data_dmem_ram_o (read_data_dmem_ram_mem_wb)
    );

    // WRITEBACK STAGE
    wb_pipe_reg MEM_WB_REG (
        .clk (clk),
        .reset (reset),
        .reg_wr_wb_pipe_reg_i (reg_wr_mem_wb),
        .valid_wb_pipe_reg_i (valid_mem_wb),
        .mem_to_reg_wb_pipe_reg_i (mem_to_reg_mem_wb),
        .rd_wb_pipe_reg_i (rd_mem_wb),
        .res_alu_wb_pipe_reg_i (res_alu_mem_wb),
        .read_data_wb_pipe_reg_i (read_data_dmem_ram_mem_wb),
        .instr_retired_wb_pipe_reg_o(valid_wb_ret),
        .reg_wr_wb_pipe_reg_o (reg_wr_wb_ret),
        .mem_to_reg_wb_pipe_reg_o (mem_to_reg_wb_ret),
        .rd_wb_pipe_reg_o (rd_wb_ret),
        .res_alu_wb_pipe_reg_o (res_alu_wb_ret),
        .read_data_wb_pipe_reg_o (read_data_wb_ret)
    );

    assign instr_retired     = valid_wb_ret;
    assign wr_data_rf_wb_ret = (|rd_wb_ret) ? 
                               (mem_to_reg_wb_ret ? read_data_wb_ret : res_alu_wb_ret) :
                               32'h0;

    hazard_unit hazard (
        .rs_ex_mem_hz_i (rs_ex_mem),
        .rt_ex_mem_hz_i (rt_ex_mem),
        .rd_mem_wb_hz_i (rd_mem_wb),
        .rd_wb_ret_hz_i (rd_wb_ret),
        .mem_to_reg_ex_mem_hz_i (mem_to_reg_ex_mem),
        .reg_wr_mem_wb_hz_i (reg_wr_mem_wb),
        .reg_wr_wb_ret_hz_i (reg_wr_wb_ret),
        .branch_taken_ex_mem_hz_i (branch_taken_ex_mem),
        .jump_iss_ex_hz_i (jump_iss_ex),
        .brn_pred_ex_mem_hz_i (brn_pred_ex_mem),
        .stall_fetch_hz_o (stall_fetch),
        .stall_iss_hz_o (stall_iss),
        .flush_ex_hz_o (flush_ex),
        .flush_iss_hz_o (flush_iss),
        .fwd_p1_ex_mem_hz_o (fwd_r_data_p1_alu_ex),
        .fwd_p2_ex_mem_hz_o (fwd_r_data_p2_alu_ex)
    );

endmodule
