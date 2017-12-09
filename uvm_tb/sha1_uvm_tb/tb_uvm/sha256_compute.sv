`ifndef SHA256_COMPUTE_SV
`define SHA256_COMPUTE_SV
// The SHA256 Computation Engine
// This class implements the hash computations on the padded message.
`include "sha256_function.sv"

class sha256_compute extends sha256_function;

    // Message
    bit [2**20:0]   message;
    // Message length
    longint         msg_len;
    // Hashed Message
    bit [255:0]     hashed_msg;

    // Local variables
    // Message schedule of 64 32-bit words
    logic [31:0]      W [63:0];
    // Eight working variables
    logic [31:0]      a;
    logic [31:0]      b;
    logic [31:0]      c;
    logic [31:0]      d;
    logic [31:0]      e;
    logic [31:0]      f;
    logic [31:0]      g;
    logic [31:0]      h;
    // Two temporary variables
    logic [31:0]      T1;
    logic [31:0]      T2;

    logic [31:0]      H[7:0];
    longint           N;

    function new (bit [2**20:0] message, longint len, longint N);
        this.message = message;
        this.msg_len = len;
        this.N = N;
        this.H [0] = 32'h6a09e667;
        this.H [1] = 32'hbb67ae85;
        this.H [2] = 32'h3c6ef372;
        this.H [3] = 32'ha54ff53a;
        this.H [4] = 32'h510e527f;
        this.H [5] = 32'h9b05688c;
        this.H [6] = 32'h1f83d9ab;
        this.H [7] = 32'h5be0cd19;
        compute_hash();
    endfunction

    // Computation Engine
    function void compute_hash ();
        int k = 0;
        int l = this.N-1;
        // Process each of the message block
        for (int i = 0; i < this.N; i++) begin
            int j = 511;
            // Form the initial 16 message schedules
            for (k = 0; k < 16; k++) begin
                this.W[k] = this.message[((512*l)+j)-:32];
                //$display ("W[%0d] msg[%3d:%3d]", k,((512*l)+j), ((512*l)+j)-31);
                j = j - 32;
            end
            l--;
            // Initialise the eight working variables
            this.a = this.H[0];
            this.b = this.H[1];
            this.c = this.H[2];
            this.d = this.H[3];
            this.e = this.H[4];
            this.f = this.H[5];
            this.g = this.H[6];
            this.h = this.H[7];
            for (int t = 0; t < 64; t++) begin
                if (t > 15) begin
                    this.W [t] = (sigma1(this.W[t-2]) + this.W[t-7] + sigma0(this.W[t-15]) + this.W[t-16]);
                end
                this.T1 = (this.h + sum1 (this.e) + ch (this.e, this.f, this.g) + K[t] + this.W[t]); // 54DA50E8 ffcd6031
                //$display ("T1 is %x\tW[t]: %x", this.T1, this.W[t]);
                this.T2 = (sum0 (this.a) + maj (this.a, this.b, this.c));
                this.h  = this.g;
                this.g  = this.f;
                this.f  = this.e;
                this.e  = (this.d + this.T1);
                //$display ("E[%0d]: %x", t, this.e);
                this.d  = this.c;
                this.c  = this.b;
                this.b  = this.a;
                this.a  = (this.T1 + this.T2);
            end
            this.H[0] = this.a + this.H[0];
            this.H[1] = this.b + this.H[1];
            this.H[2] = this.c + this.H[2];
            this.H[3] = this.d + this.H[3];
            this.H[4] = this.e + this.H[4];
            this.H[5] = this.f + this.H[5];
            this.H[6] = this.g + this.H[6];
            this.H[7] = this.h + this.H[7];
        end
        // Compute the final hash value
        // Copy the final value of the hash
        k = 0;
        for (int i = 255; i >= 0; i=i-32) begin
            hashed_msg [i-:32] = this.H[k];
            //$display ("%8x\n", hashed_msg[i-:32]);
            k++;
        end
    endfunction

endclass

//module test_class ();
//    
//    sha256_compute sha;
//    bit [2**20:0] msg;
//    longint len;
//    sha256_generator sha_gen;
//    initial
//    begin
//        sha_gen = new();
//        void'(sha_gen.randomize());
//        sha_gen.generate_msg();
//        sha = new(sha_gen.message, sha_gen.msg_len);
//        $finish  (1);
//    end
//endmodule
`endif
