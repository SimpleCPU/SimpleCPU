#include <stdio.h>
#include "main.h"

int decode_instr_type (uint32_t instr_opcode) {
    int type;
    if ((instr_opcode >> 26) == 0) { //R type
        type = 0;
        return type;
    }
    else if (((instr_opcode >> 26) == 2 ) || ((instr_opcode >> 26) == 3)) { //J type
        type = 1;
        return type;
    }
    else { //I type
        type = 2;
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
}


void execute_r (uint32_t rs, uint32_t rt, uint32_t rd, unsigned int shamt, unsigned int funct) {
    int sign;
    int shift_val;
    int64_t mul_res;
    if ((rd == 0) && (funct != 0x0c)) {
        NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        if ((funct == 0x00) || (funct == 0x02) ||
            (funct == 0x03) || (funct == 0x04) ||
            (funct == 0x06) || (funct == 0x07) ||
            (funct == 0x06) || (funct == 0x07)
        )
            rt_as_src = 1;
        return;
    }
    switch (funct) {
        case (0x00): //SLL
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] << shamt;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLL R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x02): //SRL
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> shamt;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SRL R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x03): //SRA
            rt_as_src = 1;
            sign = (CURRENT_STATE.REGS[rs] & 0x10000000)>>31;
            shift_val = shift_const(shamt);
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> shamt;
            NEXT_STATE.REGS[rd] = (sign == 1) ? NEXT_STATE.REGS[rd] | shift_val: NEXT_STATE.REGS[rd]; 
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SRA R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rt,
            shamt
        );
        break;
        case (0x04): //SLLV
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] << (CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLLV R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x06): //SRLV
            rt_as_src = 1;
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> (CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SRLV R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x07): //SRAV
            rt_as_src = 1;
            sign = (CURRENT_STATE.REGS[rs] & 0x10000000)>>31;
            shift_val = shift_const(CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rt] >> (CURRENT_STATE.REGS[rs] & 0x1F);
            NEXT_STATE.REGS[rd] = (sign == 1) ? NEXT_STATE.REGS[rd] | shift_val: NEXT_STATE.REGS[rd]; 
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SRAV R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x08): //JR
            NEXT_STATE.PC = CURRENT_STATE.REGS[rs];
            printf ("\nPC:%.8x\tINSTR:%.8x\t JR %-2d", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.PC
        );
        break;
        case (0x09): //JALR
            NEXT_STATE.PC = CURRENT_STATE.REGS[rs];
            NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t JALR %-2d", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.PC
        );
        break;
        case (0x20): //ADD
            NEXT_STATE.REGS[rd] = (int32_t)(CURRENT_STATE.REGS[rs] + CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t ADD R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x21): //ADDU
            NEXT_STATE.REGS[rd] = (uint32_t)(CURRENT_STATE.REGS[rs] + CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t ADDU R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x22): //SUB
            NEXT_STATE.REGS[rd] = (int32_t)(CURRENT_STATE.REGS[rs] - CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SUB R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x23): //SUBU
            NEXT_STATE.REGS[rd] = (uint32_t)(CURRENT_STATE.REGS[rs] - CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SUBU R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x24): //AND
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs] & CURRENT_STATE.REGS[rt];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t AND R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x25): //OR
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs] | CURRENT_STATE.REGS[rt];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t OR R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x26): //XOR
            NEXT_STATE.REGS[rd] = CURRENT_STATE.REGS[rs] ^ CURRENT_STATE.REGS[rt];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t XOR R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x27): //NOR
            NEXT_STATE.REGS[rd] = ~(CURRENT_STATE.REGS[rs] | CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t NOR R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x2a): //SLT
            NEXT_STATE.REGS[rd] = ((signed)CURRENT_STATE.REGS[rs] < (signed)CURRENT_STATE.REGS[rt]) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLT R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x2b): //SLTU
            NEXT_STATE.REGS[rd] = (CURRENT_STATE.REGS[rs] < CURRENT_STATE.REGS[rt]) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLTU R%-2d, R%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            rs,
            rt
        );
        break;
        case (0x18): //MULT
            mul_res = (int64_t)(CURRENT_STATE.REGS[rs] * CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = (int32_t)((mul_res>>32) & 0xFFFFFFFF);
            NEXT_STATE.LO = (int32_t)(mul_res & 0xFFFFFFFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t MULT HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.HI,
            NEXT_STATE.LO,
            rs,
            rt
        );
        break;
        case (0x10): //MFHI
            NEXT_STATE.REGS[rd] = CURRENT_STATE.HI;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t MFHI R%-2d\n, HI:%-2d", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            NEXT_STATE.HI
        );
        break;
        case (0x12): //MFLO
            NEXT_STATE.REGS[rd] = CURRENT_STATE.LO;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t MFLO R%-2d\n, LO:%-2d", 
            CURRENT_STATE.PC,
            instr_opcode,
            rd,
            NEXT_STATE.LO
        );
        break;
        case (0x11): //MTHI
            NEXT_STATE.HI = CURRENT_STATE.REGS[rs];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t MFHI HI:%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.HI,
            rs
        );
        break;
        case (0x13): //MTLO
            NEXT_STATE.LO = CURRENT_STATE.REGS[rs];
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t MTLO LO:%-2d, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.LO,
            rs
        );
        break;
        case (0x19): //MULTU
            mul_res = (uint64_t)((uint32_t)CURRENT_STATE.REGS[rs] * (uint32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = (uint32_t)((mul_res>>32) & 0xFFFFFFFF);
            NEXT_STATE.LO = (uint32_t)(mul_res & 0xFFFFFFFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t MULTU HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.HI,
            NEXT_STATE.LO,
            rs,
            rt
        );
        break;
        case (0x1a): //DIV
            NEXT_STATE.LO = ((int32_t)CURRENT_STATE.REGS[rs] / (int32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = ((int32_t)CURRENT_STATE.REGS[rs] % (int32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t DIV HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.HI,
            NEXT_STATE.LO,
            rs,
            rt
        );
        break;
        case (0x1b): //DIVU
            NEXT_STATE.LO = ((uint32_t)CURRENT_STATE.REGS[rs] / (uint32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.HI = ((uint32_t)CURRENT_STATE.REGS[rs] % (uint32_t)CURRENT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t DIVU HI:%-2d, LO:%-2d, R%-2d\n, R%-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.HI,
            NEXT_STATE.LO,
            rs,
            rt
        );
        break;
        case (0x0c): //SYSCALL
            if (CURRENT_STATE.REGS[2] == 0xA) {
                RUN_BIT = 0;
            }
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        default:
            printf ("ERROR. Incorrect instruction opcode\n");
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
    //printf ("I-side instruction\tOpcode is :0x%x\n", opcode);
    switch (opcode) {
        case (0x04): //BEQ
            if (CURRENT_STATE.REGS[rs] == CURRENT_STATE.REGS[rt]) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15 ? 1 : 0;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("\nPC:%.8x\tINSTR:%.8x\t BEQ R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rs,
            rt,
            imm
        );
        break;
        case (0x05): //BNE
            if (CURRENT_STATE.REGS[rs] != CURRENT_STATE.REGS[rt]) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15 ? 1 : 0;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("\nPC:%.8x\tINSTR:%.8x\t BNE R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rs,
            rt,
            imm
        );
        break;
        case (0x06): //BLEZ
            if ((int32_t)CURRENT_STATE.REGS[rs] <= 0) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15 ? 1 : 0;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("\nPC:%.8x\tINSTR:%.8x\t BLEZ R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rs,
            imm
        );
        break;
        case (0x07): //BGTZ
            if ((int32_t)CURRENT_STATE.REGS[rs] > 0) {
                shift_val = shift_const(14);
                sign = (imm & 0x8000)>>15 ? 1 : 0;
                imm = imm << 2;
                address = (sign) ? (imm | shift_val) : imm;
                NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
            }
            else {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            }
            printf ("\nPC:%.8x\tINSTR:%.8x\t BGTZ R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rs,
            imm
        );
        break;
        case (0x08): //ADDI
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLTU R%-2d, R%-2d, %-2d\n", 
                CURRENT_STATE.PC,
                instr_opcode,
                rs,
                rt,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            NEXT_STATE.REGS[rt] = CURRENT_STATE.REGS[rs] + imm;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            
        break;
        case (0x09): //ADDIU
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLTU R%-2d, R%-2d, %-2d\n", 
                CURRENT_STATE.PC,
                instr_opcode,
                rs,
                rt,
                imm
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            NEXT_STATE.REGS[rt] = CURRENT_STATE.REGS[rs] + imm;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (0x0a): //SLTI
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLTI R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rt,
            rs,
            rt
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = ((int32_t)CURRENT_STATE.REGS[rs] < (int32_t)imm) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (0x0b): //SLTIU
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SLTIU R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rt,
            rs,
            rt
            );
            if (rt == 0) {
                NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                return;
            }
            NEXT_STATE.REGS[rt] = ((uint32_t)CURRENT_STATE.REGS[rs] < (uint32_t)imm) ? 1 : 0;
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
        break;
        case (0x0c): //ANDI
            printf ("\nPC:%.8x\tINSTR:%.8x\t ANDI R%-2d, R%-2d, %-2d\n", 
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
        case (0x0d): //ORI
            printf ("\nPC:%.8x\tINSTR:%.8x\t ORI R%-2d, R%-2d, %-2d\n", 
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
        case (0x0e): //XORI
            printf ("\nPC:%.8x\tINSTR:%.8x\t XORI R%-2d, R%-2d, %-2d\n", 
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
        case (0x0f): //LUI
            printf ("\nPC:%.8x\tINSTR:%.8x\t LUI R%-2d, %-2d\n", 
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
        case (0x20): //LB
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFF;
            shift_val = shift_const(24);
            sign = (mem_content >> 7) ? 1 : 0;
            printf ("\nPC:%.8x\tINSTR:%.8x\t LB R%-2d, R%-2d, %-2d\n", 
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
        case (0x21): //LH
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFFFF;
            shift_val = shift_const(16);
            sign = (mem_content >> 15) ? 1 : 0;
            printf ("\nPC:%.8x\tINSTR:%.8x\t LH R%-2d, R%-2d, %-2d\n", 
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
        case (0x23): //LW
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) ;
            printf ("\nPC:%.8x\tINSTR:%.8x\t LW R%-2d, R%-2d, %-2d\n", 
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
        case (0x24): //LBU
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFF;
            printf ("\nPC:%.8x\tINSTR:%.8x\t LBU R%-2d, R%-2d, %-2d\n", 
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
        case (0x25): //LHU
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_content = mem_read_32((uint32_t)address) & 0xFFFF;
            printf ("\nPC:%.8x\tINSTR:%.8x\t LHU R%-2d, R%-2d, %-2d\n", 
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
        case (0x28): //SB
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_write_32(address, NEXT_STATE.REGS[rt]&0xFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SB R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rt,
            rs,
            imm
        );
        break;
        case (0x29): //SH
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_write_32(address, NEXT_STATE.REGS[rt]&0xFFFF);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SH R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rt,
            rs,
            imm
        );
        break;
        case (0x2b): //SW
            shift_val = shift_const(16);
            sign = (imm & 0x8000)>>15 ? 1 : 0;
            imm = (sign) ? (imm | shift_val) : imm;
            address = CURRENT_STATE.REGS[rs] + imm;
            mem_write_32(address, NEXT_STATE.REGS[rt]);
            NEXT_STATE.PC = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t SW R%-2d, R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rt,
            rs,
            imm
        );
        break;
        case (0x01): 
            if (CURRENT_STATE.REGS[rt] == 0) { //BLTZ
                if ((int32_t)CURRENT_STATE.REGS[rs] < 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15 ? 1 : 0;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
            }
            else if (CURRENT_STATE.REGS[rt] == 1) { //BGEZ
                if ((int32_t)CURRENT_STATE.REGS[rs] >= 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15 ? 1 : 0;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
            }
            else if (CURRENT_STATE.REGS[rt] == 0x10) { //BLTZAL
                if ((int32_t)CURRENT_STATE.REGS[rs] < 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15 ? 1 : 0;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                    NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
            }
            else if (CURRENT_STATE.REGS[rt] == 0x11) { //BGEZAL
                if ((int32_t)CURRENT_STATE.REGS[rs] >= 0) {
                    shift_val = shift_const(14);
                    sign = (imm & 0x8000)>>15 ? 1 : 0;
                    imm = imm << 2;
                    address = (sign) ? (imm | shift_val) : imm;
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4 + address;
                    NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
                }
                else {
                    NEXT_STATE.PC = CURRENT_STATE.PC + 4;
                }
            }
            printf ("\nPC:%.8x\tINSTR:%.8x\t LB R%-2d, %-2d\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            rs,
            imm
        );
        break;
        default:
            printf ("ERROR. Incorrect instruction opcode\n");
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
    int sign;
    int shift_val;
    uint32_t address;
    switch (opcode) { 
        case (0x02): //J
            address = (CURRENT_STATE.PC & 0xF0000000) | (target<<2);
            NEXT_STATE.PC = address;
            printf ("\nPC:%.8x\tINSTR:%.8x\t J %-8x\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.PC
        );
        break;
        case (0x03): //JAL
            address = (CURRENT_STATE.PC & 0xF0000000) | (target<<2);
            NEXT_STATE.PC = address;
            NEXT_STATE.REGS[31] = CURRENT_STATE.PC + 4;
            printf ("\nPC:%.8x\tINSTR:%.8x\t JAL %-8x\n", 
            CURRENT_STATE.PC,
            instr_opcode,
            NEXT_STATE.PC
        );
        break;
        default:
            printf ("ERROR. Incorrect instruction opcode\n");
            
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
    /* execute one instruction here. You should use CURRENT_STATE and modify
     * values in NEXT_STATE. You can call mem_read_32() and mem_write_32() to
     * access memory. */
    instr_opcode = mem_read_32(CURRENT_STATE.PC);
    int type = decode_instr_type (instr_opcode);
    if (type == 0)
        decode_r (instr_opcode);
    else if (type == 1)
        decode_j (instr_opcode);
    else 
        decode_i (instr_opcode);
}

/* The following function checks if the calculated address      */
/* is a valid address. If the address is valid, the function    */
/* returns 1.                                                   */
int check_ls_addr (int rs, int imm) {
    int shift_val = shift_const(16);
    int sign = (imm & 0x8000)>>15 ? 1 : 0;
    imm = (sign) ? (imm | shift_val) : imm;
    unsigned int addr = ((unsigned)CURRENT_STATE.REGS[rs] + (unsigned)imm);
    printf("RS is %x\tIMM is %x\t ADDR is %x\n", CURRENT_STATE.REGS[rs], imm, addr);
    /* For now just check if the addr > 0   */
    /* if true, then the instruction is ok  */
    if ((addr > MEM_DATA_START) && (addr < (MEM_DATA_START + MEM_DATA_SIZE))) {
        return 1;
    }
    else if ((unsigned)(CURRENT_STATE.REGS[rs] > (MEM_DATA_START + MEM_DATA_SIZE))) {
        return 2;
    }
    return 0;
}

/* The following function checks if the calculated address      */
/* is a valid branch address. If the address is valid, the      */
/* function returns 1.                                          */
int check_brn_addr (int imm) {
    int shift_val = shift_const(14);
    int sign = (imm & 0x8000)>>15 ? 1 : 0;
    imm = imm << 2;
    imm = (sign) ? (imm | shift_val) : imm;
    unsigned int addr = (unsigned) CURRENT_STATE.PC + 4 + (unsigned)imm;
    printf("BRN ADDR is %x\n", addr);
    /* For now just check if the addr > 0   */
    /* if true, then the instruction is ok  */
    if ((addr > MEM_TEXT_START) && (addr < (MEM_TEXT_START + MEM_TEXT_SIZE))) {
        return 1;
    }
    return 0;
}

/* The following function checks if the calculated address      */
/* is a valid address. If the address is valid, the function    */
/* returns 1.                                                   */
int check_j_addr (int target) {
    unsigned int addr = (((((unsigned)CURRENT_STATE.PC  + 4) >> 28) << 28) + ((unsigned)target << 2));
    // printf("Target is %x\t ADDR is %x\n", target, addr);
    /* For now just check if the addr > 0   */
    /* if true, then the instruction is ok  */
    if ((addr > MEM_TEXT_START) && (addr < (MEM_TEXT_START + MEM_TEXT_SIZE))) {
        return 1;
    }
    return 0;
}

extern int compare_r (int pc, int instr, int rd, int rs, int rt, int rd_val, int rs_val, int rt_val) {
    int instr_model = (int) mem_read_32(prev_pc);
    int rs_model     = (instr_model >> 21)   & 0x1F;
    int rt_model     = (instr_model >> 16)   & 0x1F;
    int rd_model     = (instr_model >> 11)   & 0x1F;
    rs_model         = (rt_as_src) ? rt_model : rs_model;
    int rs_val_model = CURRENT_STATE.REGS[rs_model];
    int rt_val_model = CURRENT_STATE.REGS[rt_model];
    int rd_val_model = CURRENT_STATE.REGS[rd_model];
    if (rs == rd) {
        rs_val = rd_val;
    }
    if (rt == rd) {
        rt_val = rd_val;
    }
    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\tR%d:%.8x\n", pc, instr, rd, rd_val, rs, rs_val, rt, rt_val);
    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\tR%d:%.8x\n", prev_pc, instr_model, rd_model, rd_val_model, rs_model, rs_val_model, rt_model, rt_val_model);
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
        printf ("RTL RD: %x\t Model RD: %x\n", rd, rd_model);
        printf ("RD Mismatch\n");
        return 0;
    }
    else if (rs != rs_model) {
        RUN_BIT = 0;
        printf ("RTL RS: %x\t Model RS: %x\n", rs, rs_model);
        printf ("RS Mismatch\n");
        return 0;
    }
    else if (rt != rt_model) {
        RUN_BIT = 0;
        printf ("RTL RT: %x\t Model RT: %x\n", rt, rt_model);
        printf ("RT Mismatch\n");
        return 0;
    }
    else if (rd_val != rd_val_model) {
        RUN_BIT = 0;
        printf ("RTL RD VAL: %x\t Model RD VAL: %x\n", rd_val, rd_val_model);
        printf ("RD Value Mismatch\n");
        return 0;
    }
    else if (rs_val != rs_val_model) {
        RUN_BIT = 0;
        printf ("RTL RS VAL: %x\t Model RS VAL: %x\n", rs_val, rs_val_model);
        printf ("RS Value Mismatch\n");
        return 0;
    }
    else if (rt_val != rt_val_model) {
        RUN_BIT = 0;
        printf ("RTL RT VAL: %x\t Model RT VAL: %x\n", rt_val, rt_val_model);
        printf ("RT Value Mismatch\n");
        return 0;
    }
    prev_pc = CURRENT_STATE.PC;
    rt_as_src = 0;
    return 1;
}

extern int compare_i (int pc, int instr, int rs, int rt, int rs_val, int rt_val) {
    int instr_model = (int) mem_read_32(prev_pc);
    int rs_model     = (instr_model >> 21)   & 0x1F;
    int rt_model     = (instr_model >> 16)   & 0x1F;
    int rs_val_model = (int) CURRENT_STATE.REGS[rs_model];
    int rt_val_model = (int) CURRENT_STATE.REGS[rt_model];
    if (rs == rt) {
        rs_val = rt_val;
    }
    printf ("[RTL]  \tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\n", pc, instr, rs, rs_val, rt, rt_val);
    printf ("[MODEL]\tPC:%.8x\tInstr:%.8x\tR%d:%.8x\tR%d:%.8x\n", prev_pc, instr_model, rs_model, rs_val_model, rt_model, rt_val_model);
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
        printf ("RTL RS: %x\t Model RS: %x\n", rs, rs_model);
        printf ("RS Mismatch\n");
        return 0;
    }
    else if (rt != rt_model) {
        RUN_BIT = 0;
        printf ("RTL RT: %x\t Model RT: %x\n", rt, rt_model);
        printf ("RT Mismatch\n");
        return 0;
    }
    else if (rs_val != rs_val_model) {
        RUN_BIT = 0;
        printf ("RTL RS VAL: %x\t Model RS VAL: %x\n", rs_val, rs_val_model);
        printf ("RS Value Mismatch\n");
        return 0;
    }
    else if (rt_val != rt_val_model) {
        RUN_BIT = 0;
        printf ("RTL RT VAL: %x\t Model RT VAL: %x\n", rt_val, rt_val_model);
        printf ("RT Value Mismatch\n");
        return 0;
    }
    prev_pc = CURRENT_STATE.PC;
    return 1;
}
