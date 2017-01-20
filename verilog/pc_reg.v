// PC Register

module pc_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire[31:0]  next_pc_pc_reg_i,
        output  wire[31:0]  next_pc_pc_reg_o
    );

    reg [31:0] next_pc_pc_reg;

    assign next_pc_pc_reg_o = next_pc_pc_reg;

    always @(posedge clk or posedge reset)
    if (reset)
        next_pc_pc_reg <= 31'b0;
    else
        next_pc_pc_reg <= next_pc_pc_reg_i;

endmodule
