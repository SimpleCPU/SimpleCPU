// Execute-Memory Pipeline Register

module mem_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire        clr,
        input   wire        valid_mem_pipe_reg_i,
        input   wire        reg_wr_mem_pipe_reg_i,
        input   wire        mem_to_reg_mem_pipe_reg_i,
        input   wire        mem_wr_mem_pipe_reg_i,
        input   wire[4:0]   rd_mem_pipe_reg_i,
        input   wire[31:0]  res_alu_mem_pipe_reg_i,
        output  wire        valid_mem_pipe_reg_o,
        output  wire        reg_wr_mem_pipe_reg_o,
        output  wire        mem_to_reg_mem_pipe_reg_o,
        output  wire        mem_wr_mem_pipe_reg_o,
        output  wire[4:0]   rd_mem_pipe_reg_o,
        output  wire[31:0]  res_alu_mem_pipe_reg_o
    );

    reg        valid_mem_pipe_reg;
    reg        reg_wr_mem_pipe_reg;
    reg        mem_to_reg_mem_pipe_reg;
    reg        mem_wr_mem_pipe_reg;
    reg[4:0]   rd_mem_pipe_reg;
    reg[31:0]  res_alu_mem_pipe_reg;

    assign valid_mem_pipe_reg_o          =  valid_mem_pipe_reg;
    assign reg_wr_mem_pipe_reg_o         =  reg_wr_mem_pipe_reg;
    assign mem_to_reg_mem_pipe_reg_o     =  mem_to_reg_mem_pipe_reg;
    assign mem_wr_mem_pipe_reg_o         =  mem_wr_mem_pipe_reg;
    assign rd_mem_pipe_reg_o             =  rd_mem_pipe_reg;
    assign res_alu_mem_pipe_reg_o        =  res_alu_mem_pipe_reg;

    always @(posedge clk or posedge reset)
    if (reset | clr)
    begin
        valid_mem_pipe_reg          <=  0;
        reg_wr_mem_pipe_reg         <=  0;
        mem_to_reg_mem_pipe_reg     <=  0;
        mem_wr_mem_pipe_reg         <=  0;
        rd_mem_pipe_reg             <=  0;
        res_alu_mem_pipe_reg        <=  0;
    end
    else
    begin
        valid_mem_pipe_reg          <=  valid_mem_pipe_reg_i;
        reg_wr_mem_pipe_reg         <=  reg_wr_mem_pipe_reg_i;
        mem_to_reg_mem_pipe_reg     <=  mem_to_reg_mem_pipe_reg_i;
        mem_wr_mem_pipe_reg         <=  mem_wr_mem_pipe_reg_i;
        rd_mem_pipe_reg             <=  rd_mem_pipe_reg_i;
        res_alu_mem_pipe_reg        <=  res_alu_mem_pipe_reg_i;
    end

endmodule
