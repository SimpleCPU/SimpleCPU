//Issue the instruction to execute stage

module issue
    (
        input   wire[5:0]   rs_iss_i,
        input   wire[5:0]   rt_iss_i,
        input   wire[5:0]   rd_iss_i,
        input   wire[15:0]  imm_iss_i,
        output  wire[5:0]   rd_reg1_iss_o,
        output  wire[5:0]   rd_reg2_iss_o,
        output  wire[5:0]   wr_reg_iss_o,
        output  wire[31:0]  sign_imm_iss_o
    );

    wire[5:0]   rd_reg1_iss;
    wire[5:0]   rd_reg2_iss;
    wire[5:0]   wr_reg_iss;
    wire[31:0]  sign_imm_iss;

    assign rd_reg1_iss_o  = rd_reg1_iss;
    assign rd_reg2_iss_o  = rd_reg2_iss;
    assign wr_reg_iss_o   = wr_reg_iss;
    assign sign_imm_iss_o = sign_imm_iss;

endmodule
