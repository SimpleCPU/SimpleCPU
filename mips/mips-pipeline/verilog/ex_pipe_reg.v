// Issue-Execute Pipeline Register

module ex_pipe_reg
    (
        input   wire        clk,
        input   wire        reset,
        input   wire        clr,
        input   wire        valid_ex_pipe_reg_i,
        input   wire[5:0]   op_ex_pipe_reg_i,
        input   wire        branch_ex_pipe_reg_i,
        input   wire        reg_wr_ex_pipe_reg_i,
        input   wire        mem_to_reg_ex_pipe_reg_i,
        input   wire        mem_wr_ex_pipe_reg_i,
        input   wire[5:0]   alu_op_ex_pipe_reg_i,
        input   wire[2:0]   alu_src_ex_pipe_reg_i,
        input   wire        reg_dst_ex_pipe_reg_i,
        input   wire[4:0]   rt_ex_pipe_reg_i,
        input   wire[4:0]   rs_ex_pipe_reg_i,
        input   wire[4:0]   rd_ex_pipe_reg_i,
        input   wire[31:0]  r_data_p1_ex_pipe_reg_i,
        input   wire[31:0]  r_data_p2_ex_pipe_reg_i,
        input   wire[31:0]  brn_eq_pc_ex_pipe_reg_i,
        input   wire[31:0]  sign_imm_ex_pipe_reg_i,
        input   wire[5:0]   shamt_ex_pipe_reg_i,
        output  wire        valid_ex_pipe_reg_o,
        input   wire[5:0]   op_ex_pipe_reg_o,
        input   wire        branch_ex_pipe_reg_o,
        output  wire        reg_wr_ex_pipe_reg_o,
        output  wire        mem_to_reg_ex_pipe_reg_o,
        output  wire        mem_wr_ex_pipe_reg_o,
        output  wire[5:0]   alu_op_ex_pipe_reg_o,
        output  wire[2:0]   alu_src_ex_pipe_reg_o,
        output  wire        reg_dst_ex_pipe_reg_o,
        output  wire[4:0]   rt_ex_pipe_reg_o,
        output  wire[4:0]   rs_ex_pipe_reg_o,
        output  wire[4:0]   rd_ex_pipe_reg_o,
        output  wire[31:0]  r_data_p1_ex_pipe_reg_o,
        output  wire[31:0]  r_data_p2_ex_pipe_reg_o,
        input   wire[31:0]  brn_eq_pc_ex_pipe_reg_o,
        output  wire[31:0]  sign_imm_ex_pipe_reg_o,
        output  wire[5:0]   shamt_ex_pipe_reg_o
    );

    reg        valid_ex_pipe_reg;
    reg[5:0]   op_ex_pipe_reg;
    reg        branch_ex_pipe_reg;
    reg        reg_wr_ex_pipe_reg;
    reg        mem_to_reg_ex_pipe_reg;
    reg        mem_wr_ex_pipe_reg;
    reg[5:0]   alu_op_ex_pipe_reg;
    reg[2:0]   alu_src_ex_pipe_reg;
    reg        reg_dst_ex_pipe_reg;
    reg[4:0]   rt_ex_pipe_reg;
    reg[4:0]   rs_ex_pipe_reg;
    reg[4:0]   rd_ex_pipe_reg;
    reg[31:0]  r_data_p1_ex_pipe_reg;
    reg[31:0]  r_data_p2_ex_pipe_reg;
    reg[31:0]  brn_eq_pc_ex_pipe_reg;
    reg[31:0]  sign_imm_ex_pipe_reg;
    reg[5:0]   shamt_ex_pipe_reg;

    assign valid_ex_pipe_reg_o          =  valid_ex_pipe_reg;
    assign op_ex_pipe_reg_o             =  op_ex_pipe_reg;
    assign branch_ex_pipe_reg_o         =  branch_ex_pipe_reg;
    assign reg_wr_ex_pipe_reg_o         =  reg_wr_ex_pipe_reg;
    assign mem_to_reg_ex_pipe_reg_o     =  mem_to_reg_ex_pipe_reg;
    assign mem_wr_ex_pipe_reg_o         =  mem_wr_ex_pipe_reg;
    assign alu_op_ex_pipe_reg_o         =  alu_op_ex_pipe_reg;
    assign alu_src_ex_pipe_reg_o        =  alu_src_ex_pipe_reg;
    assign reg_dst_ex_pipe_reg_o        =  reg_dst_ex_pipe_reg;
    assign rt_ex_pipe_reg_o             =  rt_ex_pipe_reg;
    assign rs_ex_pipe_reg_o             =  rs_ex_pipe_reg;
    assign rd_ex_pipe_reg_o             =  rd_ex_pipe_reg;
    assign r_data_p1_ex_pipe_reg_o      =  r_data_p1_ex_pipe_reg;
    assign r_data_p2_ex_pipe_reg_o      =  r_data_p2_ex_pipe_reg;
    assign brn_eq_pc_ex_pipe_reg_o      =  brn_eq_pc_ex_pipe_reg;
    assign sign_imm_ex_pipe_reg_o       =  sign_imm_ex_pipe_reg;
    assign shamt_ex_pipe_reg_o          =  shamt_ex_pipe_reg;

    always @(posedge clk or posedge reset)
    if (reset | clr)
    begin
        valid_ex_pipe_reg          <=  0;
        op_ex_pipe_reg             <=  0;
        branch_ex_pipe_reg         <=  0;
        reg_wr_ex_pipe_reg         <=  0;
        mem_to_reg_ex_pipe_reg     <=  0;
        mem_wr_ex_pipe_reg         <=  0;
        alu_op_ex_pipe_reg         <=  0;
        alu_src_ex_pipe_reg        <=  0;
        reg_dst_ex_pipe_reg        <=  0;
        rt_ex_pipe_reg             <=  0;
        rs_ex_pipe_reg             <=  0;
        rd_ex_pipe_reg             <=  0;
        r_data_p1_ex_pipe_reg      <=  0;
        r_data_p2_ex_pipe_reg      <=  0;
        brn_eq_pc_ex_pipe_reg      <=  0;
        sign_imm_ex_pipe_reg       <=  0;
        shamt_ex_pipe_reg          <=  0;
    end
    else
    begin
        valid_ex_pipe_reg          <=  valid_ex_pipe_reg_i;
        op_ex_pipe_reg             <=  op_ex_pipe_reg_i;
        branch_ex_pipe_reg         <=  branch_ex_pipe_reg_i;
        reg_wr_ex_pipe_reg         <=  reg_wr_ex_pipe_reg_i;
        mem_to_reg_ex_pipe_reg     <=  mem_to_reg_ex_pipe_reg_i;
        mem_wr_ex_pipe_reg         <=  mem_wr_ex_pipe_reg_i;
        alu_op_ex_pipe_reg         <=  alu_op_ex_pipe_reg_i;
        alu_src_ex_pipe_reg        <=  alu_src_ex_pipe_reg_i;
        reg_dst_ex_pipe_reg        <=  reg_dst_ex_pipe_reg_i;
        rt_ex_pipe_reg             <=  rt_ex_pipe_reg_i;
        rs_ex_pipe_reg             <=  rs_ex_pipe_reg_i;
        rd_ex_pipe_reg             <=  rd_ex_pipe_reg_i;
        r_data_p1_ex_pipe_reg      <=  r_data_p1_ex_pipe_reg_i;
        r_data_p2_ex_pipe_reg      <=  r_data_p2_ex_pipe_reg_i;
        brn_eq_pc_ex_pipe_reg      <=  brn_eq_pc_ex_pipe_reg_i;
        sign_imm_ex_pipe_reg       <=  sign_imm_ex_pipe_reg_i;
        shamt_ex_pipe_reg          <=  shamt_ex_pipe_reg_i;
    end

endmodule
