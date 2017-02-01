// Reduced Full Adder Implementation

module reduced_full_adder
    (
        input   wire    op1,
        input   wire    op2,
        input   wire    cin,
        output  wire    g,
        output  wire    p,
        output  wire    s
    );

    wire    or_out_1;
    wire    or_out_2;
    wire    and_out_1;
    wire    and_out_2;
    wire    and_out_3;
    wire    and_out_4;
    wire    not_out_1;
    wire    not_out_2;

    assign  g = and_out_1;
    assign  p = or_out_1;
    assign  s = and_out_4;

    and     A1 (and_out_1, op1, op2);
    not     N1 (not_out_1, and_out_1);
    or      O1 (or_out_1, op1, op2);
    and     A2 (and_out_2, or_out_1, not_out_1);

    and     A3 (and_out_3, cin, and_out_2);
    not     N2 (not_out_2, and_out_3);
    or      O2 (or_out_2, cin, and_out_2);
    and     A4 (and_out_4, or_out_2, not_out_2);

endmodule
