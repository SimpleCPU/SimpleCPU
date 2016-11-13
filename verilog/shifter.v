//Simple 32-bit shifter
//Would need to improve this for 
//fast operation

module shifter
    (
        input   wire [31:0]   op1,
        input   wire [5:0]    shamt,
        input   wire [1:0]    operation,
        output  wire          res
    );

    reg shift_res;

    always @ *
    case (operation)
        2'b00: shift_res = (op1 >>  shamt); //logical shift right
        2'b01: shift_res = (op1 >>> shamt); //arithmetic shift right
        2'b10: shift_res = (op1 <<  shamt); //logical shift left
        default: shift_res = 1'bx;
    endcase

    assign res = shift_res;
endmodule
