`ifndef SHA256_FUNCTION_SV
`define SHA256_FUNCTION_SV
// The SHA256 Function
// This class implements the following functions:
//      - SHR   (x, n)    = x >> n
//      - ROTR  (x, n)    = (x >> n) | (x << (w - n))
//      - ROTL  (x, n)    = (x << n) | (x >> (w - n))
//      - ch    (x, y, z) = (x&y) ^ (~x&z)
//      - maj   (x, y, z) = (x&y) ^ (x&z) ^ (y&z)
//      - sum1  (x)       = ROTR (x, 2) ^ ROTR (x, 13) ^ ROTR (x, 22)
//      - sigma0(x)       = ROTR (x, 7) ^ ROTR (x, 18) ^ SHR (x, 3)
//      - sigma1(x)       = ROTR (x, 17) ^ ROTR (x, 19) ^ SHR (x, 10)

class sha256_function;

    logic [31:0] K [63:0];

    // New method
    function new ();
        // Initialise SHA-256 constants
        K [0]  = 'h428a2f98;
        K [1]  = 'h71374491;
        K [2]  = 'hb5c0fbcf;
        K [3]  = 'he9b5dba5;
        K [4]  = 'h3956c25b;
        K [5]  = 'h59f111f1;
        K [6]  = 'h923f82a4;
        K [7]  = 'hab1c5ed5;
	    K [8]  = 'hd807aa98;
        K [9]  = 'h12835b01;
        K [10] = 'h243185be;
        K [11] = 'h550c7dc3;
        K [12] = 'h72be5d74;
        K [13] = 'h80deb1fe;
        K [14] = 'h9bdc06a7;
        K [15] = 'hc19bf174;
	    K [16] = 'he49b69c1;
        K [17] = 'hefbe4786;
        K [18] = 'h0fc19dc6;
        K [19] = 'h240ca1cc;
        K [20] = 'h2de92c6f;
        K [21] = 'h4a7484aa;
        K [22] = 'h5cb0a9dc;
        K [23] = 'h76f988da;
	    K [24] = 'h983e5152;
        K [25] = 'ha831c66d;
        K [26] = 'hb00327c8;
        K [27] = 'hbf597fc7;
        K [28] = 'hc6e00bf3;
        K [29] = 'hd5a79147;
        K [30] = 'h06ca6351;
        K [31] = 'h14292967;
	    K [32] = 'h27b70a85;
        K [33] = 'h2e1b2138;
        K [34] = 'h4d2c6dfc;
        K [35] = 'h53380d13;
        K [36] = 'h650a7354;
        K [37] = 'h766a0abb;
        K [38] = 'h81c2c92e;
        K [39] = 'h92722c85;
	    K [40] = 'ha2bfe8a1;
        K [41] = 'ha81a664b;
        K [42] = 'hc24b8b70;
        K [43] = 'hc76c51a3;
        K [44] = 'hd192e819;
        K [45] = 'hd6990624;
        K [46] = 'hf40e3585;
        K [47] = 'h106aa070;
	    K [48] = 'h19a4c116;
        K [49] = 'h1e376c08;
        K [50] = 'h2748774c;
        K [51] = 'h34b0bcb5;
        K [52] = 'h391c0cb3;
        K [53] = 'h4ed8aa4a;
        K [54] = 'h5b9cca4f;
        K [55] = 'h682e6ff3;
        K [56] = 'h748f82ee;
        K [57] = 'h78a5636f;
        K [58] = 'h84c87814;
        K [59] = 'h8cc70208;
        K [60] = 'h90befffa;
        K [61] = 'ha4506ceb;
        K [62] = 'hbef9a3f7;
        K [63] = 'hc67178f2;
    endfunction

//  Shift right
//  SHR   (x, n)    = x >> n
    function logic [31:0] SHR (logic [31:0] x, logic [4:0] n);
        return (x >> n);
    endfunction

//  Rotate right
//  ROTR  (x, n)    = (x >> n) | (x << (w - n))
    function logic [31:0] ROTR (logic [31:0] x, logic [4:0] n);
        return ((x >> n) | (x << (32 - n)));
    endfunction

//  Rotate left
//  ROTL  (x, n)    = (x << n) | (x >> (w - n))
    function logic [31:0] ROTL (logic [31:0] x, logic [4:0] n);
        return ((x << n) | (x >> (32 - n)));
    endfunction

//  Ch
//  ch    (x, y, z) = (x&y) ^ (x&z)
    function logic [31:0] ch (logic [31:0] x, logic [31:0] y, logic [31:0] z);
        //$display ("Ch: %x", (x&y)|(~x&z));
        return ((x&y) ^ (~x&z));
    endfunction

//  Maj
//  maj   (x, y, z) = (x&y) ^ (x&z) ^ (y&z)
    function logic [31:0] maj (logic [31:0] x, logic [31:0] y, logic [31:0] z);
        return ((x&y) ^ (x&z) ^ (y&z));
    endfunction

//  Sum0
//  sum0  (x)       = ROTR (x, 2) ^ ROTR (x, 13) ^ ROTR (x, 22)
    function logic [31:0] sum0 (logic [31:0] x);
        return (ROTR (x, 2) ^ ROTR (x, 13) ^ ROTR (x, 22));
    endfunction

//  Sum1
//  sum1  (x)       = ROTR (x, 6) ^ ROTR (x, 11) ^ ROTR (x, 25)
    function logic [31:0] sum1 (logic [31:0] x);
        //$display ("Sum1: %x", ROTR (x, 6) ^ ROTR (x, 11) ^ ROTR (x, 25));
        return (ROTR (x, 6) ^ ROTR (x, 11) ^ ROTR (x, 25));
    endfunction

//  Sigma0
//  sigma0(x)       = ROTR (x, 7) ^ ROTR (x, 18) ^ SHR (x, 3)
    function logic [31:0] sigma0 (logic [31:0] x);
        return (ROTR (x, 7) ^ ROTR (x, 18) ^ SHR (x, 3));
    endfunction

//  Sigma1
//  sigma1(x)       = ROTR (x, 17) ^ ROTR (x, 19) ^ SHR (x, 10)
    function logic [31:0] sigma1 (logic [31:0] x);
        return (ROTR (x, 17) ^ ROTR (x, 19) ^ SHR (x, 10));
    endfunction

endclass
//module test_class ();
//    
//    sha256_function sha;
//    logic [31:0] e, f, g;
//    initial
//    begin
//        e = 'h510e527f;
//        f = 'h9b05688c;
//        g = 'h1f83d9ab;
//        sha = new();
//        sha.sum1(e);
//        sha.ch(e, f, g);
//        $finish  (1);
//    end
//endmodule
`endif
