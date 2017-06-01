// 4-bit carry lookahead adder

module carry_lookahead_adder
    (
        input   wire[3:0]   op1,
        input   wire[3:0]   op2,
        input   wire        cin,
        output  wire[3:0]   s,
        output  wire        cout,
        output  wire        v
    );

    wire[3:0]   g;
    wire[3:0]   p;
    wire[3:0]   gen_cout;

    assign  cout = g[3] | (p[3] & gen_cout[3]);
    assign  v    = gen_cout[3] ^ cout;

    reduced_full_adder  RFA0(op1[0], op2[0], cin,         g[0], p[0], s[0]);
    reduced_full_adder  RFA1(op1[1], op2[1], gen_cout[1], g[1], p[1], s[1]);
    reduced_full_adder  RFA2(op1[2], op2[2], gen_cout[2], g[2], p[2], s[2]);
    reduced_full_adder  RFA3(op1[3], op2[3], gen_cout[3], g[3], p[3], s[3]);

    carry_lookahead_gen CLG1(g, p, cin, gen_cout);

endmodule
