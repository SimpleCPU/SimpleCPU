`ifndef SHA256_PREPROCESSOR_SV
`define SHA256_PREPROCESSOR_SV
// The SHA256 Messge Preprocessor
// This class implements the preprocessing before hash computations.
// The following logic is implemented:
//      - Padding the message
//      - Parsing the padded message into message blocks
//      - Setting the initial hash value

class sha256_preprocessor;

    // Define the message len as a class property
    // Holds the final length of the message
    longint         msg_len;
    // Number of zeros added
    bit [8:0]       num_zeros;
    // Original message
    bit [2**20:0]   message;
    // Padded message
    bit [2**20:0]   padded_msg;
    // N holds the number of 512-bit blocks
    longint         N;
    // Initial Hash value
    // Defined as a multidimensional array
    bit [31:0]      H [7:0];

    // New function for the class
    function new (bit [2**20:0] message, longint msg_len);
        // Assign the class properties
        this.message = message;
        this.msg_len = msg_len;
        // Assign default values
        this.N       = 0;
        // Call the class methods
        set_initial_hash_value ();
        pad_message ();
        parse_message ();
        print_properties ();
    endfunction

    // Initial hash value
    function void set_initial_hash_value ();
        // Set the initial hash value for
        // SHA-256
        H [0] = 32'h6a09e667;
        H [1] = 32'hbb67ae85;
        H [2] = 32'h3c6ef372;
        H [3] = 32'ha54ff53a;
        H [4] = 32'h510e527f;
        H [5] = 32'h9b05688c;
        H [6] = 32'h1f83d9ab;
        H [7] = 32'h5be0cd19;

    endfunction

    // Pad the message
    function void pad_message ();
        // k holds the number of zeros to add
        bit [8:0] k;
        // Padded len to hold value of len
        bit [63:0] padded_len;
        // Calculate k
        k = 'd448 - 1'b1 - (this.msg_len%512);
        // Assign num_zeros variable here
        this.num_zeros = k;
        // Pad the message
        this.padded_msg = {message, 1'b1};
        for (int i=0; i < k; i++) begin
            // Add zeros
            this.padded_msg = {this.padded_msg, 1'b0};
        end
        padded_len = this.msg_len;
        this.padded_msg = {this.padded_msg, padded_len};
        // Calculate the new length of the packet
        this.msg_len = this.msg_len + 1 + k + 64;

    endfunction

    // Parse the padded message
    // Returns the number of 512-bit blocks
    function void parse_message ();
        // Parse the message into 512-bit blocks
        for (int i = this.msg_len; i > 0; i=i-512) begin
            //$display ("M:\t%b", this.padded_msg[i-:512]);
            this.N++;
        end
    endfunction

    // Print properties
    function void print_properties ();
        // Print the relevant class properties
        $display ("Padded message len: %3d", this.msg_len);
        $display ("Number of zeros added: %3d", this.num_zeros);
        $display ("Number of 512-bit blocks: %3d", this.N);
        $display ("Initial hash value:");
        for (int i = 0; i < 8; i++) begin
            $display ("%x", H[i]);
        end
    endfunction

endclass

//module test_class ();
//    
//    sha256_preprocessor sha;
//    bit [2**20:0] msg = 24'h61_62_63;
//    longint len = 24;
//    initial
//    begin
//        sha = new(msg, len);
//        $finish  (1);
//    end
//endmodule
`endif
