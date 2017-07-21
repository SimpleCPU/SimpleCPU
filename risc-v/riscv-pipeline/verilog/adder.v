// 32-bit adder
// Using Carry Lookahead adders

module adder 
    (
        input   wire [31:0]   op1,
        input   wire [31:0]   op2,
        input   wire          cin,
        output  wire [31:0]   sum,
        output  wire          carry,
        output  wire          v_flag
    );

    wire[6:0]  cout;
    wire[7:0]  flag_v;

    assign  v_flag = flag_v[7];
    
    carry_lookahead_adder CLA1(op1[3:0],   op2[3:0],    cin,     sum[3:0],   cout[0], flag_v[0]);
    carry_lookahead_adder CLA2(op1[7:4],   op2[7:4],    cout[0], sum[7:4],   cout[1], flag_v[1]);
    carry_lookahead_adder CLA3(op1[11:8],  op2[11:8],   cout[1], sum[11:8],  cout[2], flag_v[2]);
    carry_lookahead_adder CLA4(op1[15:12], op2[15:12],  cout[2], sum[15:12], cout[3], flag_v[3]);
    carry_lookahead_adder CLA5(op1[19:16], op2[19:16],  cout[3], sum[19:16], cout[4], flag_v[4]);
    carry_lookahead_adder CLA6(op1[23:20], op2[23:20],  cout[4], sum[23:20], cout[5], flag_v[5]);
    carry_lookahead_adder CLA7(op1[27:24], op2[27:24],  cout[5], sum[27:24], cout[6], flag_v[6]);
    carry_lookahead_adder CLA8(op1[31:28], op2[31:28],  cout[6], sum[31:28], carry, flag_v[7]);

endmodule
