//Simple 32-bit shifter

module shifter
    (
        input   wire [31:0]   op1,
        input   wire [4:0]    shamt,
        input   wire [1:0]    operation,
        output  wire [31:0]   res
    );

    reg [31:0] shift_res;

    assign res = shift_res;

    always @ *
    case (operation)
        2'b01: shift_res = (op1 <<  shamt); //logical shift left
        2'b10: shift_res = (op1 >>  shamt); //logical shift right
        2'b11: shift_res = (op1 >>> shamt); //arithmetic shift right
        default: shift_res = 31'bx;
    endcase

endmodule
