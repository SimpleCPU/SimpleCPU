#include <stdio.h>
#include "main.h"

int decode_instr_type (uint32_t instr_opcode) {
    int type;
    if ((instr_opcode >> 26) == 0) { //R type
        type = R_TYPE;
        return type;
    }
    else if (((instr_opcode >> 26) == 2 ) || ((instr_opcode >> 26) == 3)) { //J type
        type = J_TYPE;
        return type;
    }
    else { //I type
        type = I_TYPE;
        return type;
    }
    printf("No valid type found for instruction: %32x\n", instr_opcode);
    type = -1;
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


void execute_r (uint32_t rs, uint32_t rt, uint32_t rd, unsigned int shamt, unsigned int funct) {
    int sign;
    int shift_val;
    int64_t mul_res;
    if ((rd == 0) && (funct != 0x0c)) {
        NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        if ((funct == SLL) || (funct == SRL) ||
            (funct == SRA) || (funct == SLLV) ||
            (funct == SRLV)|| (funct == SRAV)
        )
            rt_as_src = 1;
        return;
    }
    switch (funct) {
        case (SLL): //SLL
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] << shamt;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLL R%-2d, R%-2d, 0x%-x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rt,
                shamt
            );
        break;
        case (SRL): //SRL
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> shamt;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRL R%-2d, R%-2d, 0x%-x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rt,
                shamt
            );
        break;
        case (SRA): //SRA
            rt_as_src = 1;
            sign = (CURRENT_STATE.REGS[rs] & 0x10000000)>>31;
            shift_val = shift_const(shamt);
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> shamt;
            NEXT_STATE.REGS[rd] = (sign == 1) ? NEXT_STATE.REGS[rd] | shift_val: NEXT_STATE.REGS[rd]; 
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRA R%-2d, R%-2d, 0x%-x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rt,
                shamt
            );
        break;
        case (SLLV): //SLLV
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] << (CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLLV R%-2d, R%-2d, 0x%-x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rt,
                shamt
            );
        break;
        case (SRLV): //SRLV
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> (CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRLV R%-2d, R%-2d, 0x%-x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rt,
                shamt
            );
        break;
        case (SRAV): //SRAV
            rt_as_src = 1;
            sign = (CURRENT_STATE.REGS[rs] & 0x10000000)>>31;
            shift_val = shift_const(CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> (CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.REGS[rd] = (sign == 1) ? NEXT_STATE.REGS[rd] | shift_val: NEXT_STATE.REGS[rd]; 
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SRAV R%-2d, R%-2d, 0x%-x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rt,
                shamt
            );
        break;
        case (JR): //JR
            NEXT_STATE.PC = CURRENT_STATE.REGS[rs];
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t JR %-2d", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.PC
            );
        break;
        case (JALR): //JALR
            NEXT_STATE.PC = CURRENT_STATE.REGS[rs];
            NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
            wr_link_reg = 0;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t JALR %-2d", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.PC
            );
        break;
        case (ADD): //ADD
            NEXT_STATE.REGS[rd] = (int32_t)(CURRENT_STATE.REGS[rs] + CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t ADD R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (ADDU): //ADDU
            NEXT_STATE.REGS[rd] = (uint32_t)(CURRENT_STATE.REGS[rs] + CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t ADDU R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (SUB): //SUB
            NEXT_STATE.REGS[rd] = (int32_t)(CURRENT_STATE.REGS[rs] - CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SUB R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (SUBU): //SUBU
            NEXT_STATE.REGS[rd] = (uint32_t)(CURRENT_STATE.REGS[rs] - CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SUBU R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (AND): //AND
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs] & CURRENT_STATE.REGS[rt];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t AND R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (OR): //OR
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs] | CURRENT_STATE.REGS[rt];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t OR R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (XOR): //XOR
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs] ^ CURRENT_STATE.REGS[rt];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t XOR R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (NOR): //NOR
            NEXT_STATE.REGS[rd] = ~(CURRENT_STATE.REGS[rs] | CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t NOR R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (SLT): //SLT
            NEXT_STATE.REGS[rd] = ((signed)CURRENT_STATE.REGS[rs] < (signed)CURRENT_STATE.REGS[rt]) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLT R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (SLTU): //SLTU
            NEXT_STATE.REGS[rd] = (CURRENT_STATE.REGS[rs] < CURRENT_STATE.REGS[rt]) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLTU R%-2d, R%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                rs,
                rt
            );
        break;
        case (MULT): //MULT
            mul_res = (int64_t)(CURRENT_STATE.REGS[rs] * CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = (int32_t)((mul_res>>32) & 0xFFFFFFFF);
            NEXT_STATE.LO = (int32_t)(mul_res & 0xFFFFFFFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t MULT HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.HI,
                NEXT_STATE.LO,
                rs,
                rt
            );
        break;
        case (MFHI): //MFHI
            NEXT_STATE.REGS[rd] = CURRENT_STATE.HI;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t MFHI R%-2d\n, HI:%-2d", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                NEXT_STATE.HI
            );
        break;
        case (MFLO): //MFLO
            NEXT_STATE.REGS[rd] = CURRENT_STATE.LO;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t MFLO R%-2d\n, LO:%-2d", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rd,
                NEXT_STATE.LO
            );
        break;
        case (MTHI): //MTHI
            NEXT_STATE.HI = CURRENT_STATE.REGS[rs];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t MFHI HI:%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.HI,
                rs
            );
        break;
        case (MTLO): //MTLO
            NEXT_STATE.LO = CURRENT_STATE.REGS[rs];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t MTLO LO:%-2d, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.LO,
                rs
            );
        break;
        case (MULTU): //MULTU
            mul_res = (uint64_t)((uint32_t)CURRENT_STATE.REGS[rs] * (uint32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = (uint32_t)((mul_res>>32) & 0xFFFFFFFF);
            NEXT_STATE.LO = (uint32_t)(mul_res & 0xFFFFFFFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t MULTU HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.HI,
                NEXT_STATE.LO,
                rs,
                rt
            );
        break;
        case (DIV): //DIV
            NEXT_STATE.LO = ((int32_t)CURRENT_STATE.REGS[rs] / (int32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = ((int32_t)CURRENT_STATE.REGS[rs] % (int32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t DIV HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.HI,
                NEXT_STATE.LO,
                rs,
                rt
            );
        break;
        case (DIVU): //DIVU
            NEXT_STATE.LO = ((uint32_t)CURRENT_STATE.REGS[rs] / (uint32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = ((uint32_t)CURRENT_STATE.REGS[rs] % (uint32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t DIVU HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.HI,
                NEXT_STATE.LO,
                rs,
                rt
            );
        break;
        case (SYSCALL): //SYSCALL
            if (CURRENT_STATE.REGS[2] == 0xA) {
                RUN_BIT = 0;
            }
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SYSCALL\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode
            );
        break;
        default:
            printf ("ERROR. Incorrect R-type instruction opcode\n");
    }
}

void decode_r (uint32_t instr_opcode) {
    uint32_t rs, rt, rd;
    unsigned int shamt, funct;
    rs     = (instr_opcode >> 21)   & 0x1F;
    rt     = (instr_opcode >> 16)   & 0x1F;
    rd     = (instr_opcode >> 11)   & 0x1F;
    shamt  = (instr_opcode >> 6)    & 0x1F;
    funct  = (instr_opcode)         & 0x3F;

    execute_r (rs, rt, rd, shamt, funct);
}

void execute_i (unsigned int opcode, uint32_t rs, uint32_t rt, int imm) {
    int sign, mem_content;
    int shift_val;
    uint32_t address;
    //printf ("I-type instruction\tOpcode is :0x%x\n", opcode);
    switch (opcode) {
        case (BEQ): //BEQ
            if (CURRENT_STATE.REGS[rs] == CURRENT_STATE.REGS[rt]) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BEQ R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
        break;
        case (BNE): //BNE
            if (CURRENT_STATE.REGS[rs] != CURRENT_STATE.REGS[rt]) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BNE R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
        break;
        case (BLEZ): //BLEZ
            if ((int32_t)CURRENT_STATE.REGS[rs] <= 0) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BLEZ R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs,
                imm
            );
        break;
        case (BGTZ): //BGTZ
            if ((int32_t)CURRENT_STATE.REGS[rs] > 0) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t BGTZ R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rs,
                imm
            );
        break;
        case (ADDI): //ADDI
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t ADDI R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            NEXT_STATE.REGS[rt] = CURRENT_STATE.REGS[rs] + imm;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            
        break;
        case (ADDIU): //ADDIU
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t ADDIU R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            NEXT_STATE.REGS[rt] = CURRENT_STATE.REGS[rs] + imm;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (SLTI): //SLTI
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLTI R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = ((int32_t)CURRENT_STATE.REGS[rs] < (int32_t)imm) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (SLTIU): //SLTIU
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SLTIU R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = ((uint32_t)CURRENT_STATE.REGS[rs] < (uint32_t)imm) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (ANDI): //ANDI
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t ANDI R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = ((uint32_t)CURRENT_STATE.REGS[rs] & (uint32_t)imm);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (ORI): //ORI
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t ORI R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = ((uint32_t)CURRENT_STATE.REGS[rs] | (uint32_t)imm);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (XORI): //XORI
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t XORI R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = ((uint32_t)CURRENT_STATE.REGS[rs] ^ (uint32_t)imm);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (LUI): //LUI
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t LUI R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = imm << 16;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (LB): //LB
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFF;
            shift_val = shift_const(24);
            sign = (mem_content >> 7);
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t LB R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = (sign) ? (mem_content | shift_val) : mem_content;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (LH): //LH
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFFFF;
            shift_val = shift_const(16);
            sign = (mem_content >> 15);
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t LH R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = (sign) ? (mem_content | shift_val) : mem_content;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (LW): //LW
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            address = (CURRENT_STATE.REGS[rs] + imm) & 0xFFFFFFFC;
            mem_content = mem_read_32((uint32_t)address);
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t LW R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = mem_content;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (LBU): //LBU
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFF;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t LBU R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = mem_content;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (LHU): //LHU
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFFFF;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t LHU R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = mem_content;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (SB): //SB
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_write_32(address, NEXT_STATE.REGS[rt]&0xFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SB R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
        break;
        case (SH): //SH
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_write_32(address, NEXT_STATE.REGS[rt]&0xFFFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SH R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
        break;
        case (SW): //SW
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15;
            imm = (sign) ? (imm | shift_val) : imm;
            // Align the address to a word boundary
            address = (CURRENT_STATE.REGS[rs] + imm) & 0xFFFFFFFC;
            mem_write_32(address, NEXT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t SW R%-2d, R%-2d, 0x%-32x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                rt,
                rs,
                imm
            );
        break;
        case (BVAR): 
            if (rt == BLTZ) { //BLTZ
                if ((int32_t)CURRENT_STATE.REGS[rs] < 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
                printf ("[%d] PC:%.8x\tINSTR:%.8x\t BLTZ R%-2d, 0x%-32x\n", 
                    instr_count,
                    CURRENT_STATE.PC,
                    instr_opcode,
                    rs,
                    imm
                );
                break;
            }
            else if (rt == BGEZ) { //BGEZ
                if ((int32_t)CURRENT_STATE.REGS[rs] >= 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
                printf ("[%d] PC:%.8x\tINSTR:%.8x\t BGEZ R%-2d, 0x%-32x\n", 
                    instr_count,
                    CURRENT_STATE.PC,
                    instr_opcode,
                    rs,
                    imm
                );
                break;
            }
            else if (rt == BLTZAL) { //BLTZAL
                if ((int32_t)CURRENT_STATE.REGS[rs] < 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
                NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
                wr_link_reg = 1;
                printf ("[%d] PC:%.8x\tINSTR:%.8x\t BLTZAL R%-2d, 0x%-32x\n", 
                    instr_count,
                    CURRENT_STATE.PC,
                    instr_opcode,
                    rs,
                    imm
                );
                break;
            }
            else if (rt == BGEZAL) { //BGEZAL
                if ((int32_t)CURRENT_STATE.REGS[rs] >= 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
                NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
                wr_link_reg = 1;
                printf ("[%d] PC:%.8x\tINSTR:%.8x\t BGEZAL R%-2d, 0x%-32x\n", 
                    instr_count,
                    CURRENT_STATE.PC,
                    instr_opcode,
                    rs,
                    imm
                );
                break;
            }
            printf ("[BVAR] ERROR. Incorrect I-type instruction opcode %8x\n", instr_opcode);
        break;
        default:
            printf ("ERROR. Incorrect I-type instruction opcode %8x\n", instr_opcode);
    }
}

void decode_i (uint32_t instr_opcode) {
    uint32_t rs, rt;
    unsigned int opcode; 
    int imm;
    opcode = (instr_opcode >> 26)   & 0x3F;
    rs     = (instr_opcode >> 21)   & 0x1F;
    rt     = (instr_opcode >> 16)   & 0x1F;
    imm    = (instr_opcode)         & 0xFFFF;

    execute_i (opcode, rs, rt, imm);
}

void execute_j (unsigned int opcode, int target) {
    uint32_t address;
    switch (opcode) { 
        case (J): //J
            address = ((CURRENT_STATE.PC+4) & 0xF0000000) | (target<<2);
            NEXT_STATE.PC = address;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t J %-8x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.PC
            );
        break;
        case (JAL): //JAL
            address = ((CURRENT_STATE.PC+4) & 0xF0000000) | (target<<2);
            NEXT_STATE.PC = address;
            NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
            wr_link_reg = 1;
            printf ("[%d] PC:%.8x\tINSTR:%.8x\t JAL %-8x\n", 
                instr_count,
                CURRENT_STATE.PC,
                instr_opcode,
                NEXT_STATE.PC
            );
        break;
        default:
            printf ("ERROR. Incorrect J-type instruction opcode\n");
            
    }
}

void decode_j (uint32_t instr_opcode) {
    unsigned int opcode; 
    int address;
    opcode  = (instr_opcode >> 26)   & 0x3F;
    address = (instr_opcode)         & 0x3FFFFFF;

    execute_j (opcode, address);
}

void process_instruction() {
    rt_as_src   = 0;
    wr_link_reg = 0;
    /* execute one instruction here. You should use CURRENT_STATE and modify
     * values in NEXT_STATE. You can call mem_read_32() and mem_write_32() to
     * access memory. */
    instr_opcode = mem_read_32(CURRENT_STATE.PC);
    //printf ("Instr Read: %-8x from %-8x\n", instr_opcode, CURRENT_STATE.PC);
    int type = decode_instr_type (instr_opcode);
    if (type == R_TYPE)
        decode_r (instr_opcode);
    else if (type == J_TYPE)
        decode_j (instr_opcode);
    else 
        decode_i (instr_opcode);
    instr_count++;
}

extern int compare_r (int pc, int instr, int rd, int rs, int rt, int rd_val, int rs_val, int rt_val) {
    int instr_model  = (int) instr_opcode;
    int rs_model     = (instr_model >> 21)   & 0x1F;
    int rt_model     = (instr_model >> 16)   & 0x1F;
    int rd_model     = (instr_model >> 11)   & 0x1F;
    rs_model         = (rt_as_src)   ? rt_model : rs_model;
    int rs_val_model = CURRENT_STATE.REGS[rs_model];
    int rt_val_model = CURRENT_STATE.REGS[rt_model];
    int rd_val_model = (wr_link_reg) ? CURRENT_STATE.REGS[31] : CURRENT_STATE.REGS[rd_model];
    if ((rs == rd)) {
        rs_val = rd_val;
    }
    if ((rt == rd)) {
        rt_val = rd_val;
    }
    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\tR%d:%.8x\n", pc, instr, rd, rd_val, rs, rs_val, rt, rt_val);
    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\tR%d:%.8x\n\n", prev_pc, instr_model, rd_model, rd_val_model, 
                                                                            rs_model, rs_val_model, rt_model, rt_val_model);
    if (prev_pc != pc) {
        RUN_BIT = 0;
        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
        printf ("PC Mismatch\n");
        return 0;
    }
    else if (instr != instr_model) {
        RUN_BIT = 0;
        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
        printf ("INSTR Mismatch\n");
        return 0;
    }
    else if (rd != rd_model) {
        RUN_BIT = 0;
        printf ("Unexpected R%d Register\n", rd);
        printf ("Expecting  R%d Register\n", rd_model);
        return 0;
    }
    else if (rs != rs_model) {
        RUN_BIT = 0;
        printf ("Unexpected R%d Register\n", rs);
        printf ("Expecting  R%d Register\n", rs_model);
        return 0;
    }
    else if (rt != rt_model) {
        RUN_BIT = 0;
        printf ("Unexpected R%d Register\n", rt);
        printf ("Expecting  R%d Register\n", rt_model);
        return 0;
    }
    else if (rd_val != rd_val_model) {
        RUN_BIT = 0;
        printf ("RTL R%d VAL: %x\t Model R%d VAL: %x\n", rd, rd_val, rd_model, rd_val_model);
        printf ("RD Value Mismatch\n");
        return 0;
    }
    else if (rs_val != rs_val_model) {
        RUN_BIT = 0;
        printf ("RTL R%d VAL: %x\t Model R%d VAL: %x\n", rs, rs_val, rs_model, rs_val_model);
        printf ("RS Value Mismatch\n");
        return 0;
    }
    else if (rt_val != rt_val_model) {
        RUN_BIT = 0;
        printf ("RTL R%d VAL: %x\t Model R%d VAL: %x\n", rt, rt_val, rt_model, rt_val_model);
        printf ("RT Value Mismatch\n");
        return 0;
    }
    prev_pc = CURRENT_STATE.PC;
    return 1;
}

extern int compare_i (int pc, int instr, int rs, int rt, int rs_val, int rt_val) {
    int instr_model  = (int) instr_opcode;
    int rs_model     = (instr_model >> 21)   & 0x1F;
    int rt_model     = (wr_link_reg) ? 0x1F : (instr_model >> 16)   & 0x1F;
    int rs_val_model = CURRENT_STATE.REGS[rs_model];
    int rt_val_model = CURRENT_STATE.REGS[rt_model];
    if ((rs == rt)) {
        rs_val = rt_val;
    }
    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\n", pc, instr, rt, rt_val, rs, rs_val);
    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\n\n", prev_pc, instr_model, rt_model, rt_val_model, rs_model, rs_val_model);
    if (prev_pc != pc) {
        RUN_BIT = 0;
        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
        printf ("PC Mismatch\n");
        return 0;
    }
    else if (instr != instr_model) {
        RUN_BIT = 0;
        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
        printf ("INSTR Mismatch\n");
        return 0;
    }
    else if (rs != rs_model) {
        RUN_BIT = 0;
        printf ("Unexpected R%d Register\n", rs);
        printf ("Expecting  R%d Register\n", rs_model);
        return 0;
    }
    else if (rt != rt_model) {
        RUN_BIT = 0;
        printf ("Unexpected R%d Register\n", rt);
        printf ("Expecting  R%d Register\n", rt_model);
        return 0;
    }
    else if (rs_val != rs_val_model) {
        RUN_BIT = 0;
        printf ("RTL R%d VAL: %x\t Model R%d VAL: %x\n", rs, rs_val, rs_model, rs_val_model);
        printf ("RS Value Mismatch\n");
        return 0;
    }
    else if (rt_val != rt_val_model) {
        RUN_BIT = 0;
        printf ("RTL R%d VAL: %x\t Model R%d VAL: %x\n", rt, rt_val, rt_model, rt_val_model);
        printf ("RT Value Mismatch\n");
        return 0;
    }
    prev_pc = CURRENT_STATE.PC;
    return 1;
}

extern int compare_j (int pc, int instr, int rt, int rt_val) {
    int instr_model  = (int) instr_opcode;
    int rt_model     = (wr_link_reg) ? 0x1F : (instr_model >> 16)   & 0x1F;
    int rt_val_model = CURRENT_STATE.REGS[rt_model];
    if (wr_link_reg) {
        printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tR%d:%.8x\n", pc, instr,rt, rt_val);
        printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tR%d:%.8x\n\n", prev_pc, instr_model, rt_model, rt_val_model);
    }
    else {
        printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\n", pc, instr);
        printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\n\n", prev_pc, instr_model);
    }
    if (prev_pc != pc) {
        RUN_BIT = 0;
        printf ("RTL PC: %x\t Model PC: %x\n", pc, prev_pc);
        printf ("PC Mismatch\n");
        return 0;
    }
    else if (instr != instr_model) {
        RUN_BIT = 0;
        printf ("RTL INSTR: %x\t Model INSTR: %x\n", instr, instr_model);
        printf ("INSTR Mismatch\n");
        return 0;
    }
    else if (wr_link_reg & (rt != rt_model)) {
        RUN_BIT = 0;
        printf ("Unexpected R%d Register\n", rt);
        printf ("Expecting  R%d Register\n", rt_model);
        return 0;
    }
    else if (wr_link_reg & (rt_val != rt_val_model)) {
        RUN_BIT = 0;
        printf ("RTL R%d VAL: %x\t Model R%d VAL: %x\n", rt, rt_val, rt_model, rt_val_model);
        printf ("RT Value Mismatch\n");
        return 0;
    }
    prev_pc = CURRENT_STATE.PC;
    return 1;
}
