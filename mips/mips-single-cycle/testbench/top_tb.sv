// Top testbench

module top_tb ();
`include "testbench/init_imem.sv"
`include "testbench/init_dmem.sv"
`include "testbench/boot_code.sv"
import "DPI-C" function void init ();
import "DPI-C" function void run (int cycles);
import "DPI-C" function int compare_r (int pc, int instr, int rd, int rs, int rt, int rd_val, int rs_val, int rt_val);
import "DPI-C" function int compare_i (int pc, int instr, int rs, int rt, int rs_val, int rt_val);

    wire[31:0]  pc;
    wire[31:0]  instr;
    wire[4:0]   rd;
    wire[4:0]   rs;
    wire[4:0]   rt;
    wire[31:0]  rd_val;
    wire[31:0]  rs_val;
    wire[31:0]  rt_val;
    wire[31:0]  rd_val_dest;
    wire[31:0]  rt_val_dest;
    reg clk_tb, reset_tb;

    assign pc           = T1.curr_pc_top;
    assign instr        = T1.instr_top;
    assign rd           = T1.rd_top;
    assign rs           = T1.rs_top;
    assign rt           = (T1.use_link_reg_top) ? 32'h1F : T1.rt_top;
    assign rd_val       = T1.R1.reg_file[rd];
    assign rs_val       = T1.R1.reg_file[rs];
    assign rt_val       = T1.R1.reg_file[rt];
    assign rt_val_dest  = (T1.reg_wr_top || T1.use_link_reg_top) ? T1.wr_data_rf_top : rt_val;
    assign rd_val_dest  = T1.reg_wr_top ? T1.wr_data_rf_top : rd_val;

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

    always @ (negedge clk_tb)
    if (~reset_tb)
    begin
        run (1);
        if (T1.is_r_type_top) 
        begin
            if (!compare_r (pc, instr, rd, rs, rt, rd_val_dest, rs_val, rt_val))
                $fatal(1, "TEST FAILED\n");
        end
        else if (T1.is_i_type_top)
        begin
        $display ("RT is %x\n\n", rt_val_dest);
            if (!compare_i (pc, instr, rs, rt, rs_val, rt_val_dest))
                $fatal(1, "TEST FAILED\n");
        end
        else
        begin
            $fatal(1, "TEST FAILED\n");
        end
    end

    always @ (negedge clk_tb)
    begin
        if ((T1.instr_top == 'hc) && (T1.R1.reg_file[2] == 'ha))
        begin
            $display("TEST PASSED\n");
            $display("End of simulation reached\n");
            $finish;
        end
    end

endmodule
