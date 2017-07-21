// One-level branch predictor with 2-bit saturating counters
// By default the predictor contains the following entries
//    1024 entries each containing a 2-bit saturating counter
//    Uses 10 LSB (log2(1024)of the PC to index the table

module  one_level_bpred #(
        parameter   NUM_ENTRIES = 1024
    ) (
        input   wire                                clk,
        input   wire                                reset,
        input   wire[$clog2(NUM_ENTRIES) - 1:0]     brn_addr_bpred_i,
        input   wire                                brn_ex_mem_bpred_i,
        input   wire[$clog2(NUM_ENTRIES) - 1:0]     brn_fdback_addr_bpred_i,
        input   wire                                brn_fdback_bpred_i,
        input   wire[31:0]                          brn_btb_addr_bpred_i,
        output  wire                                brn_takeness_bpred_o,
        output  wire[31:0]                          brn_target_addr_bpred_o
    );

    // NUM_ENTRIES wide branch history table
    // consisting of 2-bit saturating counters
    reg  [1:0]  bpred [NUM_ENTRIES -1:0];
    reg  [31:0] btb [NUM_ENTRIES -1:0];

    wire[1:0]   brn_pred_bits;
    wire[1:0]   nxt_brn_pred_bits;
    wire        brn_takeness_bpred;
    wire[31:0]  brn_target_addr_bpred;

    assign  brn_takeness_bpred_o    = brn_takeness_bpred;
    assign  brn_target_addr_bpred_o = brn_target_addr_bpred;

    always @ (posedge clk)
    begin
        // Update the counters only when we have an actual branch
        // since the current prediction bits default to not taken
        if (brn_ex_mem_bpred_i)
        begin
            bpred[brn_fdback_addr_bpred_i] <= nxt_brn_pred_bits;
            // Update the BTB entries only when an incorrect
            // prediction is made
            if (~brn_fdback_bpred_i)
                btb[brn_fdback_addr_bpred_i] <= brn_btb_addr_bpred_i;
        end
    end

    assign  brn_pred_bits = bpred[brn_fdback_addr_bpred_i];
    // Since we are using 2-bit saturating counters. The following applies - 
    // 2'b00 - Not Taken
    // 2'b01 - Not Taken
    // 2'b10 - Taken
    // 2'b11 - Taken
    assign  brn_takeness_bpred      = bpred[brn_addr_bpred_i][1];
    // If branch is predicted to be taken then return the target address
    // from the BTB else default to 0
    // TODO: Instead of defaulting to 0 shouldn't the predicted address be
    // CURRENT_PC + 4 ?
    assign  brn_target_addr_bpred   = brn_takeness_bpred ? btb[brn_addr_bpred_i] : 32'h0;

    two_bit_sat_counter COUNTER (
        .count_i (brn_pred_bits),
        .op (brn_fdback_bpred_i),
        .count (nxt_brn_pred_bits)
    );
    
endmodule
