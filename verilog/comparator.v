//Simple 32-bit comparator

module comparator 
    (
        input   wire [31:0]   op1,
        input   wire [31:0]   op2,
        input   wire [2:0]    operation,
        output  wire          res
    );

    reg comp_res;

    always @ *
    case (operation)
        3'b000: comp_res = (op1 ==  op2)    ?   1'b1: 1'b0; 
        3'b001: comp_res = (op1 >=  op2)    ?   1'b1: 1'b0;
        3'b010: comp_res = (op1 >   op2)    ?   1'b1: 1'b0;
        3'b011: comp_res = (op1 <=  op2)    ?   1'b1: 1'b0;
        3'b100: comp_res = (op1 <   op2)    ?   1'b1: 1'b0;
        default: comp_res = 1'bx;
    endcase

    assign res = comp_res;
    
endmodule
