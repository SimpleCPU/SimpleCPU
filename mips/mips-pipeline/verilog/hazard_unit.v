// Hazard checking unit 

module hazard_unit
    (
        input   wire[4:0]   rs_ex_mem_hz_i,
        input   wire[4:0]   rt_ex_mem_hz_i,
        input   wire[4:0]   rd_mem_wb_hz_i,
        input   wire[4:0]   rd_wb_ret_hz_i,
        input   wire        mem_to_reg_ex_mem_hz_i,
        input   wire        reg_wr_mem_wb_hz_i,
        input   wire        reg_wr_wb_ret_hz_i,
        input   wire        branch_taken_ex_mem_hz_i,
        input   wire        jump_iss_ex_hz_i,
        output  wire        stall_fetch_hz_o,
        output  wire        stall_iss_hz_o,
        output  wire        flush_ex_hz_o,
        output  wire        flush_iss_hz_o,
        output  wire[1:0]   fwd_p1_ex_mem_hz_o,
        output  wire[1:0]   fwd_p2_ex_mem_hz_o
    );

    wire        stall_fetch_hz;
    wire        stall_iss_hz;
    wire        flush_ex_hz;
    wire        flush_iss_hz;
    wire[1:0]   fwd_p1_ex_mem_hz;
    wire[1:0]   fwd_p2_ex_mem_hz;

    assign  stall_fetch_hz_o    = stall_fetch_hz;
    assign  stall_iss_hz_o      = stall_iss_hz;
    assign  flush_ex_hz_o       = flush_ex_hz;
    assign  flush_iss_hz_o      = flush_iss_hz;
    assign  fwd_p1_ex_mem_hz_o  = fwd_p1_ex_mem_hz; 
    assign  fwd_p2_ex_mem_hz_o  = fwd_p2_ex_mem_hz; 
 
    // Forward the data only when we are writing to a non-zero register
    // in the WB/MEM stage and the same register is being read at the
    // EX stage
    assign  fwd_p1_ex_mem_hz = (reg_wr_mem_wb_hz_i & |rd_mem_wb_hz_i &
                               (rd_mem_wb_hz_i == rs_ex_mem_hz_i)) ? 2'b10 
                               : (reg_wr_wb_ret_hz_i &  |rd_mem_wb_hz_i &                       
                                 (rd_wb_ret_hz_i == rs_ex_mem_hz_i)) ? 2'b01 
                                 : 2'b00;
    assign  fwd_p2_ex_mem_hz = (reg_wr_mem_wb_hz_i & |rd_mem_wb_hz_i &
                               (rd_mem_wb_hz_i == rt_ex_mem_hz_i)) ? 2'b10 
                               : (reg_wr_wb_ret_hz_i & |rd_mem_wb_hz_i &
                                 (rd_wb_ret_hz_i == rt_ex_mem_hz_i)) ? 2'b01 
                                 : 2'b00;
    assign stall_fetch_hz = 1'b0;
    assign stall_iss_hz = 1'b0;
    // Jumps would be resolved in the ISSUE (DECODE) stage
    // the following signals should be based on those values
    // This is required to flush the value in the EX Pipe register
    // to a NO-OP. 
    assign flush_ex_hz = branch_taken_ex_mem_hz_i;
    // Branches would be resolved in the EXECUTE stage
    // the following signals should be based on those values
    assign flush_iss_hz = branch_taken_ex_mem_hz_i | jump_iss_ex_hz_i;

endmodule
