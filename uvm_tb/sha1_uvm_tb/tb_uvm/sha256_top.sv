// The SHA256 Top module

`include "uvm_pkg.sv"
module sha256_top ();
    `include "sha256_interface.sv"
    `include "sha256_test.sv"
    import uvm_pkg::*;

    reg    clk;
    reg    reset;
    
    sha256_interface sha256_if (
        .clk    (clk),
        .reset  (reset)
    );

    sha256 sha256 (
        .clk_i    (sha256_if.clk),
        .rst_i    (sha256_if.reset),
        .text_i   (sha256_if.text_i),
        .text_o   (sha256_if.text_o),
        .cmd_i    (sha256_if.cmd_i),
        .cm_w_i   (sha256_if.cmd_w_i),
        .cmd_o    (sha256_if.cmd_o)
    );

    localparam SYSTEM_CLK = 20;

    always begin
        clk = 1;
        # (SYSTEM_CLK/2);
        clk = 0;
        # (SYSTEM_CLK/2);
    end

    initial begin
        reset = 1;
        repeat (21) @(posedge clk);
        reset = 0;
    end

    initial begin
        uvm_config_db #(virtual sha256_interface)::set (null, "*", "sha256_vif", sha256_if);
        `uvm_info ("TOP", "sha256_vif set in the configdb", UVM_NONE)
        sha256_vif.cmd_w_i = 'h0;
        sha256_vif.cmd_i   = 'h0;
        @ (negedge reset);
        `uvm_info ("TOP", "Starting UVM_TEST now", UVM_NONE)
        run_test ();
    end

endmodule
