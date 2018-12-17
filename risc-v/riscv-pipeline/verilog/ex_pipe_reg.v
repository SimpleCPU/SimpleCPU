// Issue-Execute Pipeline Register

module ex_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire        clr,
        input   wire        valid_ex_pipe_reg_i,
        // Inputs from the instr decoder
        input   wire[2:0]   funct3_ex_pipe_reg_i,
        input   wire[6:0]   op_ex_pipe_reg_i,
        input   wire[4:0]   rs1_ex_pipe_reg_i,
        input   wire[4:0]   rs2_ex_pipe_reg_i,
        input   wire[4:0]   rd_ex_pipe_reg_i,
        input   wire        is_r_type_ex_pipe_reg_i,
        input   wire        is_i_type_ex_pipe_reg_i,
        input   wire        is_s_type_ex_pipe_reg_i,
        input   wire        is_b_type_ex_pipe_reg_i,
        input   wire        is_u_type_ex_pipe_reg_i,
        input   wire        is_j_type_ex_pipe_reg_i,
        // Inputs from the control unit
        input   wire[1:0]   pc_sel_ex_pipe_reg_i,
        input   wire        op1sel_ex_pipe_reg_i,
        input   wire[1:0]   op2sel_ex_pipe_reg_i,
        input   wire[1:0]   wb_sel_ex_pipe_reg_i,
        input   wire        pc4_sel_ex_pipe_reg_i,
        input   wire        mem_wr_ex_pipe_reg_i,
        input   wire        cpr_en_ex_pipe_reg_i,
        input   wire        wa_sel_ex_pipe_reg_i,
        input   wire        rf_en_ex_pipe_reg_i,
        input   wire[5:0]   alu_fun_ex_pipe_reg_i,
        // PC related inputs from issue stage
        input   wire[31:0]  next_seq_pc_ex_pipe_reg_i,
        input   wire[31:0]  curr_pc_ex_pipe_reg_i,
        input   wire[31:0]  next_brn_pc_ex_pipe_reg_i,
        input   wire[31:0]  next_pred_pc_ex_pipe_reg_i,
        // Inputs from sign extend units
        input   wire[31:0]  sext_imm_ex_pipe_reg_i,
        // Inputs from register file
        input   wire[31:0]  r_data_p1_ex_pipe_reg_i,
        input   wire[31:0]  r_data_p2_ex_pipe_reg_i,
        // Inputs from the issue stage
        input   wire        jump_ex_pipe_reg_i,
        input   wire        brn_pred_ex_pipe_reg_i,
        // Register outputs
        output  wire        valid_ex_pipe_reg_o,
        output  wire[2:0]   funct3_ex_pipe_reg_o,
        output  wire[6:0]   op_ex_pipe_reg_o,
        output  wire[4:0]   rs1_ex_pipe_reg_o,
        output  wire[4:0]   rs2_ex_pipe_reg_o,
        output  wire[4:0]   rd_ex_pipe_reg_o,
        output  wire        is_r_type_ex_pipe_reg_o,
        output  wire        is_i_type_ex_pipe_reg_o,
        output  wire        is_s_type_ex_pipe_reg_o,
        output  wire        is_b_type_ex_pipe_reg_o,
        output  wire        is_u_type_ex_pipe_reg_o,
        output  wire        is_j_type_ex_pipe_reg_o,
        output  wire[1:0]   pc_sel_ex_pipe_reg_o,
        output  wire        op1sel_ex_pipe_reg_o,
        output  wire[1:0]   op2sel_ex_pipe_reg_o,
        output  wire[1:0]   wb_sel_ex_pipe_reg_o,
        output  wire        pc4_sel_ex_pipe_reg_o,
        output  wire        mem_wr_ex_pipe_reg_o,
        output  wire        cpr_en_ex_pipe_reg_o,
        output  wire        wa_sel_ex_pipe_reg_o,
        output  wire        rf_en_ex_pipe_reg_o,
        output  wire[5:0]   alu_fun_ex_pipe_reg_o,
        output  wire[31:0]  next_seq_pc_ex_pipe_reg_o,
        output  wire[31:0]  curr_pc_ex_pipe_reg_o,
        output  wire[31:0]  next_brn_pc_ex_pipe_reg_o,
        output  wire[31:0]  next_pred_pc_ex_pipe_reg_o,
        output  wire[31:0]  sext_imm_ex_pipe_reg_o,
        output  wire[31:0]  r_data_p1_ex_pipe_reg_o,
        output  wire[31:0]  r_data_p2_ex_pipe_reg_o,
        output  wire        jump_ex_pipe_reg_o,
        output  wire        brn_pred_ex_pipe_reg_o
    );

    reg        valid_ex_pipe_reg;
    reg[2:0]   funct3_ex_pipe_reg;
    reg[6:0]   op_ex_pipe_reg;
    reg[4:0]   rs1_ex_pipe_reg;
    reg[4:0]   rs2_ex_pipe_reg;
    reg[4:0]   rd_ex_pipe_reg;
    reg        is_r_type_ex_pipe_reg;
    reg        is_i_type_ex_pipe_reg;
    reg        is_s_type_ex_pipe_reg;
    reg        is_b_type_ex_pipe_reg;
    reg        is_u_type_ex_pipe_reg;
    reg        is_j_type_ex_pipe_reg;
    reg[1:0]   pc_sel_ex_pipe_reg;
    reg        op1sel_ex_pipe_reg;
    reg[1:0]   op2sel_ex_pipe_reg;
    reg[1:0]   wb_sel_ex_pipe_reg;
    reg        pc4_sel_ex_pipe_reg;
    reg        mem_wr_ex_pipe_reg;
    reg        cpr_en_ex_pipe_reg;
    reg        wa_sel_ex_pipe_reg;
    reg        rf_en_ex_pipe_reg;
    reg[5:0]   alu_fun_ex_pipe_reg;
    reg[31:0]  next_seq_pc_ex_pipe_reg;
    reg[31:0]  curr_pc_ex_pipe_reg;
    reg[31:0]  next_brn_pc_ex_pipe_reg;
    reg[31:0]  next_pred_pc_ex_pipe_reg;
    reg[31:0]  sext_imm_ex_pipe_reg;    
    reg[31:0]  r_data_p1_ex_pipe_reg;
    reg[31:0]  r_data_p2_ex_pipe_reg;
    reg        jump_ex_pipe_reg;
    reg        brn_pred_ex_pipe_reg;

    assign valid_ex_pipe_reg_o          = valid_ex_pipe_reg;
    assign funct3_ex_pipe_reg_o         = funct3_ex_pipe_reg;
    assign op_ex_pipe_reg_o             = op_ex_pipe_reg;
    assign rs1_ex_pipe_reg_o            = rs1_ex_pipe_reg;
    assign rs2_ex_pipe_reg_o            = rs2_ex_pipe_reg;
    assign rd_ex_pipe_reg_o             = rd_ex_pipe_reg;
    assign is_r_type_ex_pipe_reg_o      = is_r_type_ex_pipe_reg;
    assign is_i_type_ex_pipe_reg_o      = is_i_type_ex_pipe_reg;
    assign is_s_type_ex_pipe_reg_o      = is_s_type_ex_pipe_reg;
    assign is_b_type_ex_pipe_reg_o      = is_b_type_ex_pipe_reg;
    assign is_u_type_ex_pipe_reg_o      = is_u_type_ex_pipe_reg;
    assign is_j_type_ex_pipe_reg_o      = is_j_type_ex_pipe_reg;
    assign pc_sel_ex_pipe_reg_o         = pc_sel_ex_pipe_reg;
    assign op1sel_ex_pipe_reg_o         = op1sel_ex_pipe_reg;
    assign op2sel_ex_pipe_reg_o         = op2sel_ex_pipe_reg;
    assign wb_sel_ex_pipe_reg_o         = wb_sel_ex_pipe_reg;
    assign pc4_sel_ex_pipe_reg_o        = pc4_sel_ex_pipe_reg;
    assign mem_wr_ex_pipe_reg_o         = mem_wr_ex_pipe_reg;
    assign cpr_en_ex_pipe_reg_o         = cpr_en_ex_pipe_reg;
    assign wa_sel_ex_pipe_reg_o         = wa_sel_ex_pipe_reg;
    assign rf_en_ex_pipe_reg_o          = rf_en_ex_pipe_reg;
    assign alu_fun_ex_pipe_reg_o        = alu_fun_ex_pipe_reg;
    assign next_seq_pc_ex_pipe_reg_o    = next_seq_pc_ex_pipe_reg;
    assign curr_pc_ex_pipe_reg_o        = curr_pc_ex_pipe_reg;
    assign next_brn_pc_ex_pipe_reg_o    = next_brn_pc_ex_pipe_reg;
    assign next_pred_pc_ex_pipe_reg_o   = next_pred_pc_ex_pipe_reg;
    assign sext_imm_ex_pipe_reg_o       = sext_imm_ex_pipe_reg;
    assign r_data_p1_ex_pipe_reg_o      = r_data_p1_ex_pipe_reg;
    assign r_data_p2_ex_pipe_reg_o      = r_data_p2_ex_pipe_reg;
    assign jump_ex_pipe_reg_o           = jump_ex_pipe_reg;
    assign brn_pred_ex_pipe_reg_o       = brn_pred_ex_pipe_reg;

    always @ (posedge clk)
    if (reset | clr)
    begin
        valid_ex_pipe_reg           <= 1'b0;
        funct3_ex_pipe_reg          <= 3'b0;
        op_ex_pipe_reg              <= 7'b0;
        rs1_ex_pipe_reg             <= 4'b0;
        rs2_ex_pipe_reg             <= 4'b0;
        rd_ex_pipe_reg              <= 4'b0;
        is_r_type_ex_pipe_reg       <= 1'b0;
        is_i_type_ex_pipe_reg       <= 1'b0;
        is_s_type_ex_pipe_reg       <= 1'b0;
        is_b_type_ex_pipe_reg       <= 1'b0;
        is_u_type_ex_pipe_reg       <= 1'b0;
        is_j_type_ex_pipe_reg       <= 1'b0;
        pc_sel_ex_pipe_reg          <= 2'b0;
        op1sel_ex_pipe_reg          <= 1'b0;
        op2sel_ex_pipe_reg          <= 2'b0;
        wb_sel_ex_pipe_reg          <= 2'b0;
        pc4_sel_ex_pipe_reg         <= 1'b0;
        mem_wr_ex_pipe_reg          <= 1'b0;
        cpr_en_ex_pipe_reg          <= 1'b0;
        wa_sel_ex_pipe_reg          <= 1'b0;
        rf_en_ex_pipe_reg           <= 1'b0;
        alu_fun_ex_pipe_reg         <= 6'b0;
        next_seq_pc_ex_pipe_reg     <= 31'b0;
        curr_pc_ex_pipe_reg         <= 31'b0;
        next_brn_pc_ex_pipe_reg     <= 31'b0;
        next_pred_pc_ex_pipe_reg    <= 31'b0;
        sext_imm_ex_pipe_reg        <= 31'b0;
        r_data_p1_ex_pipe_reg       <= 31'b0;
        r_data_p2_ex_pipe_reg       <= 31'b0;
        jump_ex_pipe_reg            <= 1'b0;
        brn_pred_ex_pipe_reg        <= 1'b0;
    end
    else
    begin
        valid_ex_pipe_reg           <=  valid_ex_pipe_reg_i;
        funct3_ex_pipe_reg          <=  funct3_ex_pipe_reg_i;
        op_ex_pipe_reg              <=  op_ex_pipe_reg_i;
        rs1_ex_pipe_reg             <=  rs1_ex_pipe_reg_i;
        rs2_ex_pipe_reg             <=  rs2_ex_pipe_reg_i;
        rd_ex_pipe_reg              <=  rd_ex_pipe_reg_i;
        is_r_type_ex_pipe_reg       <=  is_r_type_ex_pipe_reg_i;
        is_i_type_ex_pipe_reg       <=  is_i_type_ex_pipe_reg_i;
        is_s_type_ex_pipe_reg       <=  is_s_type_ex_pipe_reg_i;
        is_b_type_ex_pipe_reg       <=  is_b_type_ex_pipe_reg_i;
        is_u_type_ex_pipe_reg       <=  is_u_type_ex_pipe_reg_i;
        is_j_type_ex_pipe_reg       <=  is_j_type_ex_pipe_reg_i;
        pc_sel_ex_pipe_reg          <=  pc_sel_ex_pipe_reg_i;
        op1sel_ex_pipe_reg          <=  op1sel_ex_pipe_reg_i;
        op2sel_ex_pipe_reg          <=  op2sel_ex_pipe_reg_i;
        wb_sel_ex_pipe_reg          <=  wb_sel_ex_pipe_reg_i;
        pc4_sel_ex_pipe_reg         <=  pc4_sel_ex_pipe_reg_i;
        mem_wr_ex_pipe_reg          <=  mem_wr_ex_pipe_reg_i;
        cpr_en_ex_pipe_reg          <=  cpr_en_ex_pipe_reg_i;
        wa_sel_ex_pipe_reg          <=  wa_sel_ex_pipe_reg_i;
        rf_en_ex_pipe_reg           <=  rf_en_ex_pipe_reg_i;
        alu_fun_ex_pipe_reg         <=  alu_fun_ex_pipe_reg_i;
        next_seq_pc_ex_pipe_reg     <=  next_seq_pc_ex_pipe_reg_i;
        curr_pc_ex_pipe_reg         <=  curr_pc_ex_pipe_reg_i;
        next_brn_pc_ex_pipe_reg     <=  next_brn_pc_ex_pipe_reg_i;
        next_pred_pc_ex_pipe_reg    <=  next_pred_pc_ex_pipe_reg_i;
        sext_imm_ex_pipe_reg        <=  sext_imm_ex_pipe_reg_i;
        r_data_p1_ex_pipe_reg       <=  r_data_p1_ex_pipe_reg_i;
        r_data_p2_ex_pipe_reg       <=  r_data_p2_ex_pipe_reg_i;
        jump_ex_pipe_reg            <=  jump_ex_pipe_reg_i;
        brn_pred_ex_pipe_reg        <=  brn_pred_ex_pipe_reg_i;
    end

endmodule
