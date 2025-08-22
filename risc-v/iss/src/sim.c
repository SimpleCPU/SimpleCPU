#include <stdio.h>
#include "main.h"

int decode_instr_type (uint32_t instr_opcode) {
    int type;
    if ((instr_opcode & 0x7F) == 0x33) {        // R-Type
        type = R_TYPE;
        return type;
    }
    else if (((instr_opcode & 0x7F) == 0x13) ||
             ((instr_opcode & 0x7F) == 0x67) ||
             ((instr_opcode & 0x7F) == 0x03)) { // I-Type
        type = I_TYPE;
        return type;
    }
    else if ((instr_opcode & 0x7F) == 0x23) {   // S-Type
        type = S_TYPE;
        return type;
    }
    else if ((instr_opcode & 0x7F) == 0x63) {   // B-Type
        type = B_TYPE;
        return type;
    }
    else if (((instr_opcode & 0x7F) == AUIPC) || 
             ((instr_opcode & 0x7F) == LUI)) { // U-Type
        type = U_TYPE;
        return type;
    }
    else if ((instr_opcode & 0x7F) == 0x6F) {  // J-Type
        type = J_TYPE;
        return type;
    }
    printf("No valid type found for instruction: 0x%-.8x\n", instr_opcode);
    type = -1;
    RUN_BIT = 0;
    return type;
}

int shift_const (unsigned int shamt) {
    switch (shamt) {
        case 1 : return 0x80000000;          case 2 : return 0xC0000000;          case 3 : return 0xE0000000;          case 4 : return 0xF0000000;
        case 5 : return 0xF8000000;          case 6 : return 0xFC000000;          case 7 : return 0xFE000000;          case 8 : return 0xFF000000;
        case 9 : return 0xFF800000;          case 10: return 0xFFC00000;          case 11: return 0xFFE00000;          case 12: return 0xFFF00000;
        case 13: return 0xFFF80000;          case 14: return 0xFFFC0000;          case 15: return 0xFFFE0000;          case 16: return 0xFFFF0000;
        case 17: return 0xFFFF8000;          case 18: return 0xFFFFC000;          case 19: return 0xFFFFE000;          case 20: return 0xFFFFF000;
        case 21: return 0xFFFFF800;          case 22: return 0xFFFFFC00;          case 23: return 0xFFFFFE00;          case 24: return 0xFFFFFF00;
        case 25: return 0xFFFFFF80;          case 26: return 0xFFFFFFC0;          case 27: return 0xFFFFFFE0;          case 28: return 0xFFFFFFF0;
        case 29: return 0xFFFFFFF8;          case 30: return 0xFFFFFFFC;          case 31: return 0xFFFFFFFE;          case 0 : return 0x00000000;
    }
    return 0;
}


void execute_r (uint32_t rs1, uint32_t rs2, uint32_t rd, unsigned int funct7, unsigned int funct3) {
    int sign;
    int shift_val;
    unsigned int funct = ((funct7>>5 & 0x1) << 3) | funct3;
    if (rd == 0) {
        NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        return;
    }
    switch (funct) {
        case (SLL): //SLL
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] << (CURRENT_STATE.REGS[rs2] & 0x1F);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLL X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (SRL): //SRL
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] >> (CURRENT_STATE.REGS[rs2] & 0x1F);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRL X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (SRA): //SRA
            sign = (CURRENT_STATE.REGS[rs1])>>31;
            shift_val = shift_const((CURRENT_STATE.REGS[rs2] & 0x1F));
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] >> (CURRENT_STATE.REGS[rs2] & 0x1F);
            NEXT_STATE.REGS[rd] = (sign == 1) ? NEXT_STATE.REGS[rd] | shift_val: NEXT_STATE.REGS[rd]; 
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRA X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (ADD): //ADD
            NEXT_STATE.REGS[rd] = (int32_t)(CURRENT_STATE.REGS[rs1] + CURRENT_STATE.REGS[rs2]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t ADD X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (SUB): //SUB
            NEXT_STATE.REGS[rd] = (int32_t)(CURRENT_STATE.REGS[rs1] - CURRENT_STATE.REGS[rs2]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SUB X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (AND): //AND
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] & CURRENT_STATE.REGS[rs2];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t AND X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (OR): //OR
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] | CURRENT_STATE.REGS[rs2];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t OR X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (XOR): //XOR
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] ^ CURRENT_STATE.REGS[rs2];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t XOR X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (SLT): //SLT
            NEXT_STATE.REGS[rd] = ((signed)CURRENT_STATE.REGS[rs1] < (signed)CURRENT_STATE.REGS[rs2]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLT X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        case (SLTU): //SLTU
            NEXT_STATE.REGS[rd] = (CURRENT_STATE.REGS[rs1] < CURRENT_STATE.REGS[rs2]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLTU X%-2d, X%-2d, X%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs1,
                rs2
            );
        break;
        //case (SYSCALL): //SYSCALL
        //    if (CURRENT_STATE.REGS[2] == 0xA) {
        //        RUN_BIT = 0;
        //    }
        //    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        //    printf ("[%d] PC:%.8x\tINSTR:%.8x\t SYSCALL\n", 
        //        instr_count,
        //        CURRENT_STATE.PC,
        //        instr_opcode
        //    );
        //break;
        default:
            printf ("ERROR. Incorrect R-type instruction opcode\n");
    }
}

void decode_r (uint32_t instr_opcode) {
    uint32_t rs1, rs2, rd;
    unsigned int funct7, funct3;
    rs1    = (instr_opcode >> 15)   & 0x1F;
    rs2    = (instr_opcode >> 20)   & 0x1F;
    rd     = (instr_opcode >> 7)    & 0x1F;
    funct3 = (instr_opcode >> 12)   & 0x07;
    funct7 = (instr_opcode >> 25)   & 0x7F;

    execute_r (rs1, rs2, rd, funct7, funct3);
}

void execute_i (unsigned int funct3, int opcode, uint32_t rs1, uint32_t rd, int imm) {
    int sign, mem_content;
    int shift_val;
    uint32_t address;
    unsigned int funct = ((opcode>>4 & 0x1) << 4) | funct3;
    //printf ("I-type instruction\tOpcode is :0x%x\n", opcode);
    // TODO: Add SLLI, SRLI, SRAI instructions
    shift_val = shift_const(20);
    sign = (imm & 0x800)>>11;
    imm = (sign) ? (imm | shift_val) : imm;
    if (opcode == 0x67) { // JALR
      NEXT_STATE.PC = (CURRENT_STATE.REGS[rs1] + imm) & 0xFFFFFFFC;
      if (rd) {
        NEXT_STATE.REGS[rd] = CURRENT_STATE.PC + 4;
      }
      printf ("[%d] PC:%.8x\tINSTR:%.8x\t JALR %.8x\n", 
          instr_count,
          CURRENT_STATE.PC,
          instr_opcode,
          NEXT_STATE.PC
      );
    } else {
      switch (funct) {
          case (ADDI): //ADDI
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t ADDI X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  return;
              }
              NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs1] + imm;
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              
          break;
          case (SLTI): //SLTI
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLTI X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  return;
              }
              NEXT_STATE.REGS[rd] = ((int32_t)CURRENT_STATE.REGS[rs1] < (int32_t)imm);
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
          break;
          case (SLTIU): //SLTIU
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLTIU X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  return;
              }
              NEXT_STATE.REGS[rd] = ((uint32_t)CURRENT_STATE.REGS[rs1] < (uint32_t)imm);
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
          break;
          case (ANDI): //ANDI
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t ANDI X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  return;
              }
              NEXT_STATE.REGS[rd] = ((uint32_t)CURRENT_STATE.REGS[rs1] & (uint32_t)imm);
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
          break;
          case (ORI): //ORI
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t ORI X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  return;
              }
              NEXT_STATE.REGS[rd] = ((uint32_t)CURRENT_STATE.REGS[rs1] | (uint32_t)imm);
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
          break;
          case (XORI): //XORI
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t XORI X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  return;
              }
              NEXT_STATE.REGS[rd] = ((uint32_t)CURRENT_STATE.REGS[rs1] ^ (uint32_t)imm);
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
          break;
          case (SLLI): //SLLI
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLLI X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  return;
              }
              NEXT_STATE.REGS[rd] = ((uint32_t)CURRENT_STATE.REGS[rs1] << (uint32_t)(imm & 0x1F));
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
          break;
          case (SRXI): //SRXI
              if ((imm>>10) & 0x1) { // SRAI
                  printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRAI X%-2d, X%-2d, 0x%-32x\n", 
                      instr_count,
                      CURRENT_STATE.PC,
                      instr_opcode,
                      rd,
                      rs1,
                      imm
                  );
                  if (rd == 0) {
                      NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                      return;
                  }
                  NEXT_STATE.REGS[rd] = ((uint32_t)CURRENT_STATE.REGS[rs1] >> (uint32_t)(imm & 0x1F));
                  if ((CURRENT_STATE.REGS[rs1]>>31) & 0x1) {
                    NEXT_STATE.REGS[rd] = NEXT_STATE.REGS[rd] | (0xFFFFFFFF<<(uint32_t)(31 - (imm & 0x1F)));
                  }
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              } else { //SRLI
                  printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRLI X%-2d, X%-2d, 0x%-32x\n", 
                      instr_count,
                      CURRENT_STATE.PC,
                      instr_opcode,
                      rd,
                      rs1,
                      imm
                  );
                  if (rd == 0) {
                      NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                      return;
                  }
                  NEXT_STATE.REGS[rd] = ((uint32_t)CURRENT_STATE.REGS[rs1] >> (uint32_t)(imm & 0x1F));
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              }
          break;
          case (LB): //LB
              address = CURRENT_STATE.REGS[rs1] + imm;
              mem_content = mem_read_32((uint32_t)address) & 0xFF;
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t LB X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  NEXT_STATE.LOAD_OP = 1;
                  NEXT_STATE.DATA_MEM_ADDR = address;
                  NEXT_STATE.DATA_MEM_DATA = mem_content;
                  NEXT_STATE.BYTE_EN = BYTE;
                  return;
              }
              shift_val = shift_const(24);
              sign = (mem_content >> 7);
              mem_content = sign ? (mem_content | shift_val) : mem_content;
              NEXT_STATE.REGS[rd] = mem_content;
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              NEXT_STATE.LOAD_OP = 1;
              NEXT_STATE.DATA_MEM_ADDR = address;
              NEXT_STATE.DATA_MEM_DATA = mem_content;
              NEXT_STATE.BYTE_EN = BYTE;
          break;
          case (LH): //LH
              address = CURRENT_STATE.REGS[rs1] + imm;
              mem_content = mem_read_32((uint32_t)address) & 0xFFFF;
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t LH X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  NEXT_STATE.LOAD_OP = 1;
                  NEXT_STATE.DATA_MEM_ADDR = address;
                  NEXT_STATE.DATA_MEM_DATA = mem_content;
                  NEXT_STATE.BYTE_EN = HALF_WORD;
                  return;
              }
              shift_val = shift_const(16);
              sign = (mem_content >> 15);
              mem_content = sign ? (mem_content | shift_val) : mem_content;
              NEXT_STATE.REGS[rd] = mem_content;
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              NEXT_STATE.LOAD_OP = 1;
              NEXT_STATE.DATA_MEM_ADDR = address;
              NEXT_STATE.DATA_MEM_DATA = mem_content;
              NEXT_STATE.BYTE_EN = HALF_WORD;
          break;
          case (LW): //LW
              address = CURRENT_STATE.REGS[rs1] + imm;
              mem_content = mem_read_32((uint32_t)address) ;
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t LW X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  NEXT_STATE.LOAD_OP = 1;
                  NEXT_STATE.DATA_MEM_ADDR = address;
                  NEXT_STATE.DATA_MEM_DATA = mem_content;
                  NEXT_STATE.BYTE_EN = WORD;
                  return;
              }
              NEXT_STATE.REGS[rd] = mem_content;
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              NEXT_STATE.LOAD_OP = 1;
              NEXT_STATE.DATA_MEM_ADDR = address;
              NEXT_STATE.DATA_MEM_DATA = mem_content;
              NEXT_STATE.BYTE_EN = WORD;
          break;
          case (LBU): //LBU
              address = CURRENT_STATE.REGS[rs1] + imm;
              mem_content = mem_read_32((uint32_t)address) & 0xFF;
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t LBU X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  NEXT_STATE.LOAD_OP = 1;
                  NEXT_STATE.DATA_MEM_ADDR = address;
                  NEXT_STATE.DATA_MEM_DATA = mem_content;
                  NEXT_STATE.BYTE_EN = BYTE;
                  return;
              }
              NEXT_STATE.REGS[rd] = mem_content;
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              NEXT_STATE.LOAD_OP = 1;
              NEXT_STATE.DATA_MEM_ADDR = address;
              NEXT_STATE.DATA_MEM_DATA = mem_content;
              NEXT_STATE.BYTE_EN = BYTE;
          break;
          case (LHU): //LHU
              address = CURRENT_STATE.REGS[rs1] + imm;
              mem_content = mem_read_32((uint32_t)address) & 0xFFFF;
              printf ("[%d] PC:%.8x\tINSTR:%.8x\t LHU X%-2d, X%-2d, 0x%-32x\n", 
                  instr_count,
                  CURRENT_STATE.PC,
                  instr_opcode,
                  rd,
                  rs1,
                  imm
              );
              if (rd == 0) {
                  NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                  NEXT_STATE.LOAD_OP = 1;
                  NEXT_STATE.DATA_MEM_ADDR = address;
                  NEXT_STATE.DATA_MEM_DATA = mem_content;
                  NEXT_STATE.BYTE_EN = HALF_WORD;
                  return;
              }
              NEXT_STATE.REGS[rd] = mem_content;
              NEXT_STATE.PC = CURRENT_STATE.PC + 4;
              NEXT_STATE.LOAD_OP = 1;
              NEXT_STATE.DATA_MEM_ADDR = address;
              NEXT_STATE.DATA_MEM_DATA = mem_content;
              NEXT_STATE.BYTE_EN = HALF_WORD;
          break;
      }
    }
}

void decode_i (uint32_t instr_opcode) {
    uint32_t rs1, rd;
    unsigned int funct3; 
    int imm, opcode;
    funct3 = (instr_opcode >> 12)   & 0x07;
    opcode = (instr_opcode      )   & 0x7F;
    rs1    = (instr_opcode >> 15)   & 0x1F;
    rd     = (instr_opcode >>  7)   & 0x1F;
    imm    = (instr_opcode >> 20)   & 0xFFF;

    execute_i (funct3, opcode, rs1, rd, imm);
}

void execute_s (unsigned int funct3, uint32_t rs1, uint32_t rs2, int imm) {
    int sign;
    int shift_val;
    uint32_t address;
    //printf ("B-type instruction\tOpcode is :0x%x\n", opcode);
    switch (funct3) {
        case (SB): //SB
            shift_val = shift_const(20);
            sign = (imm & 0x800)>>11;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs1] + imm;
            mem_write_32(address, CURRENT_STATE.REGS[rs1]&0xFF);
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SB X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            NEXT_STATE.STORE_OP = 1;
            NEXT_STATE.DATA_MEM_ADDR = address;
            NEXT_STATE.DATA_MEM_DATA = CURRENT_STATE.REGS[rs2]&0xFF;
            NEXT_STATE.BYTE_EN = BYTE;
        break;
        case (SH): //SH
            shift_val = shift_const(20);
            sign = (imm & 0x800)>>11;
            imm = (sign) ? (imm | shift_val) : imm;
            address = (CURRENT_STATE.REGS[rs1] + imm) & 0xFFFFFFFE;
            mem_write_32(address, CURRENT_STATE.REGS[rs1]&0xFFFF);
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SH X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            NEXT_STATE.STORE_OP = 1;
            NEXT_STATE.DATA_MEM_ADDR = address;
            NEXT_STATE.DATA_MEM_DATA = CURRENT_STATE.REGS[rs2]&0xFFFF;
            NEXT_STATE.BYTE_EN = HALF_WORD;
        break;
        case (SW): //SW
            shift_val = shift_const(20);
            sign = (imm & 0x800)>>11;
            imm = (sign) ? (imm | shift_val) : imm;
            // Align the address to a word boundary
            address = (CURRENT_STATE.REGS[rs1] + imm) & 0xFFFFFFFC;
            mem_write_32(address, CURRENT_STATE.REGS[rs1]);
            //printf ("Writing to: 0x%-8x", address);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SW X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
            NEXT_STATE.STORE_OP = 1;
            NEXT_STATE.DATA_MEM_ADDR = address;
            NEXT_STATE.DATA_MEM_DATA = CURRENT_STATE.REGS[rs2];
            NEXT_STATE.BYTE_EN = WORD;
        break;
        default:
            printf ("ERROR. Incorrect S-type instruction opcode %8x\n", instr_opcode);
    }
}

void decode_s (uint32_t instr_opcode) {
    uint32_t rs1, rs2;
    unsigned int funct3; 
    int imm;
    funct3 = (instr_opcode   >> 12)   & 0x07;
    rs1    = (instr_opcode   >> 15)   & 0x1F;
    rs2    = (instr_opcode   >> 20)   & 0x1F;
    imm    = (((instr_opcode >> 25)   & 0x7F) << 5)  |
             (((instr_opcode >> 7)    & 0x1F));

    execute_s (funct3, rs1, rs2, imm);
}

void execute_b (unsigned int funct3, uint32_t rs1, uint32_t rs2, int imm) {
    int sign;
    int shift_val;
    uint32_t address;
    //printf ("B-type instruction\tOpcode is :0x%x\n", opcode);
    switch (funct3) {
        case (BEQ): //BEQ
            if (CURRENT_STATE.REGS[rs1] == CURRENT_STATE.REGS[rs2]) {
                shift_val = shift_const(19);
                sign = (imm & 0x1000)>>12;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = (CURRENT_STATE.PC + address) & 0xFFFFFFFC;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BEQ X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
        break;
        case (BNE): //BNE
            if (CURRENT_STATE.REGS[rs1] != CURRENT_STATE.REGS[rs2]) {
                shift_val = shift_const(19);
                sign = (imm & 0x1000)>>12;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = (CURRENT_STATE.PC + address) & 0xFFFFFFFC;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BNE X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
        break;
        case (BLT): //BLT
            if ((signed)CURRENT_STATE.REGS[rs1] < (signed)CURRENT_STATE.REGS[rs2]) {
                shift_val = shift_const(19);
                sign = (imm & 0x1000)>>12;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = (CURRENT_STATE.PC + address) & 0xFFFFFFFC;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BLT X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
        break;
        case (BLTU): //BLTU
            if ((unsigned)CURRENT_STATE.REGS[rs1] < (unsigned)CURRENT_STATE.REGS[rs2]) {
                shift_val = shift_const(19);
                sign = (imm & 0x1000)>>12;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = (CURRENT_STATE.PC + address) & 0xFFFFFFFC;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BLTU X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
        break;
        case (BGE): //BGE
            if ((int32_t)CURRENT_STATE.REGS[rs1] >= (int32_t)CURRENT_STATE.REGS[rs2]) {
                shift_val = shift_const(19);
                sign = (imm & 0x1000)>>12;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = (CURRENT_STATE.PC + address) & 0xFFFFFFFC;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BGE X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
        break;
        case (BGEU): //BGEU
            if (CURRENT_STATE.REGS[rs1] >= CURRENT_STATE.REGS[rs2]) {
                shift_val = shift_const(19);
                sign = (imm & 0x1000)>>12;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = (CURRENT_STATE.PC + address) & 0xFFFFFFFC;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BGEU X%-2d, X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs1,
                rs2,
                imm
            );
        break;
        default:
            printf ("ERROR. Incorrect B-type instruction opcode %8x\n", instr_opcode);
    }
}

void decode_b (uint32_t instr_opcode) {
    uint32_t rs1, rs2;
    unsigned int funct3; 
    int imm;
    funct3 = (instr_opcode   >> 12)   & 0x07;
    rs1    = (instr_opcode   >> 15)   & 0x1F;
    rs2    = (instr_opcode   >> 20)   & 0x1F;
    imm    = (((instr_opcode >> 31)   & 0x01) << 12) |
             (((instr_opcode >> 7)    & 0x01) << 11) |
             (((instr_opcode >> 25)   & 0x3F) << 5)  |
             (((instr_opcode >> 8)    & 0x0F) << 1);

    execute_b (funct3, rs1, rs2, imm);
}

void execute_u (int opcode, uint32_t rd, int imm) {
    int u_val;
    switch (opcode) {
        case (LUI): //LUI
            u_val = imm << 12;
            NEXT_STATE.REGS[rd] = rd ? u_val : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t LUI X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                imm
            );
        break;
        case (AUIPC): //AUIPC
            u_val = imm << 12;
            NEXT_STATE.REGS[rd] = rd ? CURRENT_STATE.PC + u_val : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t AUIPC X%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                imm
            );
        break;
        default:
            printf ("ERROR. Incorrect U-type instruction opcode %8x\n", instr_opcode);
    }
}

void decode_u (uint32_t instr_opcode) {
    uint32_t rd;
    int imm;
    int opcode;
    opcode  = (instr_opcode)        & 0x7F;
    rd      = (instr_opcode >> 7)   & 0x1F;
    imm     = (instr_opcode >> 12)  & 0xFFFFF;

    execute_u (opcode, rd, imm);
}

void execute_j (uint32_t rd, int imm) {
    int address;
    int sign;
    int shift_val;

    shift_val = shift_const(11);
    sign = (imm & 0x100000)>>20;
    address = (sign) ? (imm | shift_val) : imm;
    NEXT_STATE.PC = (CURRENT_STATE.PC + address) & 0xFFFFFFFC;
    if (rd) {
      NEXT_STATE.REGS[rd] = CURRENT_STATE.PC + 4;
    }
    printf ("[%d] PC:%.8x\tINSTR:%.8x\t JAL X%-2d, 0x%-8x\n", 
        instr_count,
        CURRENT_STATE.PC,
        instr_opcode,
        rd,
        NEXT_STATE.PC
    );
}

void decode_j (uint32_t instr_opcode) {
    uint32_t rd;
    int imm;
    rd      = (instr_opcode >> 7)     & 0x1F; 
    imm     = (((instr_opcode >> 31)  & 0x01)  << 20) |
              (((instr_opcode >> 12)  & 0xFF)  << 12) |
              (((instr_opcode >> 20)  & 0x01)  << 11) |
              (((instr_opcode >> 21)  & 0x3FF) << 1);

    execute_j (rd, imm);
}

void process_instruction(uint32_t instr_opcode) {
    /* Execute one instruction here. You should use CURRENT_STATE and modify
     * values in NEXT_STATE. You can call mem_read_32() and mem_write_32() to
     * access memory. */
    //instr_opcode = mem_read_32(CURRENT_STATE.PC);
    //printf ("Instr Read: %-8x from %-8x\n", instr_opcode, CURRENT_STATE.PC);
    NEXT_STATE.STORE_OP = 0;
    NEXT_STATE.LOAD_OP = 0;
    NEXT_STATE.DATA_MEM_ADDR = 0xDEADBEEF;
    NEXT_STATE.DATA_MEM_DATA = 0xDEADBEEF;
    NEXT_STATE.BYTE_EN = WORD;
    int type = decode_instr_type (instr_opcode);
    if (type == R_TYPE)
        decode_r (instr_opcode);
    else if (type == I_TYPE)
        decode_i (instr_opcode);
    else if (type == S_TYPE)
        decode_s (instr_opcode);
    else if (type == B_TYPE)
        decode_b (instr_opcode);
    else if (type == U_TYPE)
        decode_u (instr_opcode);
    else if (type == J_TYPE)
        decode_j (instr_opcode);
    else {
        printf ("\nERROR: Invalid instruction type\n");
        RUN_BIT = 0;
    }
    instr_count++;
}

//extern int compare_r (int pc, int instr, int rd, int rs1, int rs2, int rd_val, int rs1_val, int rs2_val) {
//    int instr_model   = (int) instr_opcode;
//    int rs1_model     = (instr_opcode >> 15)   & 0x1F;
//    int rs2_model     = (instr_opcode >> 20)   & 0x1F;
//    int rd_model      = (instr_opcode >> 7)    & 0x1F;
//    int rs1_val_model = CURRENT_STATE.REGS[rs1_model];
//    int rs2_val_model = CURRENT_STATE.REGS[rs2_model];
//    int rd_val_model  = CURRENT_STATE.REGS[rd_model];
//
//
//    if ((rs1 == rd)) {
//        rs1_val = rd_val;
//    }
//    if ((rs2 == rd)) {
//        rs2_val = rd_val;
//    }
//    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\tX%d:%.8x\n", pc, instr, rd, rd_val, rs1, rs1_val, rs2, rs2_val);
//    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\tX%d:%.8x\n\n", prev_pc, instr_model, rd_model, rd_val_model, 
//                                                                              rs1_model, rs1_val_model, rs2_model, rs2_val_model);
//    if (prev_pc != pc) {
//        RUN_BIT = 0;
//        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
//        printf ("PC Mismatch\n");
//        return 0;
//    }
//    else if (instr != instr_model) {
//        RUN_BIT = 0;
//        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
//        printf ("INSTR Mismatch\n");
//        return 0;
//    }
//    else if (rd != rd_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rd);
//        printf ("Expecting  X%d Register\n", rd_model);
//        return 0;
//    }
//    else if (rs1 != rs1_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rs1);
//        printf ("Expecting  X%d Register\n", rs1_model);
//        return 0;
//    }
//    else if (rs2 != rs2_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rs2);
//        printf ("Expecting  X%d Register\n", rs2_model);
//        return 0;
//    }
//    else if (rd_val != rd_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rd, rd_val, rd_model, rd_val_model);
//        printf ("RD Value Mismatch\n");
//        return 0;
//    }
//    else if (rs1_val != rs1_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rs1, rs1_val, rs1_model, rs1_val_model);
//        printf ("RS1 Value Mismatch\n");
//        return 0;
//    }
//    else if (rs2_val != rs2_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rs2, rs2_val, rs2_model, rs2_val_model);
//        printf ("RS2 Value Mismatch\n");
//        return 0;
//    }
//    prev_pc = CURRENT_STATE.PC;
//    return 1;
//}
//
//extern int compare_i (int pc, int instr, int rd, int rs1, int rd_val, int rs1_val) {
//    int instr_model   = (int) instr_opcode;
//    int rd_model      = (instr_model >>  7)   & 0x1F;
//    int rs1_model     = (instr_model >> 15)   & 0x1F;
//    int rd_val_model  = CURRENT_STATE.REGS[rd_model];
//    int rs1_val_model = CURRENT_STATE.REGS[rs1_model];
//    if ((rs1 == rd)) {
//        rs1_val = rd_val;
//    }
//    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\n", pc, instr, rd, rd_val, rs1, rs1_val);
//    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\n\n", prev_pc, instr_model, rd_model, rd_val_model, rs1_model, rs1_val_model);
//    if (prev_pc != pc) {
//        RUN_BIT = 0;
//        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
//        printf ("PC Mismatch\n");
//        return 0;
//    }
//    else if (instr != instr_model) {
//        RUN_BIT = 0;
//        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
//        printf ("INSTR Mismatch\n");
//        return 0;
//    }
//    else if (rs1 != rs1_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rs1);
//        printf ("Expecting  X%d Register\n", rs1_model);
//        return 0;
//    }
//    else if (rd != rd_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rd);
//        printf ("Expecting  X%d Register\n", rd_model);
//        return 0;
//    }
//    else if (rd_val != rd_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rd, rd_val, rd_model, rd_val_model);
//        printf ("RD Value Mismatch\n");
//        return 0;
//    }
//    else if (rs1_val != rs1_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rs1, rs1_val, rs1_model, rs1_val_model);
//        printf ("RS1 Value Mismatch\n");
//        return 0;
//    }
//    prev_pc = CURRENT_STATE.PC;
//    return 1;
//}
//
//extern int compare_s (int pc, int instr, int rs1, int rs2, int rs1_val, int rs2_val) {
//    int instr_model   = (int) instr_opcode;
//    int rs1_model     = (instr_model >> 15)   & 0x1F;
//    int rs2_model     = (instr_model >> 20)   & 0x1F;
//    int rs1_val_model = CURRENT_STATE.REGS[rs1_model];
//    int rs2_val_model = CURRENT_STATE.REGS[rs2_model];
//    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\n", pc, instr, rs1, rs1_val, rs2, rs2_val);
//    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\n\n", prev_pc, instr_model, rs1_model, rs1_val_model, rs2_model, rs2_val_model);
//    if (prev_pc != pc) {
//        RUN_BIT = 0;
//        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
//        printf ("PC Mismatch\n");
//        return 0;
//    }
//    else if (instr != instr_model) {
//        RUN_BIT = 0;
//        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
//        printf ("INSTR Mismatch\n");
//        return 0;
//    }
//    else if (rs1 != rs1_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rs1);
//        printf ("Expecting  X%d Register\n", rs1_model);
//        return 0;
//    }
//    else if (rs2 != rs2_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rs2);
//        printf ("Expecting  X%d Register\n", rs2_model);
//        return 0;
//    }
//    else if (rs2_val != rs2_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rs2, rs2_val, rs2_model, rs2_val_model);
//        printf ("RS2 Value Mismatch\n");
//        return 0;
//    }
//    else if (rs1_val != rs1_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rs1, rs1_val, rs1_model, rs1_val_model);
//        printf ("RS1 Value Mismatch\n");
//        return 0;
//    }
//    prev_pc = CURRENT_STATE.PC;
//    return 1;
//}
//
//extern int compare_b (int pc, int instr, int rs1, int rs2, int rs1_val, int rs2_val) {
//    int instr_model   = (int) instr_opcode;
//    int rs1_model     = (instr_model >> 15)   & 0x1F;
//    int rs2_model     = (instr_model >> 20)   & 0x1F;
//    int rs1_val_model = CURRENT_STATE.REGS[rs1_model];
//    int rs2_val_model = CURRENT_STATE.REGS[rs2_model];
//    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\n", pc, instr, rs1, rs1_val, rs2, rs2_val);
//    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tX%d:%.8x\tX%d:%.8x\n\n", prev_pc, instr_model, rs1_model, rs1_val_model, rs2_model, rs2_val_model);
//    if (prev_pc != pc) {
//        RUN_BIT = 0;
//        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
//        printf ("PC Mismatch\n");
//        return 0;
//    }
//    else if (instr != instr_model) {
//        RUN_BIT = 0;
//        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
//        printf ("INSTR Mismatch\n");
//        return 0;
//    }
//    else if (rs1 != rs1_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rs1);
//        printf ("Expecting  X%d Register\n", rs1_model);
//        return 0;
//    }
//    else if (rs2 != rs2_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rs2);
//        printf ("Expecting  X%d Register\n", rs2_model);
//        return 0;
//    }
//    else if (rs2_val != rs2_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rs2, rs2_val, rs2_model, rs2_val_model);
//        printf ("RS2 Value Mismatch\n");
//        return 0;
//    }
//    else if (rs1_val != rs1_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rs1, rs1_val, rs1_model, rs1_val_model);
//        printf ("RS1 Value Mismatch\n");
//        return 0;
//    }
//    prev_pc = CURRENT_STATE.PC;
//    return 1;
//}
//
//extern int compare_u (int pc, int instr, int rd, int rd_val) {
//    int instr_model   = (int) instr_opcode;
//    int rd_model      = (instr_model >>  7)   & 0x1F;
//    int rd_val_model  = CURRENT_STATE.REGS[rd_model];
//    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tX%d:%.8x\n", pc, instr, rd, rd_val);
//    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tX%d:%.8x\n\n", prev_pc, instr_model, rd_model, rd_val_model);
//    if (prev_pc != pc) {
//        RUN_BIT = 0;
//        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
//        printf ("PC Mismatch\n");
//        return 0;
//    }
//    else if (instr != instr_model) {
//        RUN_BIT = 0;
//        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
//        printf ("INSTR Mismatch\n");
//        return 0;
//    }
//    else if (rd != rd_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rd);
//        printf ("Expecting  X%d Register\n", rd_model);
//        return 0;
//    }
//    else if (rd_val != rd_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rd, rd_val, rd_model, rd_val_model);
//        printf ("RD Value Mismatch\n");
//        return 0;
//    }
//    prev_pc = CURRENT_STATE.PC;
//    return 1;
//}
//
//extern int compare_j (int pc, int instr, int rd, int rd_val) {
//    int instr_model  = (int) instr_opcode;
//    int rd_model     = (instr_model >> 7) & 0x1F;
//    int rd_val_model = CURRENT_STATE.REGS[rd_model];
//    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tX%d:%.8x\n", pc, instr,rd, rd_val);
//    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tX%d:%.8x\n\n", prev_pc, instr_model, rd_model, rd_val_model);
//    if (prev_pc != pc) {
//        RUN_BIT = 0;
//        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
//        printf ("PC Mismatch\n");
//        return 0;
//    }
//    else if (instr != instr_model) {
//        RUN_BIT = 0;
//        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
//        printf ("INSTR Mismatch\n");
//        return 0;
//    }
//    else if (rd != rd_model) {
//        RUN_BIT = 0;
//        printf ("Unexpected X%d Register\n", rd);
//        printf ("Expecting  X%d Register\n", rd_model);
//        return 0;
//    }
//    else if (rd_val != rd_val_model) {
//        RUN_BIT = 0;
//        printf ("RTL X%d VAL: %x\t Model X%d VAL: %x\n", rd, rd_val, rd_model, rd_val_model);
//        printf ("RD Value Mismatch\n");
//        return 0;
//    }
//    prev_pc = CURRENT_STATE.PC;
//    return 1;
//}

int compare_instruction_address(int address) {
    if (PREV_STATE.PC != address) {
        RUN_BIT = 0;
        printf ("RTL PC: %x\t ISS PC: %x\n", address, PREV_STATE.PC);
        printf ("PC Mismatch\n");
        return 0;
    }
    return 1;
}

int compare_data_memory_access(int address, int byte_en, int write, int write_data) {
    int masked_write_data;

    if (byte_en == 0) {
      masked_write_data = write_data & 0xFF;
    } else if (byte_en == 1) {
      masked_write_data = write_data & 0xFFFF;
    } else {
      masked_write_data = write_data;
    }

    if (CURRENT_STATE.STORE_OP || CURRENT_STATE.LOAD_OP) {
      if (CURRENT_STATE.STORE_OP) {
          if (!write) {
              RUN_BIT = 0;
              printf ("RTL Write: %d\t ISS Write: %d\n", write, CURRENT_STATE.STORE_OP);
              printf ("Expected a STORE transaction\n");
              return 0;
          } else if (CURRENT_STATE.DATA_MEM_ADDR != address) {
              RUN_BIT = 0;
              printf ("RTL Address: %x\t ISS Address: %x\n", address, CURRENT_STATE.DATA_MEM_ADDR);
              printf ("Store Address Mismatch\n");
              return 0;
          } else if (CURRENT_STATE.DATA_MEM_DATA != masked_write_data) {
              RUN_BIT = 0;
              printf ("RTL Data: %x\t ISS Data: %x\n", masked_write_data, CURRENT_STATE.DATA_MEM_DATA);
              printf ("Store Data Mismatch\n");
              return 0;
          } else if (CURRENT_STATE.BYTE_EN != byte_en) {
              RUN_BIT = 0;
              printf ("RTL Byte Enable: %x\t ISS Byte Enable: %x\n", byte_en, CURRENT_STATE.BYTE_EN);
              printf ("Store Byte Enable Mismatch\n");
              return 0;
          } else {
              return 1;
          }
      } else {
          if (write) {
              RUN_BIT = 0;
              printf ("RTL Write: %d\t ISS Write: %d\n", write, CURRENT_STATE.STORE_OP);
              printf ("Expected a LOAD transaction\n");
              return 0;
          } else if (CURRENT_STATE.DATA_MEM_ADDR != address) {
              RUN_BIT = 0;
              printf ("RTL Address: %x\t ISS Address: %x\n", address, CURRENT_STATE.DATA_MEM_ADDR);
              printf ("Load Address Mismatch\n");
              return 0;
          } else if (CURRENT_STATE.BYTE_EN != byte_en) {
              RUN_BIT = 0;
              printf ("RTL PC: %x\t ISS PC: %x\n", byte_en, CURRENT_STATE.BYTE_EN);
              printf ("Load Byte Enable Mismatch\n");
              return 0;
          } else {
              return 1;
          }
      }
    } else {
        RUN_BIT = 0;
        printf ("Data Memory Access Mismatch. No access expected\n");
        return 0;
    }
    return 1;
}

int compare_architecture_register(int regnum, int value) {
    if (CURRENT_STATE.REGS[regnum] != value) {
        RUN_BIT = 1;
        printf ("[%d] RTL X[%d]: %x\t ISS X[%d]: %x\n", instr_count, regnum, value, regnum, CURRENT_STATE.REGS[regnum]);
        printf ("Register Mismatch\n");
        return 0;
    }
    return 1;
}
