//Simple 32-bit shifter

module shifter
    (
        input   wire [31:0]   op1,
        input   wire [4:0]    shamt,
        input   wire [1:0]    operation,
        output  wire [31:0]   res
    );

    reg [31:0] shift_res;
    reg [31:0] sign_bits;

    assign res = shift_res;

    always @ *
    case (operation)
        2'b01: shift_res = (op1 <<  shamt); //logical shift left
        2'b10: shift_res = (op1 >>  shamt); //logical shift right
        2'b11: begin
          // >>> - doesn't seem to be working
          // Use combinational logic to achieve this.
          sign_bits = 32'hFFFFFFFF << (5'h1F - shamt);
          shift_res = (op1 >> shamt);
          shift_res = op1[31] ? sign_bits | shift_res : shift_res;
        end
        default: shift_res = 32'bx;
    endcase

endmodule
