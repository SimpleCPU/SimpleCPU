//Control circuit             
`include "verilog/mips_instr_defines.v"

module control
    (
        input   wire[5:0]   instr_op_ctl_i,
        input   wire[5:0]   instr_funct_ctl_i,
        output  wire        reg_dst_ctl_o,
        output  wire        jump_ctl_o,
        output  wire        branch_ctl_o,
        output  wire        mem_read_ctl_o,
        output  wire        mem_to_reg_ctl_o,
        output  wire[4:0]   alu_op_ctl_o,
        output  wire        mem_wr_ctl_o,
        output  wire        alu_src_ctl_o,
        output  wire        reg_wr_ctl_o
    );

    wire       reg_dst_ctl;
    wire       jump_ctl;
    wire       branch_ctl;
    wire       mem_read_ctl;
    wire       mem_to_reg_ctl;
    wire[4:0]  alu_op_ctl;
    wire       mem_wr_ctl;
    wire       alu_src_ctl;
    wire       reg_wr_ctl;

    reg[12:0]   controls;

    assign  reg_dst_ctl_o        = reg_dst_ctl;
    assign  jump_ctl_o           = jump_ctl;
    assign  branch_ctl_o         = branch_ctl;
    assign  mem_read_ctl_o       = mem_read_ctl;
    assign  mem_to_reg_ctl_o     = mem_to_reg_ctl;
    assign  alu_op_ctl_o         = alu_op_ctl;
    assign  mem_wr_ctl_o         = mem_wr_ctl;
    assign  alu_src_ctl_o        = alu_src_ctl;
    assign  reg_wr_ctl_o         = reg_wr_ctl;


    assign {reg_dst_ctl, jump_ctl, branch_ctl, mem_read_ctl, 
            mem_to_reg_ctl, alu_op_ctl, mem_wr_ctl, alu_src_ctl, reg_wr_ctl} = controls;

    always @ *
    begin
      case (instr_funct_ctl_i)
          //alu_op_ctl: 
          //5'bxx_xx_0: ADD 
          //5'bxx_xx_1: SUB
          //5'bxx_00_x: shift left 
          //5'bxx_01_x: logical shift right 
          //5'bxx_10_x: arithmetic shift right 
          //5'b00_xx_x: logical OR
          //5'b01_xx_x: logical AND
          //5'b10_xx_x: logical NOR
          //5'b11_xx_x: logical XOR
          //reg_dst_ctl, jump_ctl, branch_ctl, mem_read_ctl, mem_to_reg_ctl, alu_op_ctl, mem_wr_ctl, alu_src_ctl, reg_wr_ctl
          `ADD    :   controls = 13'b1_0_0_0_0_xxxx0_0_0_1; // R
          `ADDU   :   controls = 13'b1_0_0_0_0_xxxx0_0_0_1; // R
          `AND    :   controls = 13'b1_0_0_0_0_01xxx_0_0_1; // R
          `DIV    :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `DIVU   :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `JALR   :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `JR     :   controls = 13'b1_0_0_0_0_xxxx0_0_0_1; // R
          `MFHI   :   controls = 13'b1_0_0_0_0_0xxxx_0_0_1; // R
          `MFLO   :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `MTHI   :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `MTLO   :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `MULT   :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `MULTU  :   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `NOR    :   controls = 13'b1_0_0_0_0_10xxx_0_0_1; // R
          `OR     :   controls = 13'b1_0_0_0_0_00xxx_0_0_1; // R
          `SLL    :   controls = 13'b1_0_0_0_0_xx00x_0_0_1; // R
          `SLLV   :   controls = 13'b1_0_0_0_0_xx00x_0_0_1; // R
          `SLT    :   controls = 13'b1_0_0_0_0_xxxx1_0_0_1; // R
          `SLTU   :   controls = 13'b1_0_0_0_0_xxxx1_0_0_1; // R
          `SRA    :   controls = 13'b1_0_0_0_0_xx10x_0_0_1; // R
          `SRAV   :   controls = 13'b1_0_0_0_0_xx10x_0_0_1; // R
          `SRL    :   controls = 13'b1_0_0_0_0_xx01x_0_0_1; // R
          `SRLV   :   controls = 13'b1_0_0_0_0_xx01x_0_0_1; // R
          `SUB    :   controls = 13'b1_0_0_0_0_xxxx1_0_0_1; // R
          `SUBU   :   controls = 13'b1_0_0_0_0_xxxx1_0_0_1; // R
          `SYSCALL:   controls = 13'b1_0_0_0_0_xxxxx_0_0_1; // R
          `XOR    :   controls = 13'b1_0_0_0_0_11xxx_0_0_1; // R
      endcase
      case (instr_op_ctl_i)
        `ADDI   :   controls = 13'b0_0_0_0_0_xxxx0_0_1_1; // I
        `ADDIU  :   controls = 13'b0_0_0_0_0_xxxx0_0_1_1; // I
        `ANDI   :   controls = 13'b0_0_0_0_0_01xxx_0_1_1; // I
        `SLTI   :   controls = 13'b0_0_0_0_0_xxxx1_0_1_1; // I
        `SLTIU  :   controls = 13'b0_0_0_0_0_xxxx1_0_1_1; // I
        `ORI    :   controls = 13'b0_0_0_0_0_00xxx_0_1_1; // I
        `XORI   :   controls = 13'b0_0_0_0_0_11xxx_0_1_1; // I
        `BEQ    :   controls = 13'b0_0_0_1_0_xxxx1_0_1_0; // I
        `BGEZ   :   controls = 13'b0_0_0_1_0_xxxx1_0_1_0; // I
        `BGEZAL :   controls = 13'b0_0_0_1_0_xxxx1_0_1_1; // I
        `BGTZ   :   controls = 13'b0_0_0_1_0_xxxx0_0_1_0; // I
        `BLEZ   :   controls = 13'b0_0_0_1_0_xxxx0_0_1_0; // I
        `BLTZ   :   controls = 13'b0_0_0_1_0_xxxx0_0_1_0; // I
        `BLTZAL :   controls = 13'b0_0_0_1_0_xxxx0_0_1_1; // I
        `BNE    :   controls = 13'b0_0_0_1_0_xxxx1_0_1_0; // I
        `LB     :   controls = 13'b0_0_0_1_1_xxxx0_0_1_1; // I
        `LBU    :   controls = 13'b0_0_0_1_1_xxxx0_0_1_1; // I
        `LH     :   controls = 13'b0_0_0_1_1_xxxx0_0_1_1; // I
        `LHU    :   controls = 13'b0_0_0_1_1_xxxx0_0_1_1; // I
        `LUI    :   controls = 13'b0_0_0_1_1_xxxx0_0_1_1; // I
        `LW     :   controls = 13'b0_0_0_1_1_xxxx0_0_1_1; // I
        `SB     :   controls = 13'b0_0_0_0_0_xxxx0_1_1_0; // I
        `SH     :   controls = 13'b0_0_0_0_0_xxxx0_1_1_0; // I
        `SW     :   controls = 13'b0_0_0_0_0_xxxx0_1_1_0; // I
        `J      :   controls = 13'b0_1_0_0_0_xxxx0_0_1_0; // J
        `JAL    :   controls = 13'b0_1_0_0_0_xxxx0_0_1_1; // J
      endcase
    end
    
endmodule
