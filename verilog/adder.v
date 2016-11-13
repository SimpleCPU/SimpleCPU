//Simple 32-bit adder
//Would need to improve this for 
//fast additions

module adder 
    (
        input   wire [31:0]   op1,
        input   wire [31:0]   op2,
        input   wire          cin,
        output  wire [31:0]   sum,
        output  wire          carry
    );

    assign {carry, sum} = op1 + op2 + cin;

endmodule
