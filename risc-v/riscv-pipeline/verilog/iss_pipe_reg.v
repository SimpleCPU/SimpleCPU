// Fetch-Issue Pipeline Register

module iss_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire        clr,
        input   wire        enable,
        // PC related inputs from fetch stage
        input   wire[31:0]  next_pc_iss_pipe_reg_i,
        input   wire[31:0]  instr_iss_pipe_reg_i,
        input   wire        brn_pred_iss_pipe_reg_i,
        input   wire[31:0]  curr_pc_iss_pipe_reg_i,
        input   wire[31:0]  next_pred_pc_iss_pipe_reg_i,
        // Register outputs
        output  wire[31:0]  next_pc_iss_pipe_reg_o,
        output  wire[31:0]  instr_iss_pipe_reg_o,
        output  wire        brn_pred_iss_pipe_reg_o,
        output  wire[31:0]  curr_pc_iss_pipe_reg_o,
        output  wire[31:0]  next_pred_pc_iss_pipe_reg_o
    );

    reg [31:0] next_pc_iss_pipe_reg;
    reg [31:0] instr_iss_pipe_reg;
    reg        brn_pred_iss_pipe_reg;
    reg [31:0] curr_pc_iss_pipe_reg;
    reg [31:0] next_pred_pc_iss_pipe_reg;

    assign next_pc_iss_pipe_reg_o       = next_pc_iss_pipe_reg;
    assign instr_iss_pipe_reg_o         = instr_iss_pipe_reg;
    assign brn_pred_iss_pipe_reg_o      = brn_pred_iss_pipe_reg;
    assign curr_pc_iss_pipe_reg_o       = curr_pc_iss_pipe_reg;
    assign next_pred_pc_iss_pipe_reg_o  = next_pred_pc_iss_pipe_reg;

    always @(posedge clk or posedge reset)
    if (reset | clr)
    begin
        next_pc_iss_pipe_reg      <= 31'b0;
        instr_iss_pipe_reg        <= 31'b0;
        brn_pred_iss_pipe_reg     <= 31'b0;
        curr_pc_iss_pipe_reg      <= 31'b0;
        next_pred_pc_iss_pipe_reg <= 31'b0;
    end
    else if (~enable)
    begin
        next_pc_iss_pipe_reg      <= next_pc_iss_pipe_reg_i;
        instr_iss_pipe_reg        <= instr_iss_pipe_reg_i;
        brn_pred_iss_pipe_reg     <= brn_pred_iss_pipe_reg_i;
        curr_pc_iss_pipe_reg      <= curr_pc_iss_pipe_reg_i;
        next_pred_pc_iss_pipe_reg <= next_pred_pc_iss_pipe_reg_i;
    end

endmodule
