//Control circuit             
`include "verilog/mips_defines.v"

module control
    (
        input   wire[5:0]   instr_op_ctl_i,
        input   wire[5:0]   instr_funct_ctl_i,
        output  wire        reg_dst_ctl_o,
        output  wire        jump_ctl_o,
        output  wire        branch_ctl_o,
        output  wire        mem_read_ctl_o,
        output  wire        mem_to_reg_ctl_o,
        output  wire[3:0]   alu_op_ctl_o,
        output  wire        mem_wr_ctl_o,
        output  wire        alu_src_ctl_o,
        output  wire        reg_wr_ctl_o
    );

    wire       reg_dst_ctl;
    wire       jump_ctl;
    wire       branch_ctl;
    wire       mem_read_ctl;
    wire       mem_to_reg_ctl;
    wire[3:0]  alu_op_ctl;
    wire       mem_wr_ctl;
    wire       alu_src_ctl;
    wire       reg_wr_ctl;

    reg[11:0]   controls;

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
          //4'b0000: ADD 
          //4'b0001: SUB
          //4'b0010: shift left 
          //4'b0011: logical shift right 
          //4'b0100: arithmetic shift right 
          //4'b0101: logical OR
          //4'b0110: logical AND
          //4'b0111: logical NOR
          //4'b1000: logical XOR
          //reg_dst_ctl, jump_ctl, branch_ctl, mem_read_ctl, mem_to_reg_ctl, alu_op_ctl, mem_wr_ctl, alu_src_ctl, reg_wr_ctl
          `ADD    :   controls = 12'b1_0_0_0_0_0000_0_0_1; // R
          `ADDU   :   controls = 12'b1_0_0_0_0_0000_0_0_1; // R
          `AND    :   controls = 12'b1_0_0_0_0_0110_0_0_1; // R
          `DIV    :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `DIVU   :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `JALR   :   controls = 12'b1_0_0_0_0_0000_0_0_1; // R
          `JR     :   controls = 12'b1_0_0_0_0_0000_0_0_1; // R
          `MFHI   :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `MFLO   :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `MTHI   :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `MTLO   :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `MULT   :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `MULTU  :   controls = 12'b1_0_0_0_0_xxxx_0_0_1; // R
          `NOR    :   controls = 12'b1_0_0_0_0_0111_0_0_1; // R
          `OR     :   controls = 12'b1_0_0_0_0_0101_0_0_1; // R
          `SLL    :   controls = 12'b1_0_0_0_0_0010_0_0_1; // R
          `SLLV   :   controls = 12'b1_0_0_0_0_0010_0_0_1; // R
          `SLT    :   controls = 12'b1_0_0_0_0_0001_0_0_1; // R
          `SLTU   :   controls = 12'b1_0_0_0_0_0001_0_0_1; // R
          `SRA    :   controls = 12'b1_0_0_0_0_0100_0_0_1; // R
          `SRAV   :   controls = 12'b1_0_0_0_0_0100_0_0_1; // R
          `SRL    :   controls = 12'b1_0_0_0_0_0011_0_0_1; // R
          `SRLV   :   controls = 12'b1_0_0_0_0_0011_0_0_1; // R
          `SUB    :   controls = 12'b1_0_0_0_0_0001_0_0_1; // R
          `SUBU   :   controls = 12'b1_0_0_0_0_0001_0_0_1; // R
          `SYSCALL:   controls = 12'b1_0_0_0_0_0000_0_0_1; // R
          `XOR    :   controls = 12'b1_0_0_0_0_1000_0_0_1; // R
      endcase
      case (instr_op_ctl_i)
        `ADDI   :   controls = 12'b0_0_0_0_0_0000_0_1_1; // I
        `ADDIU  :   controls = 12'b0_0_0_0_0_0000_0_1_1; // I
        `ANDI   :   controls = 12'b0_0_0_0_0_0110_0_1_1; // I
        `SLTI   :   controls = 12'b0_0_0_0_0_0001_0_1_1; // I
        `SLTIU  :   controls = 12'b0_0_0_0_0_0001_0_1_1; // I
        `ORI    :   controls = 12'b0_0_0_0_0_0101_0_1_1; // I
        `XORI   :   controls = 12'b0_0_0_0_0_1000_0_1_1; // I
        `BEQ    :   controls = 12'b0_0_0_1_0_0000_0_1_0; // I
        `BGEZ   :   controls = 12'b0_0_0_1_0_0000_0_1_0; // I
        `BGEZAL :   controls = 12'b0_0_0_1_0_0000_0_1_1; // I
        `BGTZ   :   controls = 12'b0_0_0_1_0_0000_0_1_0; // I
        `BLEZ   :   controls = 12'b0_0_0_1_0_0000_0_1_0; // I
        `BLTZ   :   controls = 12'b0_0_0_1_0_0000_0_1_0; // I
        `BLTZAL :   controls = 12'b0_0_0_1_0_0000_0_1_1; // I
        `BNE    :   controls = 12'b0_0_0_1_0_0000_0_1_0; // I
        `LB     :   controls = 12'b0_0_0_1_1_0000_0_1_1; // I
        `LBU    :   controls = 12'b0_0_0_1_1_0000_0_1_1; // I
        `LH     :   controls = 12'b0_0_0_1_1_0000_0_1_1; // I
        `LHU    :   controls = 12'b0_0_0_1_1_0000_0_1_1; // I
        `LUI    :   controls = 12'b0_0_0_1_1_0000_0_1_1; // I
        `LW     :   controls = 12'b0_0_0_1_1_0000_0_1_1; // I
        `SB     :   controls = 12'b0_0_0_0_0_0000_1_1_0; // I
        `SH     :   controls = 12'b0_0_0_0_0_0000_1_1_0; // I
        `SW     :   controls = 12'b0_0_0_0_0_0000_1_1_0; // I
        `J      :   controls = 12'b0_1_0_0_0_0000_0_1_0; // J
        `JAL    :   controls = 12'b0_1_0_0_0_0000_0_1_1; // J
      endcase
    end
    
endmodule
