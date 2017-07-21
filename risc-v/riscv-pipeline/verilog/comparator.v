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
        3'b000: comp_res = (op1 ==  op2); 
        3'b010: comp_res = (op1 >   op2);
        3'b101, 
        3'b110: comp_res = (op1 <   op2);
        default: comp_res = 1'bx;
    endcase

    assign res = comp_res;
    
endmodule
