// Top module connecting all the other modules

module top
    (
        input   wire    clk,
        input   wire    reset
    );
    
    wire[31:0]  pc_pc_reg_fetch;
    wire[31:0]  next_seq_pc_pc_reg_fetch;
    wire        next_seq_pc_carry_pc_reg_fetch;
    wire[31:0]  instr_pc_reg_fetch;
    wire[31:0]  next_seq_pc_fetch_iss;
    wire[31:0]  instr_fetch_iss;
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
    wire[1:0]   alu_src_iss_ex;
    wire        reg_wr_iss_ex;
    wire        sign_ext_iss_ex;
    wire[31:0]  next_beq_pc_iss_ex;
    wire        next_beq_pc_carry_iss_ex;
    wire[31:0]  r_data_p1_rf_iss_ex;
    wire[31:0]  r_data_p2_rf_iss_ex;
    wire[31:0]  r_data_p2_iss_ex;
    wire        reg_wr_ex_mem;
    wire        mem_to_reg_ex_pipe_reg;
    wire        mem_wr_ex_mem;
    wire[5:0]   alu_op_ex_mem;
    wire        alu_src_ex_mem;
    wire        reg_dst_ex_mem;
    wire[4:0]   rt_ex_mem;
    wire[4:0]   rs_ex_mem;
    wire[4:0]   rd_ex_mem;
    wire[31:0]  r_data_p1_rf_ex_mem;
    wire[31:0]  r_data_p2_rf_ex_mem;
    wire[31:0]  sign_imm_ex_mem;
    wire[31:0]  r_data_p1_alu_ex_mem;
    wire[31:0]  r_data_p2_alu_ex_mem;
    wire[31:0]  res_alu_ex_mem;
    wire        z_ex_mem;
    wire        n_ex_mem;
    wire        reg_wr_mem_wb;
    wire        mem_to_reg_mem_wb;
    wire        mem_wr_mem_wb;
    wire[4:0]   rd_mem_wb;
    wire[31:0]  res_alu_mem_wb;
    wire[31:0]  read_data_dmem_ram_mem_wb;
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

    fetch_pipe_reg FETCH_REG (
        .clk (clk),
        .reset (reset),
        .enable (stall_fetch),
        .next_pc_pc_reg_i (next_pc_top),
        .next_pc_pc_reg_o (pc_pc_reg_fetch)
    );

    instr_mem I_MEM1 (
        .clk (clk),
        .addr_imem_ram_i (pc_pc_reg_fetch),
        .wr_instr_imem_ram_i (wr_instr_imem_top),
        .wr_en_imem_ram_i (wr_en_imem_top),
        .read_instr_imem_ram_o (instr_pc_reg_fetch)
    );

    adder ADD1 (
        .op1 (pc_pc_reg_fetch),
        .op2 (32'h4),
        .cin (1'b0),
        .sum (next_seq_pc_pc_reg_fetch),
        .carry (next_seq_pc_carry_pc_reg_fetch)
    );

    iss_pipe_reg FETCH_ISS_REG (
        .clk (clk),
        .reset (reset),
        .enable (stall_iss),
        .next_pc_iss_pipe_reg_i (next_seq_pc_pc_reg_fetch),
        .instr_iss_pipe_reg_i (instr_pc_reg_fetch),
        .next_pc_iss_pipe_reg_o (next_seq_pc_fetch_iss),
        .instr_iss_pipe_reg_o (instr_fetch_iss)
    );

    decode D1 (
        .instr_dec_i (instr_fetch_iss),
        .sign_ext_i (sign_ext_iss),
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
    assign rd_iss_ex = reg_dst_iss_ex ? rd_dec_iss_ex : rt_iss_ex;
    assign rs_iss_ex = reg_src_iss_ex ? rt_iss_ex     : rs_dec_iss_ex;

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
        .op1 (next_seq_pc_fetch_iss),
        .op2 (sign_imm_iss_ex << 2),
        .cin (1'b0),
        .sum (next_beq_pc_iss_ex),
        .carry (next_beq_pc_carry_iss_ex)
    );

    regfile R1 (
        .clk (clk),
        .reset (reset),
        .w_en_rf_i (reg_wr_wb_ret),
        .w_data_rf_i (wr_data_rf_wb_ret),
        .w_reg_rf_i (),
        .r_reg_p1_rf_i (rs_iss_ex),
        .r_reg_p2_rf_i (rt_iss_ex),
        .r_data_p1_rf_o (r_data_p1_rf_iss_ex),
        .r_data_p2_rf_o (r_data_p2_iss_ex)
    );
    
    assign r_data_p2_rf_iss_ex = alu_src_iss_ex[1] ? {{27{1'b0}}, shamt_iss_ex} : 
                                 alu_src_iss_ex[0] ? sign_imm_iss_ex : r_data_p2_iss_ex;

    ex_pipe_reg ISS_EX_REG (
        .clk (clk),
        .reset (reset),
        .clr (),
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
        .sign_imm_ex_pipe_reg_i (sign_imm_iss_ex),
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
        .sign_imm_ex_pipe_reg_o (sign_imm_ex_mem)
    );

    assign r_data_p1_alu_ex_mem = fwd_r_data_p1_alu_ex[1] ? r_data_p1_rf_ex_mem :
                                  fwd_r_data_p1_alu_ex[0] ? wr_data_rf_wb_ret :
                                  res_alu_mem_wb;
    assign r_data_p2_alu_ex_mem = fwd_r_data_p2_alu_ex[1] ? r_data_p2_rf_ex_mem :
                                  fwd_r_data_p2_alu_ex[0] ? wr_data_rf_wb_ret :
                                  res_alu_mem_wb;

    alu A1 (
        .opr_a_alu_i (r_data_p1_alu_ex_mem),
        .opr_b_alu_i (r_data_p2_alu_ex_mem),
        .op_alu_i (alu_op_ex_mem),
        .res_alu_o (res_alu_ex_mem),
        .z_alu_o (z_ex_mem),
        .n_alu_o (n_ex_mem)
    );

    mem_pipe_reg EX_MEM_REG (
        .clk (clk),
        .reset (reset),
        .reg_wr_mem_pipe_reg_i (reg_wr_ex_mem),
        .mem_to_reg_mem_pipe_reg_i (mem_to_reg_ex_mem),
        .mem_wr_mem_pipe_reg_i (mem_wr_ex_mem),
        .rd_mem_pipe_reg_i (rd_ex_mem),
        .res_alu_mem_pipe_reg_i (res_alu_ex_mem),
        .reg_wr_mem_pipe_reg_o (reg_wr_mem_wb),
        .mem_to_reg_mem_pipe_reg_o (mem_to_reg_mem_wb),
        .mem_wr_mem_pipe_reg_o (mem_wr_mem_wb),
        .rd_mem_pipe_reg_o (rd_mem_wb),
        .res_alu_mem_pipe_reg_o (res_alu_mem_wb)
    );

    data_mem D_MEM1 (
        .clk (clk),
        .addr_dmem_ram_i (res_alu_mem_wb),
        .wr_data_dmem_ram_i (),
        .wr_strb_dmem_ram_i (4'hF),
        .wr_en_dmem_ram_i (mem_wr_mem_wb),
        .read_data_dmem_ram_o (read_data_dmem_ram_mem_wb)
    );

    wb_pipe_reg MEM_WB_REG (
        .clk (clk),
        .reset (reset),
        .reg_wr_wb_pipe_reg_i (reg_wr_mem_wb),
        .mem_to_reg_wb_pipe_reg_i (mem_to_reg_mem_wb),
        .rd_wb_pipe_reg_i (rd_mem_wb),
        .res_alu_wb_pipe_reg_i (res_alu_mem_wb),
        .read_data_wb_pipe_reg_i (read_data_mem_wb),
        .reg_wr_wb_pipe_reg_o (reg_wr_wb_ret),
        .mem_to_reg_wb_pipe_reg_o (mem_to_reg_wb_ret),
        .rd_wb_pipe_reg_o (rd_wb_ret),
        .res_alu_wb_pipe_reg_o (res_alu_wb_ret),
        .read_data_wb_pipe_reg_o (read_data_wb_ret)
    );

    assign wr_data_rf_wb_ret = (|rd_wb_ret) ? 
                               (mem_to_reg_wb_ret ? read_data_wb_ret : res_alu_wb_ret) :
                               32'h0;

    hazard_unit hazard (
        .rs_iss_ex_hz_i (rs_iss_ex),
        .rt_iss_ex_hz_i (rt_iss_ex),
        .rs_ex_mem_hz_i (rs_ex_mem),
        .rt_ex_mem_hz_i (rt_ex_mem),
        .mem_to_reg_ex_mem_hz_i (mem_to_reg_ex_mem),
        .reg_wr_mem_wb_hz_i (reg_wr_mem_wb),
        .reg_wr_wb_ret_hz_i (reg_wr_wb_ret),
        .stall_fetch_hz_o (stall_fetch),
        .stall_iss_hz_o (stall_iss),
        .flush_ex_hz_o (flush_ex),
        .fwd_p1_ex_mem_hz_o (fwd_r_data_p1_alu_ex),
        .fwd_p2_ex_mem_hz_o (fwd_r_data_p2_alu_ex)
    );

endmodule
