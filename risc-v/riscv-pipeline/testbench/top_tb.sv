// Top testbench

module top_tb ();
`include "testbench/init_imem.sv"
`include "testbench/init_dmem.sv"
`include "testbench/boot_code.sv"
import "DPI-C" function void init (string test_name);
import "DPI-C" function void run (int cycles);
import "DPI-C" function int  compare_r (int pc, int instr, int rd, int rs1, int rs2,
                                        int rd_val, int rs1_val, int rs2_val);
import "DPI-C" function int  compare_i (int pc, int instr, int rd, int rs1,
                                        int rd_val, int rs1_val);

    logic   clk_tb, reset_tb;
    string  test_name;

    // Fetch stage signals
    logic[31:0]   pc_fetch;
    logic[31:0]   instr_fetch;
    // Issue stage signals
    logic[31:0]   pc_iss;
    logic[31:0]   instr_iss;
    logic         is_r_type_iss;
    logic         is_i_type_iss;
    logic         is_s_type_iss;
    logic         is_b_type_iss;
    logic         is_u_type_iss;
    logic         is_j_type_iss;
    logic[4:0]    rd_iss;
    logic[4:0]    rs1_iss;
    logic[4:0]    rs2_iss;
    // Execute stage signals
    logic[31:0]   pc_ex;
    logic[31:0]   instr_ex;
    logic         is_r_type_ex;
    logic         is_i_type_ex;
    logic         is_s_type_ex;
    logic         is_b_type_ex;
    logic         is_u_type_ex;
    logic         is_j_type_ex;
    logic[4:0]    rd_ex;
    logic[4:0]    rs1_ex;
    logic[4:0]    rs2_ex;
    logic[31:0]   rd_val_ex;
    logic[31:0]   rs1_val_ex;
    logic[31:0]   rs2_val_ex;
    // Memory stage signals
    logic[31:0]   pc_mem;
    logic[31:0]   instr_mem;
    logic         is_r_type_mem;
    logic         is_i_type_mem;
    logic         is_s_type_mem;
    logic         is_b_type_mem;
    logic         is_u_type_mem;
    logic         is_j_type_mem;
    logic[4:0]    rd_mem;
    logic[4:0]    rs1_mem;
    logic[4:0]    rs2_mem;
    logic[31:0]   rd_val_mem;
    logic[31:0]   rs1_val_mem;
    logic[31:0]   rs2_val_mem;
    // Write-back stage signals
    logic[31:0]   pc_wb;
    logic[31:0]   instr_wb;
    logic         is_r_type_wb;
    logic         is_i_type_wb;
    logic         is_s_type_wb;
    logic         is_b_type_wb;
    logic         is_u_type_wb;
    logic         is_j_type_wb;
    logic[4:0]    rd_wb;
    logic[4:0]    rs1_wb;
    logic[4:0]    rs2_wb;
    logic[31:0]   rd_val_wb;
    logic[31:0]   rs1_val_wb;
    logic[31:0]   rs2_val_wb;
    logic         instr_retired_wb;  

    // FETCH STAGE
    // Signals tapped from the Fetch stage
    assign pc_fetch          = T1.curr_pc_pc_reg_fetch;
    assign instr_fetch       = T1.instr_pc_reg_fetch;

    // ISSUE STAGE
    // Signals tapped from the ISS stage
    assign is_r_type_iss     = T1.is_r_type_iss_ex;
    assign is_i_type_iss     = T1.is_i_type_iss_ex;
    assign is_s_type_iss     = T1.is_s_type_iss_ex;
    assign is_b_type_iss     = T1.is_b_type_iss_ex;
    assign is_u_type_iss     = T1.is_u_type_iss_ex;
    assign is_j_type_iss     = T1.is_j_type_iss_ex;
    assign rs1_iss           = T1.rs1_iss_ex;
    assign rs2_iss           = T1.rs2_iss_ex;
    assign rd_iss            = T1.rd_iss_ex;

    // WRITE-BACK STAGE
    // signals tapped from the WB stage
    assign instr_retired_wb  = T1.instr_retired;
    assign rd_val_wb         = T1.R1.reg_file[rd_wb];
    assign rs1_val_wb        = T1.R1.reg_file[rs1_wb];
    assign rs2_val_wb        = T1.R1.reg_file[rs2_wb];

    top T1 (
        .clk (clk_tb),
        .reset (reset_tb)
    );

    localparam T = 40;
    
    initial
    begin
        if (!($value$plusargs("test=%s", test_name)))
          $fatal ("No test name given");
        init_imem (test_name);
        init_dmem ();
        boot_code ();
        init (test_name);
        $display ("CPU initialised\n");
        reset_tb = 1'b1;
        repeat (5) @(posedge clk_tb);
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
        //$display ("RD is %x\tRS is %x\tRT is %x\n", rd_iss, rs_iss, rt_iss);
        pc_ex           <=  pc_iss;
        instr_ex        <=  instr_iss;
        is_r_type_ex    <=  is_r_type_iss;
        is_i_type_ex    <=  is_i_type_iss;
        is_s_type_ex    <=  is_s_type_iss;
        is_b_type_ex    <=  is_b_type_iss;
        is_u_type_ex    <=  is_u_type_iss;
        is_j_type_ex    <=  is_j_type_iss;
        rs1_ex          <=  rs1_iss;
        rs2_ex          <=  rs2_iss;
        rd_ex           <=  rd_iss;
    end

    // MEMORY
    always @ (posedge clk_tb)
    begin
        pc_mem          <=  pc_ex;
        instr_mem       <=  instr_ex;
        is_r_type_mem   <=  is_r_type_ex;
        is_i_type_mem   <=  is_i_type_ex;
        is_s_type_mem   <=  is_s_type_ex;
        is_b_type_mem   <=  is_b_type_ex;
        is_u_type_mem   <=  is_u_type_ex;
        is_j_type_mem   <=  is_j_type_ex;
        rs1_mem         <=  rs1_ex;
        rs2_mem         <=  rs2_ex;
        rd_mem          <=  rd_ex;
    end

    // WRITE-BACK
    always @ (posedge clk_tb)
    begin
        pc_wb           <=  pc_mem;
        instr_wb        <=  instr_mem;
        is_r_type_wb    <=  is_r_type_mem;
        is_i_type_wb    <=  is_i_type_mem;
        is_s_type_wb    <=  is_s_type_mem;
        is_b_type_wb    <=  is_b_type_mem;
        is_u_type_wb    <=  is_u_type_mem;
        is_j_type_wb    <=  is_j_type_mem;
        rs1_wb          <=  rs1_mem;
        rs2_wb          <=  rs2_mem;
        rd_wb           <=  rd_mem;
    end

    always @ (posedge clk_tb)
    if (instr_retired_wb)
    begin
        run (1);
        if (is_r_type_wb) 
        begin
            if (!compare_r (pc_wb, instr_wb, rd_wb, rs1_wb, rs2_wb, 
                            rd_val_wb, rs1_val_wb, rs2_val_wb))
                $fatal(1, "TEST FAILED\n");
        end
        else if (is_i_type_wb)
        begin
            if (!compare_i (pc_wb, instr_wb, rd_wb, rs1_wb, 
                            rd_val_wb, rs1_val_wb))
                $fatal(1, "TEST FAILED\n");
        end
        //else if (is_s_type_wb)
        //begin
        //    if ()
        //        $fatal(1, "TEST FAILED\n");
        //end
        //else if (is_b_type_wb)
        //begin
        //    if ()
        //        $fatal(1, "TEST FAILED\n");
        //end
        //else if (is_u_type_wb)
        //begin
        //    if ()
        //        $fatal(1, "TEST FAILED\n");
        //end
        //else if (is_j_type_wb)
        //begin
        //    if ()
        //        $fatal(1, "TEST FAILED\n");
        //end
        else
            $fatal (1, "Incorrect instruction opcode");
    end

endmodule
