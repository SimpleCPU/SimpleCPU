`ifndef SHA256_FUNCTION_SV
`define SHA256_FUNCTION_SV
// The SHA256 Function
// This class implements the following functions:
//      - SHR   (x, n)    = x >> n
//      - ROTR  (x, n)    = (x >> n) | (x << (w - n))
//      - ROTL  (x, n)    = (x << n) | (x >> (w - n))
//      - ch    (x, y, z) = (x&y) ^ (x&z)
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
        K [1]  = 'hd807aa98;
        K [2]  = 'he49b69c1;
        K [3]  = 'h983e5152;
        K [4]  = 'h27b70a85;
        K [5]  = 'ha2bfe8a1;
        K [6]  = 'h19a4c116;
        K [7]  = 'h748f82ee;
        K [8]  = 'h71374491;
        K [9]  = 'h12835b01;
        K [10] = 'hefbe4786;
        K [11] = 'ha831c66d;
        K [12] = 'h2e1b2138;
        K [13] = 'ha81a664b;
        K [14] = 'h1e376c08;
        K [15] = 'h78a5636f;
        K [16] = 'hb5c0fbcf;
        K [17] = 'h243185be;
        K [18] = 'h0fc19dc6;
        K [19] = 'hb00327c8;
        K [20] = 'h4d2c6dfc;
        K [21] = 'hc24b8b70;
        K [22] = 'h2748774c;
        K [23] = 'h84c87814;
        K [24] = 'he9b5dba5;
        K [25] = 'h550c7dc3;
        K [26] = 'h240ca1cc;
        K [27] = 'hbf597fc7;
        K [28] = 'h53380d13;
        K [29] = 'hc76c51a3;
        K [30] = 'h34b0bcb5;
        K [31] = 'h8cc70208;
        K [32] = 'h3956c25b;
        K [33] = 'h72be5d74;
        K [34] = 'h2de92c6f;
        K [35] = 'hc6e00bf3;
        K [36] = 'h650a7354;
        K [37] = 'hd192e819;
        K [38] = 'h391c0cb3;
        K [39] = 'h90befffa;
        K [40] = 'h59f111f1;
        K [41] = 'h80deb1fe;
        K [42] = 'h4a7484aa;
        K [43] = 'hd5a79147;
        K [44] = 'h766a0abb;
        K [45] = 'hd6990624;
        K [46] = 'h4ed8aa4a;
        K [47] = 'ha4506ceb;
        K [48] = 'h923f82a4;
        K [49] = 'h9bdc06a7;
        K [50] = 'h5cb0a9dc;
        K [51] = 'h06ca6351;
        K [52] = 'h81c2c92e;
        K [53] = 'hf40e3585;
        K [54] = 'h5b9cca4f;
        K [55] = 'hbef9a3f7;
        K [56] = 'hab1c5ed5;
        K [57] = 'hc19bf174;
        K [58] = 'h76f988da;
        K [59] = 'h14292967;
        K [60] = 'h92722c85;
        K [61] = 'h106aa070;
        K [62] = 'h682e6ff3;
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
        return ((x&y) ^ (x&z));
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
//        g = 'hff83d9ab;
//        sha = new();
//        sha.SHR(g, 21);
//        $finish  (1);
//    end
//endmodule
`endif
