`ifndef SHA256_CHECKER_SV
`define SHA256_CHECKER_SV
// The SHA256 Message Checker
`include "sha256_compute.sv"

class sha256_checker;

    // Define the message len as a class property
    // Holds the final length of the message
    longint         msg_len;
    // Padded message
    bit [2**20:0]   padded_msg;
    // N holds the number of 512-bit blocks
    longint         N;
    // Hanlde to computation engine
    sha256_compute  compute;

    // New function of the class
    function new (bit [2**20:0] message, longint msg_len, longint N);
        this.padded_msg = message;
        this.msg_len    = msg_len;
        this.N          = N;
    endfunction

    function bit validate_message (bit [255:0] rtl_sha256);
        compute = new (this.padded_msg, this.msg_len, this.N);
        if (compute.hashed_msg == rtl_sha256)
            $display ("TEST PASSED\n");
        else begin
            $display ("TEST FAILED");
            $display ("Expected: %x, Got: %x", compute.hashed_msg, rtl_sha256);
        end
    endfunction

endclass
`endif
