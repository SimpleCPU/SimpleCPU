// Top testbench

module top_tb ();
`include "testbench/init_imem.sv"

    reg clk_tb, reset_tb;
    top T1 (
        .clk (clk_tb),
        .reset (reset_tb)
    );

    localparam T = 20;
    
    initial
    begin
        init_imem ();
        reset_tb = 1'b1;
        # (T);
        reset_tb = 1'b0;
    end

    always
    begin
        clk_tb = 1'b0;
        # (T/2);
        clk_tb = 1'b1;
        # (T/2);
    end

    always
    begin
        # (50 * T);
        $finish;
    end

endmodule
