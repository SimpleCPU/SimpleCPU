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
    // Various internal variables should be flipped
    logic [31:0]  a;
    logic [31:0]  b;
    logic [31:0]  c;
    logic [31:0]  d;
    logic [31:0]  e;
    logic [31:0]  f;
    logic [31:0]  g;
    logic [31:0]  h;

    // New function for the class
    function new ();
        // Create all the covergroups
    endfunction

    // Covergroups for message length
    // Coverage even should be message length
    covergroup msg_len_1 @(msg_len);
        coverpoint msg_len {
            // Long message bin
            bins long  = {[512:$]};
            // Small message bin
            bins small_1 = {[0:511]};
        }
    endgroup

    // Covergroups for the number of zeros added
    covergroup num_zeros_1 @(padded_zeros);
        coverpoint padded_zeros {
            bins valid    = {[0:511]};
            bins others[] = default;
        }
    endgroup

endclass
`endif
