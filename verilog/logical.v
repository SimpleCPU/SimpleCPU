// Logical computation unit

module logical 
    (
        input   wire[31:0]  op1,
        input   wire[31:0]  op2,
        input   wire[2:0]   operation,
        output  wire[31:0]  res
    );

    reg[31:0]   res_logical;

    assign res = res_logical;

    always @ *
    case (operation)
        3'b001 : res_logical = op1 | op2;
        3'b010 : res_logical = op1 & op2; 
        3'b011 : res_logical = ~(op1 | op2);
        3'b100 : res_logical = op1 ^ op2;
        default: res_logical = 31'hxxxx_xxxx;
    endcase

endmodule
