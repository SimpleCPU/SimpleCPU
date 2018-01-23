// Top module connecting all the other modules
`include "verilog/riscv_instr_defines.v"

module top
    (
        input   wire    clk,
        input   wire    reset
    );
    // Fetch stage signals
    wire        stall_fetch;
    wire[31:0]  curr_pc_pc_reg_fetch;
    wire[31:0]  next_pc_fetch_iss;
    wire[31:0]  next_cal_pc_fetch_iss;
    wire[31:0]  instr_pc_reg_fetch;
    wire[31:0]  next_seq_pc_pc_reg_fetch;
    wire[31:0]  next_pred_pc_fetch_iss;
    wire        next_seq_pc_carry_pc_reg_fetch;
    wire        brn_pred_fetch_iss;
    // Issue stage signals
    wire        valid_iss_ex;
    wire        stall_iss;
    wire        flush_iss;
    wire        flush_incorr_pred_iss;
    wire[31:0]  next_seq_pc_iss_ex;
    wire[31:0]  instr_iss_ex;
    wire[31:0]  curr_pc_iss_ex;
    wire[31:0]  next_pred_pc_iss_ex;
    wire        brn_pred_iss_ex;
    wire[4:0]   rs1_iss_ex;
    wire[4:0]   rs2_iss_ex;
    wire[4:0]   rd_iss_ex;
    wire[2:0]   funct3_iss_ex;
    wire[6:0]   funct7_iss_ex;
    wire[6:0]   op_iss_ex;
    wire        is_r_type_iss_ex;
    wire        is_i_type_iss_ex;
    wire        is_s_type_iss_ex;
    wire        is_b_type_iss_ex;
    wire        is_u_type_iss_ex;
    wire        is_j_type_iss_ex;
    wire[1:0]   pc_sel_iss_ex;
    wire        op1sel_iss_ex;
    wire[1:0]   op2sel_iss_ex;
    wire[1:0]   wb_sel_iss_ex;
    wire        pc4_sel_iss_ex;
    wire        mem_wr_iss_ex;
    wire        cpr_en_iss_ex;
    wire        wa_sel_iss_ex;
    wire        rf_en_iss_ex;
    wire[5:0]   alu_fn_iss_ex;
    wire[31:0]  r_data_p1_rf_iss_ex;
    wire[31:0]  r_data_p2_rf_iss_ex;
    wire[11:0]  i_type_imm_iss_ex;
    wire[11:0]  s_type_imm_iss_ex;
    wire[11:0]  b_type_imm_iss_ex;
    wire[19:0]  u_type_imm_iss_ex;
    wire[19:0]  j_type_imm_iss_ex;
    wire[11:0]  instr_imm_12bit_iss;
    wire[19:0]  instr_imm_20bit_iss;
    wire[31:0]  sign_extnd_imm_12bit_iss;
    wire[31:0]  sign_extnd_imm_20bit_iss;
    wire[31:0]  sign_extnd_imm_iss_ex;
    wire[31:0]  next_j_br_pc_iss_ex;
    wire        next_j_br_pc_carry_iss_ex;
    wire[31:0]  next_brn_pc_iss_ex;
    wire[31:0]  next_jmp_pc_iss_ex;
    wire        jump_iss_ex;
    // Execute stage signals
    wire        valid_ex_mem;
    wire        flush_ex;
    wire        flush_incorr_pred_ex;
    wire[2:0]   funct3_ex_mem;
    wire[4:0]   rs1_ex_mem;
    wire[4:0]   rs2_ex_mem;
    wire[4:0]   rd_ex_mem;
    wire[6:0]   op_ex_mem;
    wire        is_r_type_ex_mem;
    wire        is_i_type_ex_mem;
    wire        is_s_type_ex_mem;
    wire        is_b_type_ex_mem;
    wire        is_u_type_ex_mem;
    wire        is_j_type_ex_mem;
    wire        jump_ex_mem;
    wire[1:0]   pc_sel_ex_mem;
    wire        op1sel_ex_mem;
    wire[1:0]   op2sel_ex_mem;
    wire[1:0]   wb_sel_ex_mem;
    wire        pc4_sel_ex_mem;
    wire        mem_wr_ex_mem;
    wire        cpr_en_ex_mem;
    wire        wa_sel_ex_mem;
    wire[5:0]   alu_fn_ex_mem;
    wire[31:0]  next_seq_pc_ex_mem;
    wire[31:0]  curr_pc_ex_mem;
    wire[31:0]  next_pred_pc_ex_mem;
    wire        brn_pred_ex_mem;
    wire[31:0]  next_brn_pc_ex_mem;
    wire[31:0]  sign_extnd_imm_ex;
    wire[31:0]  r_data_p1_rf_ex_mem;
    wire[31:0]  r_data_p2_rf_ex_mem;
    wire[31:0]  r_data_p1_alu_ex_mem;
    wire[31:0]  r_data_p2_alu_ex_mem;
    wire[31:0]  r_data_p1_ex_mem;
    wire[31:0]  r_data_p2_ex_mem;
    wire[1:0]   fwd_r_data_p1_alu_ex;
    wire[1:0]   fwd_r_data_p2_alu_ex;
    wire        brn_corr_pred_ex_mem;
    wire        force_pc_update_ex;
    wire[31:0]  force_pc_val_ex;
    wire[31:0]  alu_res_ex_mem;
    wire        z_ex_mem;
    wire        n_ex_mem;
    wire        is_lw_ex_mem;
    wire        branch_taken_ex;
    // Memory stage signals
    wire        valid_mem_wb;
    wire        rf_en_mem_wb;
    wire[1:0]   wb_sel_mem_wb;
    wire        mem_wr_mem_wb;
    wire[4:0]   rd_mem_wb;
    wire[31:0]  alu_res_mem_wb;
    wire[31:0]  next_seq_pc_mem_wb;
    wire        is_lw_mem_wb;
    wire[31:0]  read_data_dmem_ram_mem_wb;
    wire[31:0]  r_data_p2_mem_wb;
    // Writeback stage signals
    wire        valid_wb_ret;
    wire        rf_en_wb_ret;
    wire[1:0]   wb_sel_wb_ret;
    wire[4:0]   rd_wb_ret;
    wire[31:0]  alu_res_wb_ret;
    wire[31:0]  read_data_wb_ret;
    wire[31:0]  next_seq_pc_wb_ret;
    wire        instr_retired;
    wire[31:0]  wr_data_rf_wb_ret;

    // FETCH STAGE
    fetch_pipe_reg FETCH_REG (
        .clk                (clk),
        .reset              (reset),
        .enable             (stall_fetch),
        .next_pc_pc_reg_i   (next_pc_fetch_iss),
        .next_pc_pc_reg_o   (curr_pc_pc_reg_fetch)
    );

    instr_mem I_MEM1 (
        .clk                    (clk),
        .addr_imem_ram_i        (curr_pc_pc_reg_fetch),
        .wr_instr_imem_ram_i    (),
        .wr_en_imem_ram_i       (),
        .read_instr_imem_ram_o  (instr_pc_reg_fetch)
    );

    adder ADD1 (
        .op1    (curr_pc_pc_reg_fetch),
        .op2    (32'h4),
        .cin    (1'b0),
        .sum    (next_seq_pc_pc_reg_fetch),
        .carry  (next_seq_pc_carry_pc_reg_fetch),
        .v_flag ()
    );
    
    one_level_bpred #(1024) BPRED (
        .clk                        (clk),
        .reset                      (reset),
        .brn_addr_bpred_i           (curr_pc_pc_reg_fetch[9:0]),
        .brn_ex_mem_bpred_i         (is_b_type_ex_mem),
        .brn_fdback_addr_bpred_i    (curr_pc_ex_mem[9:0]),
        .brn_fdback_bpred_i         (brn_corr_pred_ex_mem),
        .brn_btb_addr_bpred_i       (next_brn_pc_ex_mem),
        .brn_takeness_bpred_o       (brn_pred_fetch_iss),
        .brn_target_addr_bpred_o    (next_pred_pc_fetch_iss)
    );

    assign next_cal_pc_fetch_iss    = force_pc_update_ex ? force_pc_val_ex :
                                      (branch_taken_ex & ~(brn_pred_ex_mem & brn_corr_pred_ex_mem)) ? next_brn_pc_ex_mem : 
                                      jump_iss_ex ? next_jmp_pc_iss_ex :
                                      next_seq_pc_pc_reg_fetch;
    // If the branch is predicted as not taken, we should pass the next
    // sequential PC. The BTB would give predicted address as 0 even 
    // when the prediction is correct but predicted as not taken.
    // The following logic passes next sequential PC whenever the branch
    // is predicted as not taken.
    // Since jump instructions are resolved in the DECODE stage itself
    // therefore we just need to flush the next instruction in DEC stage
    // when an incorrect prediction is made. This is already handled in
    // the hazard unit. So, we would already see the correct PC being
    // fetched and there wouldn't be any need to update the PC again.
    // But if the prediction is made in the shadow of the jump/branch 
    // instruction then we need to suppress it. The jump instruction 
    // would have already been resolved and the correct PC should be used
    assign next_pc_fetch_iss        = (~jump_ex_mem & ~is_b_type_ex_mem & brn_pred_ex_mem & ~brn_corr_pred_ex_mem) ? next_seq_pc_ex_mem :
                                      (~jump_iss_ex & ~is_b_type_ex_mem & brn_pred_fetch_iss) ? next_pred_pc_fetch_iss : 
                                      next_cal_pc_fetch_iss;

    // ISSUE STAGE
    iss_pipe_reg FETCH_ISS_REG (
        .clk                            (clk),
        .reset                          (reset),
        .enable                         (stall_iss),
        .clr                            (flush_iss | flush_incorr_pred_iss),
        .next_pc_iss_pipe_reg_i         (next_seq_pc_pc_reg_fetch),
        .instr_iss_pipe_reg_i           (instr_pc_reg_fetch),
        .brn_pred_iss_pipe_reg_i        (brn_pred_fetch_iss),
        .curr_pc_iss_pipe_reg_i         (curr_pc_pc_reg_fetch),
        .next_pred_pc_iss_pipe_reg_i    (next_pred_pc_fetch_iss),
        .next_pc_iss_pipe_reg_o         (next_seq_pc_iss_ex),
        .instr_iss_pipe_reg_o           (instr_iss_ex),
        .brn_pred_iss_pipe_reg_o        (brn_pred_iss_ex),
        .curr_pc_iss_pipe_reg_o         (curr_pc_iss_ex),
        .next_pred_pc_iss_pipe_reg_o    (next_pred_pc_iss_ex)
    );

    decode D1 (
        .instr_dec_i        (instr_iss_ex),
        .rs1_dec_o          (rs1_iss_ex),
        .rs2_dec_o          (rs2_iss_ex),
        .rd_dec_o           (rd_iss_ex),
        .op_dec_o           (op_iss_ex),
        .funct3_dec_o       (funct3_iss_ex),
        .funct7_dec_o       (funct7_iss_ex),
        .is_r_type_dec_o    (is_r_type_iss_ex),
        .is_i_type_dec_o    (is_i_type_iss_ex),
        .is_s_type_dec_o    (is_s_type_iss_ex),
        .is_b_type_dec_o    (is_b_type_iss_ex),
        .is_u_type_dec_o    (is_u_type_iss_ex),
        .is_j_type_dec_o    (is_j_type_iss_ex),
        .i_type_imm_dec_o   (i_type_imm_iss_ex),
        .s_type_imm_dec_o   (s_type_imm_iss_ex),
        .b_type_imm_dec_o   (b_type_imm_iss_ex),
        .u_type_imm_dec_o   (u_type_imm_iss_ex),
        .j_type_imm_dec_o   (j_type_imm_iss_ex)
    );
    assign valid_iss_ex     = (is_r_type_iss_ex | 
                               is_i_type_iss_ex |
                               is_s_type_iss_ex |
                               is_b_type_iss_ex |
                               is_u_type_iss_ex |
                               is_j_type_iss_ex) & ~reset; 

    control C1 (
        .instr_funct3_ctl_i (funct3_iss_ex),
        .instr_funct7_ctl_i (funct7_iss_ex),
        .instr_opcode_ctl_i (op_iss_ex),
        .is_r_type_ctl_i    (is_r_type_iss_ex),
        .is_i_type_ctl_i    (is_i_type_iss_ex),
        .is_s_type_ctl_i    (is_s_type_iss_ex),
        .is_b_type_ctl_i    (is_b_type_iss_ex),
        .is_u_type_ctl_i    (is_u_type_iss_ex),
        .is_j_type_ctl_i    (is_j_type_iss_ex),
        .pc_sel_ctl_o       (pc_sel_iss_ex),
        .op1sel_ctl_o       (op1sel_iss_ex),
        .op2sel_ctl_o       (op2sel_iss_ex),
        .wb_sel_ctl_o       (wb_sel_iss_ex),
        .pc4_sel_ctl_o      (pc4_sel_iss_ex),
        .mem_wr_ctl_o       (mem_wr_iss_ex),
        .cpr_en_ctl_o       (cpr_en_iss_ex),
        .rf_en_ctl_o        (rf_en_iss_ex),
        .alu_fun_ctl_o      (alu_fn_iss_ex)
    );

    assign instr_imm_12bit_iss  = ({12{is_i_type_iss_ex}} & i_type_imm_iss_ex) |
                                  ({12{is_s_type_iss_ex}} & s_type_imm_iss_ex) |
                                  ({12{is_b_type_iss_ex}} & b_type_imm_iss_ex);

    assign instr_imm_20bit_iss  = ({20{is_u_type_iss_ex}} & u_type_imm_iss_ex) |
                                  ({20{is_j_type_iss_ex}} & j_type_imm_iss_ex);

    sign_extnd_12bit SIGN_EXTND_12BIT (
        .instr_imm_i            (instr_imm_12bit_iss),
        .instr_type_i           (op_iss_ex),
        .sign_extnd_instr_imm_o (sign_extnd_imm_12bit_iss)
    );

    sign_extnd_20bit SIGN_EXTND_20BIT (
        .instr_imm_i            (instr_imm_20bit_iss),
        .sign_extnd_instr_imm_o (sign_extnd_imm_20bit_iss)
    );

    assign sign_extnd_imm_iss_ex = is_j_type_iss_ex ? sign_extnd_imm_20bit_iss :
                                   is_u_type_iss_ex ? {instr_imm_20bit_iss, 12'b0} :
                                                      sign_extnd_imm_12bit_iss;

    adder ADD2 (
        .op1    (curr_pc_iss_ex),
        .op2    (sign_extnd_imm_iss_ex),
        .cin    (1'b0),
        .sum    (next_j_br_pc_iss_ex),
        .carry  (next_j_br_pc_carry_iss_ex),
        .v_flag ()
    );

    regfile R1 (
        .clk            (clk),
        .reset          (reset),
        .w_en_rf_i      (rf_en_wb_ret),
        .w_data_rf_i    (wr_data_rf_wb_ret),
        .w_reg_rf_i     (rd_wb_ret),
        .r_reg_p1_rf_i  (rs1_iss_ex),
        .r_reg_p2_rf_i  (rs2_iss_ex),
        .r_data_p1_rf_o (r_data_p1_rf_iss_ex),
        .r_data_p2_rf_o (r_data_p2_rf_iss_ex)
    );

    assign jalr_iss_ex  = is_i_type_iss_ex & (&op_iss_ex[2:0]);
    assign jump_iss_ex  = is_j_type_iss_ex | jalr_iss_ex;

    assign next_jalr_pc_iss_ex  = (rs1_iss_ex + sign_extnd_imm_12bit_iss) & 32'hFFFF_FFFE;
    assign next_jmp_pc_iss_ex   = jalr_iss_ex ? next_jalr_pc_iss_ex : next_j_br_pc_iss_ex;
    assign next_brn_pc_iss_ex   = next_j_br_pc_iss_ex;

    // EXECUTE STAGE
    ex_pipe_reg ISS_EX_REG (
        .clk                            (clk),
        .reset                          (reset),
        .clr                            (flush_ex | flush_incorr_pred_ex),
        .valid_ex_pipe_reg_i            (valid_iss_ex),
        .funct3_ex_pipe_reg_i           (funct3_iss_ex),
        .rs1_ex_pipe_reg_i              (rs1_iss_ex),
        .rs2_ex_pipe_reg_i              (rs2_iss_ex),
        .rd_ex_pipe_reg_i               (rd_iss_ex),
        .is_r_type_ex_pipe_reg_i        (is_r_type_iss_ex),
        .is_i_type_ex_pipe_reg_i        (is_i_type_iss_ex),
        .is_s_type_ex_pipe_reg_i        (is_s_type_iss_ex),
        .is_b_type_ex_pipe_reg_i        (is_b_type_iss_ex),
        .is_u_type_ex_pipe_reg_i        (is_u_type_iss_ex),
        .is_j_type_ex_pipe_reg_i        (is_j_type_iss_ex),
        .pc_sel_ex_pipe_reg_i           (pc_sel_iss_ex),
        .op1sel_ex_pipe_reg_i           (op1sel_iss_ex),
        .op2sel_ex_pipe_reg_i           (op2sel_iss_ex),
        .wb_sel_ex_pipe_reg_i           (wb_sel_iss_ex),
        .pc4_sel_ex_pipe_reg_i          (pc4_sel_iss_ex),
        .mem_wr_ex_pipe_reg_i           (mem_wr_iss_ex),
        .cpr_en_ex_pipe_reg_i           (cpr_en_iss_ex),
        .wa_sel_ex_pipe_reg_i           (wa_sel_iss_ex),
        .rf_en_ex_pipe_reg_i            (rf_en_iss_ex),
        .alu_fun_ex_pipe_reg_i          (alu_fn_iss_ex),
        .next_seq_pc_ex_pipe_reg_i      (next_seq_pc_iss_ex),
        .curr_pc_ex_pipe_reg_i          (curr_pc_iss_ex),
        .next_brn_pc_ex_pipe_reg_i      (next_brn_pc_iss_ex),
        .next_pred_pc_ex_pipe_reg_i     (next_pred_pc_iss_ex),
        .sext_imm_ex_pipe_reg_i         (sign_extnd_imm_iss_ex),
        .r_data_p1_ex_pipe_reg_i        (r_data_p1_rf_iss_ex),
        .r_data_p2_ex_pipe_reg_i        (r_data_p2_rf_iss_ex),
        .jump_ex_pipe_reg_i             (jump_iss_ex),
        .op_ex_pipe_reg_i               (op_iss_ex),
        .brn_pred_ex_pipe_reg_i         (brn_pred_iss_ex),
        .valid_ex_pipe_reg_o            (valid_ex_mem),
        .funct3_ex_pipe_reg_o           (funct3_ex_mem),
        .rs1_ex_pipe_reg_o              (rs1_ex_mem),
        .rs2_ex_pipe_reg_o              (rs2_ex_mem),
        .rd_ex_pipe_reg_o               (rd_ex_mem),
        .is_r_type_ex_pipe_reg_o        (is_r_type_ex_mem),
        .is_i_type_ex_pipe_reg_o        (is_i_type_ex_mem),
        .is_s_type_ex_pipe_reg_o        (is_s_type_ex_mem),
        .is_b_type_ex_pipe_reg_o        (is_b_type_ex_mem),
        .is_u_type_ex_pipe_reg_o        (is_u_type_ex_mem),
        .is_j_type_ex_pipe_reg_o        (is_j_type_ex_mem),
        .pc_sel_ex_pipe_reg_o           (pc_sel_ex_mem),
        .op1sel_ex_pipe_reg_o           (op1sel_ex_mem),
        .op2sel_ex_pipe_reg_o           (op2sel_ex_mem),
        .wb_sel_ex_pipe_reg_o           (wb_sel_ex_mem),
        .pc4_sel_ex_pipe_reg_o          (pc4_sel_ex_mem),
        .mem_wr_ex_pipe_reg_o           (mem_wr_ex_mem),
        .cpr_en_ex_pipe_reg_o           (cpr_en_ex_mem),
        .wa_sel_ex_pipe_reg_o           (wa_sel_ex_mem),
        .rf_en_ex_pipe_reg_o            (rf_en_ex_mem),
        .alu_fun_ex_pipe_reg_o          (alu_fn_ex_mem),
        .next_seq_pc_ex_pipe_reg_o      (next_seq_pc_ex_mem),
        .curr_pc_ex_pipe_reg_o          (curr_pc_ex_mem),
        .next_brn_pc_ex_pipe_reg_o      (next_brn_pc_ex_mem),
        .next_pred_pc_ex_pipe_reg_o     (next_pred_pc_ex_mem),
        .sext_imm_ex_pipe_reg_o         (sign_extnd_imm_ex),
        .r_data_p1_ex_pipe_reg_o        (r_data_p1_rf_ex_mem),
        .r_data_p2_ex_pipe_reg_o        (r_data_p2_rf_ex_mem),
        .jump_ex_pipe_reg_o             (jump_ex_mem),
        .op_ex_pipe_reg_o               (op_ex_mem),
        .brn_pred_ex_pipe_reg_o         (brn_pred_ex_mem)
    );

    assign r_data_p1_ex_mem     = fwd_r_data_p1_alu_ex[1] ? 
                                  (is_lw_mem_wb ? read_data_dmem_ram_mem_wb : alu_res_mem_wb) : 
                                  fwd_r_data_p1_alu_ex[0] ? wr_data_rf_wb_ret :
                                  r_data_p1_rf_ex_mem;

    assign r_data_p2_ex_mem     = fwd_r_data_p2_alu_ex[1] ? alu_res_mem_wb :
                                  fwd_r_data_p2_alu_ex[0] ? wr_data_rf_wb_ret :
                                  r_data_p2_rf_ex_mem;

    assign r_data_p1_alu_ex_mem = op1sel_ex_mem ? sign_extnd_imm_ex : r_data_p1_ex_mem;

    assign r_data_p2_alu_ex_mem = &op2sel_ex_mem  ? r_data_p2_ex_mem :
                                  op2sel_ex_mem[0]? sign_extnd_imm_ex :
                                  op2sel_ex_mem[1]? curr_pc_ex_mem : 32'b0;
    
    assign branch_taken_ex      = (is_b_type_ex_mem & ((funct3_ex_mem == `BEQ))  & (z_ex_mem))  |
                                  (is_b_type_ex_mem & ((funct3_ex_mem == `BLT)                  | 
                                                    (funct3_ex_mem == `BLTU))    & (n_ex_mem))  |
                                  (is_b_type_ex_mem & ((funct3_ex_mem == `BNE))  & (~z_ex_mem)) |
                                  (is_b_type_ex_mem & ((funct3_ex_mem == `BGE)                  | 
                                                    (funct3_ex_mem == `BGEU)) & (~n_ex_mem      | 
                                                                                (z_ex_mem)));
    // Give the feedback of the prediction made by the predictor
    // 0 - incorrect prediction
    // 1 - correct prediction
    assign brn_corr_pred_ex_mem    = ((brn_pred_ex_mem == branch_taken_ex)) & ((next_brn_pc_ex_mem == next_pred_pc_ex_mem));
    assign force_pc_update_ex      = is_b_type_ex_mem & brn_pred_ex_mem & ~brn_corr_pred_ex_mem;
    assign force_pc_val_ex         = branch_taken_ex ? next_brn_pc_ex_mem : next_seq_pc_ex_mem;

    // The EX stage can force the flushing of the next instruction
    // depending on the prediction result. The below mentioned code
    // is for the case when an incorrect prediction is made for
    // non-branch instructions. The hazard unit flushes the EX/DEC
    // stage only for Jumps and branches.
    // For incorrect predictions made on jump instruction there is 
    // no need to flush the DEC stage. They resolve in the DEC stage 
    // and hazard unit flushes the next incorrect instruction entering
    // the DEC stage.
    // For incorrect predictions made on non-jump instructions the
    // next two instructions are speculatively fetched. Hence the 
    // DEC and EX stage need to be flushed on the next cycle.
    assign flush_incorr_pred_iss   =  ~jump_ex_mem & (brn_pred_ex_mem & ~brn_corr_pred_ex_mem);
    // There is not need to add the jump_ex_mem signal check here
    // as the valid for the register would be propagated from the 
    // DEC pipe register. Again this is already handled in the 
    // hazard unit. 
    assign flush_incorr_pred_ex    =  (brn_pred_ex_mem & ~brn_corr_pred_ex_mem);

    alu A1 (
        .opr_a_alu_i    (r_data_p1_alu_ex_mem),
        .opr_b_alu_i    (r_data_p2_alu_ex_mem),
        .op_alu_i       (alu_fn_ex_mem),
        .res_alu_o      (alu_res_ex_mem),
        .z_alu_o        (z_ex_mem),
        .n_alu_o        (n_ex_mem)
    );

    assign is_lw_ex_mem = {7{is_i_type_ex_mem}} & (`I_TYPE_0 == op_ex_mem);

    // MEMORY STAGE
    mem_pipe_reg EX_MEM_REG (
        .clk                            (clk),
        .reset                          (reset),
        .clr                            (),
        .valid_mem_pipe_reg_i           (valid_ex_mem),
        .rf_en_mem_pipe_reg_i           (rf_en_ex_mem),
        .wb_sel_mem_pipe_reg_i          (wb_sel_ex_mem),
        .mem_wr_mem_pipe_reg_i          (mem_wr_ex_mem),
        .rd_mem_pipe_reg_i              (rd_ex_mem),
        .alu_res_mem_pipe_reg_i         (alu_res_ex_mem),
        .next_seq_pc_mem_pipe_reg_i     (next_seq_pc_ex_mem),
        .is_lw_mem_pipe_reg_i           (is_lw_ex_mem),
        .r_data_p2_mem_pipe_reg_i       (r_data_p2_ex_mem),
        .valid_mem_pipe_reg_o           (valid_mem_wb),
        .rf_en_mem_pipe_reg_o           (rf_en_mem_wb),
        .wb_sel_mem_pipe_reg_o          (wb_sel_mem_wb),
        .mem_wr_mem_pipe_reg_o          (mem_wr_mem_wb),
        .rd_mem_pipe_reg_o              (rd_mem_wb),
        .alu_res_mem_pipe_reg_o         (alu_res_mem_wb),
        .is_lw_mem_pipe_reg_o           (is_lw_mem_wb),
        .next_seq_pc_mem_pipe_reg_o     (next_seq_pc_mem_wb),
        .r_data_p2_mem_pipe_reg_o       (r_data_p2_mem_wb)
    );

    data_mem D_MEM1 (
        .clk                    (clk),
        .addr_dmem_ram_i        (alu_res_mem_wb),
        .wr_data_dmem_ram_i     (r_data_p2_mem_wb),
        .wr_strb_dmem_ram_i     (4'hF),
        .wr_en_dmem_ram_i       (mem_wr_mem_wb),
        .read_data_dmem_ram_o   (read_data_dmem_ram_mem_wb)
    );

    // WRITEBACK STAGE
    wb_pipe_reg MEM_WB_REG (
        .clk                            (clk),
        .reset                          (reset),
        .valid_wb_pipe_reg_i            (valid_mem_wb),
        .rf_en_wb_pipe_reg_i            (rf_en_mem_wb),
        .wb_sel_wb_pipe_reg_i           (wb_sel_mem_wb),
        .rd_wb_pipe_reg_i               (rd_mem_wb),
        .alu_res_wb_pipe_reg_i          (alu_res_mem_wb),
        .read_data_wb_pipe_reg_i        (read_data_dmem_ram_mem_wb),
        .next_seq_pc_wb_pipe_reg_i      (next_seq_pc_mem_wb),
        .instr_retired_wb_pipe_reg_o    (valid_wb_ret),
        .rf_en_wb_pipe_reg_o            (rf_en_wb_ret),
        .wb_sel_wb_pipe_reg_o           (wb_sel_wb_ret),
        .rd_wb_pipe_reg_o               (rd_wb_ret),
        .alu_res_wb_pipe_reg_o          (alu_res_wb_ret),
        .read_data_wb_pipe_reg_o        (read_data_wb_ret),
        .next_seq_pc_wb_pipe_reg_o      (next_seq_pc_wb_ret)
    );

    assign instr_retired     = valid_wb_ret;
    assign wr_data_rf_wb_ret = |rd_wb_ret ? 
                               (wb_sel_wb_ret[0] ? alu_res_wb_ret : read_data_wb_ret) :
                               32'h0;

    hazard_unit hazard (
        .rs1_ex_mem_hz_i            (rs1_ex_mem),
        .rs2_ex_mem_hz_i            (rs2_ex_mem),
        .rd_mem_wb_hz_i             (rd_mem_wb),
        .rd_wb_ret_hz_i             (rd_wb_ret),
        .op2sel_ex_mem_hz_i         (op2sel_ex_mem),
        .rf_en_mem_wb_hz_i          (rf_en_mem_wb),
        .rf_en_wb_ret_hz_i          (rf_en_wb_ret),
        .branch_taken_ex_mem_hz_i   (branch_taken_ex),
        .jump_iss_ex_hz_i           (),
        .brn_pred_ex_mem_hz_i       (brn_corr_pred_ex_mem),
        .stall_fetch_hz_o           (stall_fetch),
        .stall_iss_hz_o             (stall_iss),
        .flush_ex_hz_o              (flush_ex),
        .flush_iss_hz_o             (flush_iss),
        .fwd_p1_ex_mem_hz_o         (fwd_r_data_p1_alu_ex),
        .fwd_p2_ex_mem_hz_o         (fwd_r_data_p2_alu_ex)
    );

endmodule
