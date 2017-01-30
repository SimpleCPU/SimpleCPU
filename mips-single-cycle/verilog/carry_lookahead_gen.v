// Carry lookahead generator Implementation:
// Using 4-bit g and p signals as otherwise the fanout 
// of the or gates increases significantly

module carry_lookahead_gen 
    (
        input   wire[3:0]   g,
        input   wire[3:0]   p,
        input   wire        cin,
        output  wire[3:0]   cout
        //output  wire        gout,
        //output  wire        pout
    );

    wire    and_out_1;
    wire    and_out_2;
    wire    and_out_3;
    wire    and_out_4;
    wire    and_out_5;
    wire    and_out_6;
    wire    or_out_1;
    wire    or_out_2;
    wire    or_out_3;
    //wire    and_out_7;
    //wire    and_out_8;
    //wire    and_out_9;
    //wire    and_out_10;
    //wire    or_out_4;

    assign  cout = {or_out_3, or_out_2, or_out_1, cin};
    //assign  pout = and_out_10;
    //assign  gout = or_out_4;

    and     A1 (and_out_1, p[0], cin);
    or      O1 (or_out_1, g[0], and_out_1);

    and     A2 (and_out_2, p[1], g[0]);
    and     A3 (and_out_3, p[1], p[0], cin);
    or      O2 (or_out_2, g[1], and_out_3, and_out_2);

    and     A4 (and_out_4, p[2], g[1]);
    and     A5 (and_out_5, p[2], p[1], g[0]);
    and     A6 (and_out_6, p[2], p[1], p[0], cin);
    or      O3 (or_out_3, g[2], and_out_6, and_out_5, and_out_4);

    // This is used for calculating the gout and pout signals
    //and     A7(and_out_7, p[3], g[2]);
    //and     A8(and_out_8, p[3], p[2], g[1]);
    //and     A9(and_out_9, p[3], p[2], p[1], g[0]);
    //or      O4(or_out_4, g[3], and_out_7, and_out_8, and_out_9);
    //and     A10(and_out_10, p[3], p[2], p[1], p[0]);

endmodule
