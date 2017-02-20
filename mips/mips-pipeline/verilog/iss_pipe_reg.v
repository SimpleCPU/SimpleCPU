// Fetch-Issue Pipeline Register

module iss_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire        enable,     // Active Low enable signal
        input   wire[31:0]  next_pc_iss_pipe_reg_i,
        input   wire[31:0]  instr_iss_pipe_reg_i,
        output  wire[31:0]  next_pc_iss_pipe_reg_o,
        output  wire[31:0]  instr_iss_pipe_reg_o
    );

    reg [31:0] next_pc_iss_pipe_reg;
    reg [31:0] instr_iss_pipe_reg;

    assign next_pc_iss_pipe_reg_o = next_pc_iss_pipe_reg;
    assign instr_iss_pipe_reg_o   = instr_iss_pipe_reg;

    always @(posedge clk or posedge reset)
    if (reset)
    begin
        next_pc_iss_pipe_reg <= 31'b0;
        instr_iss_pipe_reg <= 31'b0;
    end
    else if (~enable)
    begin
        next_pc_iss_pipe_reg <= next_pc_iss_pipe_reg_i;
        instr_iss_pipe_reg <= instr_iss_pipe_reg_i;
    end

endmodule
