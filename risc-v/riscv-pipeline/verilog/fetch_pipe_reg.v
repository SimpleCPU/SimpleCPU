// PC Register

module fetch_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire        enable,     // Active Low enable signal
        input   wire[31:0]  next_pc_pc_reg_i,
        output  wire[31:0]  next_pc_pc_reg_o
    );

    reg [31:0] next_pc_pc_reg;

    assign next_pc_pc_reg_o = next_pc_pc_reg;

    always @(posedge clk or posedge reset)
    if (reset)
        next_pc_pc_reg <= 32'h2000;
    else if (~enable)
        next_pc_pc_reg <= next_pc_pc_reg_i;

endmodule
