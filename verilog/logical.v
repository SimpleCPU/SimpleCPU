// Logical computation unit

module logical 
    (
        input   wire[31:0]  op1,
        input   wire[31:0]  op2,
        input   wire[1:0]   operation,
        output  wire[31:0]  res
    );

    reg[31:0]   res_logical;

    assign res = res_logical;

    always @ *
    case (operation)
        2'b00 : res_logical = op1 | op2;
        2'b01 : res_logical = op1 & op2; 
        2'b10 : res_logical = ~(op1 | op2);
        2'b11 : res_logical = op1 ^ op2;
    endcase

endmodule
