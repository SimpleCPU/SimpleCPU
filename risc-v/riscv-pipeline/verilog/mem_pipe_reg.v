// Execute-Memory Pipeline Register

module mem_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire        clr,
        input   wire        valid_mem_pipe_reg_i,
        // Inputs from execute stage
        input   wire        rf_en_mem_pipe_reg_i,
        input   wire[1:0]   wb_sel_mem_pipe_reg_i,
        input   wire        mem_wr_mem_pipe_reg_i,
        input   wire[4:0]   rd_mem_pipe_reg_i,
        input   wire[31:0]  alu_res_mem_pipe_reg_i,
        input   wire[31:0]  next_seq_pc_mem_pipe_reg_i,
        input   wire        is_lw_mem_pipe_reg_i,
        input   wire[31:0]  r_data_p2_mem_pipe_reg_i,
        // Register outputs
        output  wire        valid_mem_pipe_reg_o,
        output  wire        rf_en_mem_pipe_reg_o,
        output  wire[1:0]   wb_sel_mem_pipe_reg_o,
        output  wire        mem_wr_mem_pipe_reg_o,
        output  wire[4:0]   rd_mem_pipe_reg_o,
        output  wire[31:0]  alu_res_mem_pipe_reg_o,
        output  wire[31:0]  next_seq_pc_mem_pipe_reg_o,
        output  wire        is_lw_mem_pipe_reg_o,
        output  wire[31:0]  r_data_p2_mem_pipe_reg_o
    );

    reg        valid_mem_pipe_reg;
    reg        rf_en_mem_pipe_reg;
    reg[1:0]   wb_sel_mem_pipe_reg;
    reg        mem_wr_mem_pipe_reg;
    reg[4:0]   rd_mem_pipe_reg;
    reg[31:0]  alu_res_mem_pipe_reg;
    reg[31:0]  next_seq_pc_mem_pipe_reg;
    reg        is_lw_mem_pipe_reg;
    reg[31:0]  r_data_p2_mem_pipe_reg;

    assign valid_mem_pipe_reg_o          =  valid_mem_pipe_reg;
    assign rf_en_mem_pipe_reg_o          =  rf_en_mem_pipe_reg;
    assign wb_sel_mem_pipe_reg_o         =  wb_sel_mem_pipe_reg;
    assign mem_wr_mem_pipe_reg_o         =  mem_wr_mem_pipe_reg;
    assign rd_mem_pipe_reg_o             =  rd_mem_pipe_reg;
    assign alu_res_mem_pipe_reg_o        =  alu_res_mem_pipe_reg;
    assign next_seq_pc_mem_pipe_reg_o    =  next_seq_pc_mem_pipe_reg;
    assign is_lw_mem_pipe_reg_o          =  is_lw_mem_pipe_reg;
    assign r_data_p2_mem_pipe_reg_o      =  r_data_p2_mem_pipe_reg;

    always @(posedge clk or posedge reset)
    if (reset | clr)
    begin
        valid_mem_pipe_reg          <=  0;
        rf_en_mem_pipe_reg          <=  0;
        wb_sel_mem_pipe_reg         <=  0;
        mem_wr_mem_pipe_reg         <=  0;
        rd_mem_pipe_reg             <=  0;
        alu_res_mem_pipe_reg        <=  0;
        next_seq_pc_mem_pipe_reg    <=  0;
        is_lw_mem_pipe_reg          <=  0;
        r_data_p2_mem_pipe_reg      <=  0;
    end
    else
    begin
        valid_mem_pipe_reg          <=  valid_mem_pipe_reg_i;
        rf_en_mem_pipe_reg          <=  rf_en_mem_pipe_reg_i;
        wb_sel_mem_pipe_reg         <=  wb_sel_mem_pipe_reg_i;
        mem_wr_mem_pipe_reg         <=  mem_wr_mem_pipe_reg_i;
        rd_mem_pipe_reg             <=  rd_mem_pipe_reg_i;
        alu_res_mem_pipe_reg        <=  alu_res_mem_pipe_reg_i;
        next_seq_pc_mem_pipe_reg    <=  next_seq_pc_mem_pipe_reg_i;
        is_lw_mem_pipe_reg          <=  is_lw_mem_pipe_reg_i;
        r_data_p2_mem_pipe_reg      <=  r_data_p2_mem_pipe_reg_i;
    end

endmodule
