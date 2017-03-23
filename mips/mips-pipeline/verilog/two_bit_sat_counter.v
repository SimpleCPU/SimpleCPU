// N-bit saturated counter

module two_bit_sat_counter 
    (
        input   wire[1:0] count_i,
        input   wire      op,
        output  reg[1:0]  count
    );

    // The counters work in the following manner
    // op = 0 implies incorrect prediction
    // op = 1 implies correct prediction
    //    op=0
    // 00 -----> 01
    // The above means the prediction made was strongly not taken
    // but the branch was taken. Hence the prediction bits are updated
    //    op=1
    // 00 -----> 00
    // The above means the prediction made was strongly not taken
    // and the branch was also not taken. Hence there is no need
    // to update the prediction bits
    // Similar logic applies for other states as well

    always @ (*)
    begin
        case (count_i)
            // TODO: Use an adder here and just update the op port
            // of the adder for each case
            2'b00:  count = (op) ? count_i          : count_i + 2'b1;
            2'b01:  count = (op) ? count_i - 2'b1   : count_i + 2'b1;
            2'b10:  count = (op) ? count_i + 2'b1   : count_i - 2'b1;
            2'b11:  count = (op) ? count_i          : count_i - 2'b1;
            default count = 2'b0;
        endcase
    end

endmodule
