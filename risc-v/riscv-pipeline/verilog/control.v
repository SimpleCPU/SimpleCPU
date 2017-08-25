//Control circuit             
`include "verilog/riscv_instr_defines.v"

module control
    (
        input   wire[2:0]   instr_funct3_ctl_i,
        input   wire[6:0]   instr_funct7_ctl_i,
        input   wire[6:0]   instr_opcode_ctl_i,
        input   wire        is_r_type_ctl_i,
        input   wire        is_i_type_ctl_i,
        input   wire        is_s_type_ctl_i,
        input   wire        is_b_type_ctl_i,
        input   wire        is_u_type_ctl_i,
        input   wire        is_j_type_ctl_i,
        output  wire[1:0]   pc_sel_ctl_o,
        output  wire[2:0]   op2sel_ctl_o,
        output  wire[1:0]   wb_sel_ctl_o,
        output  wire        pc4_sel_ctl_o,
        output  wire        mem_wr_ctl_o,
        output  wire        cpr_en_ctl_o,
        output  wire        wa_sel_ctl_o,
        output  wire        rf_en_ctl_o,
        output  wire[5:0]   alu_fun_ctl_o
    );

    wire[1:0]   pc_sel_ctl;
    wire[2:0]   op2sel_ctl;
    wire[1:0]   wb_sel_ctl;
    wire        pc4_sel_ctl;
    wire        mem_wr_ctl;
    wire        cpr_en_ctl;
    wire        wa_sel_ctl;
    wire        rf_en_ctl;
    wire[5:0]   alu_fun_ctl;

    wire[4:0]   instr_funct_ctl;
    wire[4:0]   instr_opc_ctl;
    reg[17:0]   controls;

    assign pc_sel_ctl_o     = pc_sel_ctl;
    assign op2sel_ctl_o     = op2sel_ctl;
    assign wb_sel_ctl_o     = wb_sel_ctl;
    assign pc4_sel_ctl_o    = pc4_sel_ctl;
    assign mem_wr_ctl_o     = mem_wr_ctl;
    assign cpr_en_ctl_o     = cpr_en_ctl;
    assign wa_sel_ctl_o     = wa_sel_ctl;
    assign rf_en_ctl_o      = rf_en_ctl;
    assign alu_fun_ctl_o    = alu_fun_ctl;

    assign instr_funct_ctl  = {instr_funct7_ctl_i[5], instr_funct3_ctl_i};
    assign instr_opc_ctl    = {instr_opcode_ctl_i[4], {1'b0, instr_funct3_ctl_i}};
    assign {pc_sel_ctl, op2sel_ctl, wb_sel_ctl, 
            pc4_sel_ctl, mem_wr_ctl, cpr_en_ctl, 
            wa_sel_ctl, rf_en_ctl, alu_fun_ctl} = controls;

    always @ *
    begin
      if (is_r_type_ctl_i)
      begin
        case (instr_funct_ctl)
          //alu_op_ctl: 
          //6'b000_00_0: ADD 
          //6'b000_00_1: SUB
          //6'b000_01_0: shift left 
          //6'b000_10_0: logical shift right 
          //6'b000_11_0: arithmetic shift right 
          //6'b001_00_0: logical OR
          //6'b010_00_0: logical AND
          //6'b011_00_0: logical NOR
          //6'b100_00_0: logical XOR
          //pc_sel_ctl, op2sel_ctl, wb_sel_ctl, pc4_sel_ctl, 
          //mem_wr_ctl, cpr_en_ctl, wa_sel_ctl,rf_en_ctl, alu_fun_ctl 
          `ADD      :   controls = 18'b00_000_01_0_0_0_1_1_000000;
          `AND      :   controls = 18'b00_000_01_0_0_0_1_1_010000;
          `OR       :   controls = 18'b00_000_01_0_0_0_1_1_001000;
          `SLL      :   controls = 18'b00_000_01_0_0_0_1_1_000010;
          `SLT      :   controls = 18'b00_000_01_0_0_0_1_1_000001;
          `SLTU     :   controls = 18'b00_000_01_0_0_0_1_1_000001;
          `SRA      :   controls = 18'b00_000_01_0_0_0_1_1_000110;
          `SRL      :   controls = 18'b00_000_01_0_0_0_1_1_000100;
          `SUB      :   controls = 18'b00_000_01_0_0_0_1_1_000000;
          `XOR      :   controls = 18'b00_000_01_0_0_0_1_1_000001;
          default   :   controls = 18'b00_000_01_0_0_0_1_0_100000;
        endcase
      end

      else if (is_i_type_ctl_i)
      begin
        case (instr_opc_ctl)
          //alu_op_ctl: 
          //6'b000_00_0: ADD 
          //6'b000_00_1: SUB
          //6'b000_01_0: shift left 
          //6'b000_10_0: logical shift right 
          //6'b000_11_0: arithmetic shift right 
          //6'b001_00_0: logical OR
          //6'b010_00_0: logical AND
          //6'b011_00_0: logical NOR
          //6'b100_00_0: logical XOR
          //pc_sel_ctl, op2sel_ctl, wb_sel_ctl, pc4_sel_ctl, 
          //mem_wr_ctl, cpr_en_ctl, wa_sel_ctl,rf_en_ctl, alu_fun_ctl 
          `LB       :   controls = 18'b00_010_01_0_0_0_1_1_000000;
          `LBU      :   controls = 18'b00_010_01_0_0_0_1_1_000000;
          `LH       :   controls = 18'b00_010_01_0_0_0_1_1_000000;
          `LHU      :   controls = 18'b00_010_01_0_0_0_1_1_000000;
          `LW       :   controls = 18'b00_010_01_0_0_0_1_1_000000;
          `ADDI     :   controls = 18'b00_010_01_0_0_0_1_1_000000;
          `ANDI     :   controls = 18'b00_010_01_0_0_0_1_1_010000;
          `ORI      :   controls = 18'b00_010_01_0_0_0_1_1_001000;
          `SLLI     :   controls = 18'b00_010_01_0_0_0_1_1_000010;
          `SRLI     :   controls = 18'b00_010_01_0_0_0_1_1_000100;
          `SLTIU    :   controls = 18'b00_010_01_0_0_0_1_1_000001;
          `SRAI     :   controls = 18'b00_010_01_0_0_0_1_1_000110;
          `XORI     :   controls = 18'b00_010_01_0_0_0_1_1_100000;
          `JALR     :   controls = 18'b10_010_01_1_0_0_1_1_000000;
          default   :   controls = 18'b00_010_01_0_0_0_1_0_000000;
        endcase
      end

      else if (is_s_type_ctl_i)
      begin
        case (instr_funct3_ctl_i)
          //alu_op_ctl: 
          //6'b000_00_0: ADD 
          //6'b000_00_1: SUB
          //6'b000_01_0: shift left 
          //6'b000_10_0: logical shift right 
          //6'b000_11_0: arithmetic shift right 
          //6'b001_00_0: logical OR
          //6'b010_00_0: logical AND
          //6'b011_00_0: logical NOR
          //6'b100_00_0: logical XOR
          //pc_sel_ctl, op2sel_ctl, wb_sel_ctl, pc4_sel_ctl, 
          //mem_wr_ctl, cpr_en_ctl, wa_sel_ctl,rf_en_ctl, alu_fun_ctl 
          `SB       :   controls = 18'b00_101_01_0_1_0_0_0_000000;
          `SH       :   controls = 18'b00_101_01_0_1_0_0_0_000000;
          `SW       :   controls = 18'b00_101_01_0_1_0_0_0_000000;
          default   :   controls = 18'b00_101_01_0_0_0_0_0_000000;
        endcase
      end

      else if (is_b_type_ctl_i)
      begin
        case (instr_funct3_ctl_i)
          //alu_op_ctl: 
          //6'b000_00_0: ADD 
          //6'b000_00_1: SUB
          //6'b000_01_0: shift left 
          //6'b000_10_0: logical shift right 
          //6'b000_11_0: arithmetic shift right 
          //6'b001_00_0: logical OR
          //6'b010_00_0: logical AND
          //6'b011_00_0: logical NOR
          //6'b100_00_0: logical XOR
          //pc_sel_ctl, op2sel_ctl, wb_sel_ctl, pc4_sel_ctl, 
          //mem_wr_ctl, cpr_en_ctl, wa_sel_ctl,rf_en_ctl, alu_fun_ctl 
          `BEQ      :   controls = 18'b01_001_00_0_0_0_0_0_000000;
          `BNE      :   controls = 18'b01_001_00_0_0_0_0_0_000000;
          `BLT      :   controls = 18'b01_001_00_0_0_0_0_0_000000;
          `BGE      :   controls = 18'b01_001_00_0_0_0_0_0_000000;
          `BLTU     :   controls = 18'b01_001_00_0_0_0_0_0_000000;
          `BGEU     :   controls = 18'b01_001_00_0_0_0_0_0_000000;
          default   :   controls = 18'b01_001_00_0_0_0_0_0_000000;
        endcase
      end

      else if (is_u_type_ctl_i)
      begin
        case (instr_opcode_ctl_i)
          //alu_op_ctl: 
          //6'b000_00_0: ADD 
          //6'b000_00_1: SUB
          //6'b000_01_0: shift left 
          //6'b000_10_0: logical shift right 
          //6'b000_11_0: arithmetic shift right 
          //6'b001_00_0: logical OR
          //6'b010_00_0: logical AND
          //6'b011_00_0: logical NOR
          //6'b100_00_0: logical XOR
          //pc_sel_ctl, op2sel_ctl, wb_sel_ctl, pc4_sel_ctl, 
          //mem_wr_ctl, cpr_en_ctl, wa_sel_ctl,rf_en_ctl, alu_fun_ctl 
          `AUIPC    :   controls = 18'b00_011_01_0_0_0_1_1_000000;
          `LUI      :   controls = 18'b00_011_01_0_0_0_1_1_000000;
          default   :   controls = 18'b01_001_00_0_0_0_0_0_000000;
        endcase
      end

      else if (is_j_type_ctl_i)
      begin
          controls = 18'b01_100_01_0_0_0_0_0_000000;
      end
      
      else
      begin
          controls = 18'bx;
      end
    end

endmodule