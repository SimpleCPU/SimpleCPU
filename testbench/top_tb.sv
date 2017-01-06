// Top testbench

module top_tb ();
`include "testbench/init_imem.sv"
`include "testbench/init_dmem.sv"
`include "testbench/boot_code.sv"
import "DPI-C" function void init ();
import "DPI-C" function void run (int cycles);
import "DPI-C" function void compare (int pc, int instr, int rd, int rs, int rt);

    wire[31:0]  pc;
    wire[31:0]  instr;
    wire[31:0]  rd;
    wire[31:0]  rs;
    wire[31:0]  rt;
    reg clk_tb, reset_tb;

    assign pc       = T1.curr_pc_top;
    assign instr    = T1.instr_top;
    assign rd       = T1.R1.reg_file[T1.rd_top];
    assign rs       = T1.R1.reg_file[T1.rs_top];
    assign rt       = T1.R1.reg_file[T1.rt_top];

    top T1 (
        .clk (clk_tb),
        .reset (reset_tb)
    );

    localparam T = 20;
    
    initial
    begin
        init_imem ();
        init_dmem ();
        boot_code ();
        init ();
        $display ("CPU initialised\n");
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

    always @ (posedge clk_tb)
    if (~reset_tb)
    begin
        run (1);
        compare (pc, instr, rd, rs, rt);
    end

    always @ (posedge clk_tb)
    begin
        if ((T1.instr_top == 'hc) && (T1.R1.reg_file[2] == 'ha))
        begin
            $display("End of simulation reached\n");
            $finish;
        end
    end

endmodule
