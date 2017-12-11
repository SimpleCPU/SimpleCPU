`ifndef SHA256_COVERAGE_SV
`define SHA256_COVERAGE_SV
// The SHA256 Coverage Collector
// This class implements and collects functional coverage for the SHA-256 TB

class sha256_coverage;

    // Cover message length. Ensure that both
    // long and small messages are covered.
    longint       msg_len;
    // Number of added zeros
    // For padding the message
    bit [9:0]     padded_zeros;
    // RTL signals to be covered
    // Check that we cover different states
    // for the "cmd" output
    bit [3:0]     cmd_o;
    // Check the generated message covers entire
    // alphabetic ascii range
    bit [7:0] msg_byte;

    // New function for the class
    function new (longint msg_len, bit [9:0] padded_zeros);
        this.msg_len = msg_len;
        this.padded_zeros = padded_zeros;
        // Create all the covergroups
        msg_len_1 = new ();
        num_zeros_1 = new();
        cmd_o_1 = new ();
        ascii_msg_1  = new ();
        msg_len_1.sample();
        num_zeros_1.sample();
    endfunction

    function sample_cmd_o (bit [3:0] cmd_o);
        this.cmd_o = cmd_o;
        cmd_o_1.sample ();
    endfunction

    function sample_msg_byte (bit [7:0] msg_byte);
        this.msg_byte = msg_byte;
        ascii_msg_1.sample ();
    endfunction

    // Covergroups for checking message
    covergroup ascii_msg_1 ;
        coverpoint msg_byte {
            bins valid_ascii = {[8'd65:8'd90], [8'd97:8'd122]};
            bins invalid[] = default;
        }
    endgroup

    // Covergroups for cmd state output
    covergroup cmd_o_1 ;
        coverpoint cmd_o {
            // Covering different state as
            // per the RTL
            bins r_state      = {cmd_o[0]};
            bins w_state      = {cmd_o[1]};
            bins rnd_state    = {cmd_o[2]};
            bins busy_state   = {cmd_o[3]};
        }
    endgroup

    // Covergroups for message length
    // Coverage even should be message length
    covergroup msg_len_1 ;
        coverpoint msg_len {
            // Long message bin
            bins long  = {[512:$]};
            // Small message bin
            bins small_1 = {[0:511]};
        }
    endgroup

    // Covergroups for the number of zeros added
    covergroup num_zeros_1 ;
        coverpoint padded_zeros {
            bins valid    = {[0:511]};
            bins others[] = default;
        }
    endgroup

endclass
`endif
