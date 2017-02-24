// Hazard checking unit 

module hazard_unit
    (
        input   wire[4:0]   rs_iss_ex_hz_i,
        input   wire[4:0]   rt_iss_ex_hz_i,
        input   wire[4:0]   rs_ex_mem_hz_i,
        input   wire[4:0]   rt_ex_mem_hz_i,
        input   wire        mem_to_reg_ex_mem_hz_i,
        input   wire        reg_wr_mem_wb_hz_i,
        input   wire        reg_wr_wb_ret_hz_i,
        output  wire        stall_fetch_hz_o,
        output  wire        stall_iss_hz_o,
        output  wire        flush_ex_hz_o,
        output  wire[1:0]   fwd_p1_ex_mem_hz_o,
        output  wire[1:0]   fwd_p2_ex_mem_hz_o
    );

    wire        stall_fetch_hz;
    wire        stall_iss_hz;
    wire        flush_ex_hz;
    wire[1:0]   fwd_p1_ex_mem_hz;
    wire[1:0]   fwd_p2_ex_mem_hz;

    assign  stall_fetch_hz_o    = stall_fetch_hz;
    assign  stall_iss_hz_o      = stall_iss_hz;
    assign  flush_ex_hz_o       = flush_ex_hz;
    assign  fwd_p1_ex_mem_hz_o  = fwd_p1_ex_mem_hz; 
    assign  fwd_p2_ex_mem_hz_o  = fwd_p2_ex_mem_hz; 

endmodule
