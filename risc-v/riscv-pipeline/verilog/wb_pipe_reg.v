// Memory-WriteBack Pipeline Register

module wb_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        // Inputs from the mem stage
        input   wire        valid_wb_pipe_reg_i,
        input   wire        rf_en_wb_pipe_reg_i,
        input   wire[1:0]   wb_sel_wb_pipe_reg_i,
        input   wire[4:0]   rd_wb_pipe_reg_i,
        input   wire[31:0]  alu_res_wb_pipe_reg_i,
        input   wire[31:0]  read_data_wb_pipe_reg_i,
        input   wire[31:0]  next_seq_pc_wb_pipe_reg_i,
        // Register outputs
        output  wire        instr_retired_wb_pipe_reg_o,
        output  wire        rf_en_wb_pipe_reg_o,
        output  wire[1:0]   wb_sel_wb_pipe_reg_o,
        output  wire[4:0]   rd_wb_pipe_reg_o,
        output  wire[31:0]  alu_res_wb_pipe_reg_o,
        output  wire[31:0]  read_data_wb_pipe_reg_o,
        output  wire[31:0]  next_seq_pc_wb_pipe_reg_o
    );

    reg        rf_en_wb_pipe_reg;
    reg[1:0]   wb_sel_wb_pipe_reg;
    reg        instr_retired_wb_pipe_reg;
    reg[4:0]   rd_wb_pipe_reg;
    reg[31:0]  alu_res_wb_pipe_reg;
    reg[31:0]  read_data_wb_pipe_reg;
    reg[31:0]  next_seq_pc_wb_pipe_reg;

    assign rf_en_wb_pipe_reg_o          =  rf_en_wb_pipe_reg;
    assign wb_sel_wb_pipe_reg_o         =  wb_sel_wb_pipe_reg;
    assign instr_retired_wb_pipe_reg_o  =  instr_retired_wb_pipe_reg;
    assign rd_wb_pipe_reg_o             =  rd_wb_pipe_reg;
    assign alu_res_wb_pipe_reg_o        =  alu_res_wb_pipe_reg;
    assign read_data_wb_pipe_reg_o      =  read_data_wb_pipe_reg;
    assign next_seq_pc_wb_pipe_reg_o    =  next_seq_pc_wb_pipe_reg;

    always @(posedge clk or posedge reset)
    if (reset)
    begin
        rf_en_wb_pipe_reg          <=  0;
        wb_sel_wb_pipe_reg         <=  0;
        rd_wb_pipe_reg             <=  0;
        alu_res_wb_pipe_reg        <=  0;
        read_data_wb_pipe_reg      <=  0;
        instr_retired_wb_pipe_reg  <=  0;
        next_seq_pc_wb_pipe_reg    <=  0;
    end
    else
    begin
        rf_en_wb_pipe_reg          <=  rf_en_wb_pipe_reg_i;
        wb_sel_wb_pipe_reg         <=  wb_sel_wb_pipe_reg_i;
        rd_wb_pipe_reg             <=  rd_wb_pipe_reg_i;
        alu_res_wb_pipe_reg        <=  alu_res_wb_pipe_reg_i;
        read_data_wb_pipe_reg      <=  read_data_wb_pipe_reg_i;
        instr_retired_wb_pipe_reg  <=  valid_wb_pipe_reg_i;
        next_seq_pc_wb_pipe_reg    <=  next_seq_pc_wb_pipe_reg_i;
    end

endmodule
