// Top testbench

module top_tb ();
`include "testbench/init_imem.sv"
`include "testbench/init_dmem.sv"
`include "testbench/boot_code.sv"
import "DPI-C" function void init ();
import "DPI-C" function void run (int cycles);
import "DPI-C" function int compare_r (int pc, int instr, int rd, int rs, int rt, int rd_val, int rs_val, int rt_val);
import "DPI-C" function int compare_i (int pc, int instr, int rs, int rt, int rs_val, int rt_val);

    logic clk_tb, reset_tb;

    // Fetch stage signals
    logic[31:0]   pc_fetch;
    logic[31:0]   instr_fetch;
    // Issue stage signals
    logic[31:0]   pc_iss;
    logic[31:0]   instr_iss;
    logic         is_r_type_iss;
    logic         is_i_type_iss;
    logic         is_j_type_iss;
    logic[4:0]    rd_iss;
    logic[4:0]    rs_iss;
    logic[4:0]    rt_iss;
    // Execute stage signals
    logic[31:0]   pc_ex;
    logic[31:0]   instr_ex;
    logic         is_r_type_ex;
    logic         is_i_type_ex;
    logic         is_j_type_ex;
    logic[4:0]    rd_ex;
    logic[4:0]    rs_ex;
    logic[4:0]    rt_ex;
    logic[31:0]   rd_val_ex;
    logic[31:0]   rs_val_ex;
    logic[31:0]   rt_val_ex;
    // Memory stage signals
    logic[31:0]   pc_mem;
    logic[31:0]   instr_mem;
    logic         is_r_type_mem;
    logic         is_i_type_mem;
    logic         is_j_type_mem;
    logic[4:0]    rd_mem;
    logic[4:0]    rs_mem;
    logic[4:0]    rt_mem;
    logic[31:0]   rd_val_mem;
    logic[31:0]   rs_val_mem;
    logic[31:0]   rt_val_mem;
    // Write-back stage signals
    logic[31:0]   pc_wb;
    logic[31:0]   instr_wb;
    logic         is_r_type_wb;
    logic         is_i_type_wb;
    logic         is_j_type_wb;
    logic[4:0]    rd_wb;
    logic[4:0]    rs_wb;
    logic[4:0]    rt_wb;
    logic[31:0]   rd_val_wb;
    logic[31:0]   rs_val_wb;
    logic[31:0]   rt_val_wb;
    logic[31:0]   rd_val_dest_wb;
    logic[31:0]   rt_val_dest_wb;
    

    // FETCH
    assign pc_fetch         = T1.curr_pc_pc_reg_fetch;
    assign instr_fetch      = T1.instr_pc_reg_fetch;

    // ISSUE
    assign is_r_type_iss    = T1.is_r_type_iss_ex;
    assign is_i_type_iss    = T1.is_i_type_iss_ex;
    assign is_j_type_iss    = T1.is_j_type_iss_ex;
    assign rs_iss           = T1.rs_iss_ex;
    assign rt_iss           = T1.rt_iss_ex;
    assign rd_iss           = T1.rd_iss_ex;

    // EXECUTE
    assign rd_val_ex        = T1.R1.reg_file[rd_ex];
    assign rs_val_ex        = T1.R1.reg_file[rs_ex];
    assign rt_val_ex        = T1.R1.reg_file[rt_ex];

    // MEM

    // WRITE-BACK
    //assign rt_val_dest  = T1.reg_wr_top ? T1.wr_data_rf_top : rt_val;
    //assign rd_val_dest  = T1.reg_wr_top ? T1.wr_data_rf_top : rd_val;

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

    // ISSUE
    always @ (posedge clk_tb)
    begin
        pc_iss      <=  pc_fetch;
        instr_iss   <=  instr_fetch;
    end

    // EXECUTE
    always @ (posedge clk_tb)
    begin
        pc_ex           <=  pc_iss;
        instr_ex        <=  instr_iss;
        is_r_type_ex    <=  is_r_type_iss;
        is_i_type_ex    <=  is_i_type_iss;
        is_j_type_ex    <=  is_j_type_iss;
        rs_ex           <=  rs_iss;
        rt_ex           <=  rt_iss;
        rd_ex           <=  rd_iss;
    end

    // MEMORY
    always @ (posedge clk_tb)
    begin
        pc_mem          <=  pc_ex;
        instr_mem       <=  instr_ex;
        is_r_type_mem   <=  is_r_type_ex;
        is_i_type_mem   <=  is_i_type_ex;
        is_j_type_mem   <=  is_j_type_ex;
        rs_mem          <=  rs_ex;
        rt_mem          <=  rt_ex;
        rd_mem          <=  rd_ex;
    end

    // WRITE-BACK
    always @ (posedge clk_tb)
    begin
        pc_wb           <=  pc_mem;
        instr_wb        <=  instr_mem;
        is_r_type_ex    <=  is_r_type_mem;
        is_i_type_ex    <=  is_i_type_mem;
        is_j_type_ex    <=  is_j_type_mem;
        rs_wb           <=  rs_ex;
        rt_wb           <=  rt_ex;
        rd_wb           <=  rd_ex;
    end

    //always @ (negedge clk_tb)
    //if (~reset_tb)
    //begin
    //    run (1);
    //    if (T1.is_r_type_top) 
    //    begin
    //        if (!compare_r (pc, instr, rd, rs, rt, rd_val_dest, rs_val, rt_val))
    //            $finish;
    //    end
    //    else if (T1.is_i_type_top)
    //    begin
    //        if (!compare_i (pc, instr, rs, rt, rs_val, rt_val_dest))
    //            $finish;
    //    end
    //end

    //always @ (negedge clk_tb)
    //begin
    //    if ((T1.instr_top == 'hc) && (T1.R1.reg_file[2] == 'ha))
    //    begin
    //        $display("End of simulation reached\n");
    //        $finish;
    //    end
    //end

endmodule
