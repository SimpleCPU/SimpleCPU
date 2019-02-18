/***************************************************************/
/*                                                             */
/* hex_gen.c                                                   */
/* Creates a file with the hexadecimal opcodes                 */
/* of the requested instruction mix                            */
/*                                                             */
/***************************************************************/

#include "hex_gen.h"

void update_cpu (int pc, int hex_instr) {
    PC[pc-MEM_TEXT_START]           = 1;
    //printf ("PC[0x%x] = %d\n", pc-MEM_TEXT_START, PC[pc-MEM_TEXT_START]);
    instr[pc-MEM_TEXT_START] = hex_instr;
    prev_pc = CURRENT_STATE.PC;
}

/* The following function checks if the calculated address      */
/* is a valid address. If the address is valid, the function    */
/* returns the addr.                                            */
int check_ls_addr (int rs, int imm) {
    int shift_val = shift_const(20);
    int sign = (imm & 0x800)>>11;
    imm = (sign) ? (imm | shift_val) : imm;
    unsigned int addr = (CURRENT_STATE.REGS[rs] + imm) & 0xFFFFFFFC;
    //printf("[LS] RS is %x\tIMM is 0x%-8x\t ADDR is 0x%-8x\n", CURRENT_STATE.REGS[rs], imm, addr);
    /* For now just check if the addr > 0   */
    /* if true, then the instruction is ok  */
    if (((unsigned)addr > MEM_DATA_START) && ((unsigned)addr < (MEM_DATA_START + MEM_DATA_SIZE))) {
        return addr;
    }
    else if ((unsigned)(CURRENT_STATE.REGS[rs] > (MEM_DATA_START + MEM_DATA_SIZE))) {
        return 2;
    }
    return 0;
}

/* The following function checks if the calculated address      */
/* is a valid branch address. If the address is valid, the      */
/* function returns the address else -1 is returned             */
int check_brn_addr (int rs, int imm) {
    int shift_val = shift_const(19);
    int sign = (imm & 0x1000)>>12;
    imm = (sign) ? (imm | shift_val) : imm;
    unsigned addr = (unsigned) CURRENT_STATE.PC + (unsigned)imm;
    //printf("BRN ADDR is %x\n", addr);
    if (((unsigned)addr > MEM_TEXT_START) &&
        ((unsigned)addr <= (MEM_TEXT_START + MEM_TEXT_SIZE - 0xFF))) {
        if ((PC[addr-MEM_TEXT_START]==0)) {
            return addr;
        }
    }
    return -1;
}

/* The following function checks if the calculated address           */
/* is a valid jump address. If the address is valid, the function    */
/* returns 1.                                                        */
int check_j_addr (int imm, int funct, int rs1) {
    int shift_val = shift_const(11);
    int sign = (imm & 0x100000)>>20;
    if (funct == JALR) {
      shift_val = shift_const(20);
      sign = (imm & 0x800)>>11;
    }
    imm = (sign) ? (imm | shift_val) : imm;
    unsigned int addr = CURRENT_STATE.PC + (imm<<1);
    if (funct == JALR) {
      printf("RS[%d]: %x\tIMM: %x\n", rs1, CURRENT_STATE.REGS[rs1], imm<<1);
      addr = CURRENT_STATE.REGS[rs1]+ imm<<1;
    }
    printf("ADDR is %x\t\n", addr);
    //printf("PC: %x\n", CURRENT_STATE.PC); 
    // Reducing the range of jump address to avoid
    // PC from overflowing the memory region
    if (((unsigned)addr > MEM_TEXT_START) &&
        ((unsigned)addr <= (MEM_TEXT_START + MEM_TEXT_SIZE - 0xFF)) &&
        (PC[addr-MEM_TEXT_START]==0)) {
        return 1;
    }
    return 0;
}

/* R instruction format     */
/* 31:25    funct7          */
/* 24:20    rs2             */
/* 19:15    rs1             */
/* 14:12    funct3          */
/* 11:7     rd              */
/* 6:0      opcode          */
void print_assembled_r_instr (int funct, int rs1, int rs2, int rd) {
    printf ("%-4s %s, %s, %s\n\n", 
            funct_str_r_type[funct],
            register_str[rd],
            register_str[rs1],
            register_str[rs2]
    );
}

void gen_r_instr (int vopt, ...) {
    int     opcode, funct7, funct3;
    int     rs1, rs2, rd;
    int     hex_instr;
    int     funct, funct_idx;
    int     i;
    va_list valist;

    opcode      = 0x33;
    funct_idx   = 0;
    if (vopt) {
        va_start (valist, vopt);
        funct3  = va_arg (valist, int);
        rd      = va_arg (valist, int);
        rs1     = va_arg (valist, int);
        rs2     = va_arg (valist, int);
        funct7  = va_arg (valist, int);
        va_end (valist);
        funct   = ((funct7>>6 & 0x1) << 3) | funct3;

        for (i = 0; i < 10; i++) {
            if (funct_val_r_type[i] == funct) {
                funct_idx = i;
                break;
            }
        }
    }
    else {
        funct_idx   = rand()%10;
        funct3      = funct_val_r_type [funct_idx] & 0x7;
        funct7      = 0x0 | (((funct_val_r_type [funct_idx] >> 3) & 0x1) << 5);
        rs1         = rand ()%32;
        rs2         = rand ()%32;
        rd          = rand ()%32;
    }

    hex_instr = (funct7 << 25) + (rs2 << 20) +
                (rs1 << 15) + (funct3 << 12) +
                (rd << 7) + opcode;

    printf ("[%d] R Type instr generated - 0x%.7x\t\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    if (instr_gen == 0)
        update_cpu (MEM_TEXT_START, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    print_assembled_r_instr (funct_idx, rs1, rs2, rd);
    instr_gen++;
}

/* I instruction format     */
/* 31:20    imm             */
/* 19:15    rs1             */
/* 14:12    funct3          */
/* 11:7     rd              */
/* 6:0      opcode          */
void print_assembled_i_instr (int funct, int rs1, int rd, int imm) {
    int sign_ext = 0;
    int sign = ((imm & 0x800)>>11);
    //if ((opcode_val_i_type[opcode] == ANDI) || 
    //    (opcode_val_i_type[opcode] == ORI)  ||
    //    (opcode_val_i_type[opcode] == XORI)
    //) {
    //    sign_ext = 0;
    //}
    //else {
    //    sign_ext = 1;
    //}
    if (sign_ext) {
        imm = (sign) ? (imm | 0xFFFFF000) : (unsigned)imm;
    }
    printf ("%-4s %s, %s, 0x%x\n\n", 
            opcode_str_i_type[funct],
            register_str[rd],
            register_str[rs1],
            imm
    );
}

void gen_i_instr (int vopt, ...) {
    int     opcode;
    int     rs1, rd;
    int     hex_instr;
    int     imm;
    int     funct_idx;
    int     funct, funct3;
    int     i;
    va_list valist;

    funct_idx  = 0;
    if (vopt) {
        va_start (valist, vopt);
        funct3  = va_arg (valist, int);
        opcode  = va_arg (valist, int);
        rd      = va_arg (valist, int);
        rs1     = va_arg (valist, int);
        imm     = va_arg (valist, int);
        va_end (valist);
        funct   = ((opcode>>4 & 0x1) << 4) | funct3;

        for (i = 0; i < 8; i++) {
            if (opcode_val_i_type[i] == funct) {
                funct_idx = i;
                break;
            }
        }
    }
    else {
        funct_idx   = rand()%8;
        opcode      = (((opcode_val_i_type [funct_idx] >> 4) & 0x1) << 4) | 0x3;
        funct3      = ((opcode_val_i_type [funct_idx]) & 0x7);
        rd          = rand() % 32;
    RS1_I:
        rs1         = rand() % 32;
    IMM_I:    
        imm         = rand() % 0xFFF;   /* 12-bit signal */
    }
    funct   = ((opcode>>4 & 0x1) << 4) | funct3;
    if (((funct == LW) || (funct == LB))  ||
        ((funct == LH) || (funct == LBU)) ||
        ((funct == LHU))) {
        unsigned int addr = check_ls_addr (rs1, imm);
        if (addr == 2) {
            // Report an error if the above was called with vopt set
            if (vopt) {
                printf ("ERROR: Unknown Load/Store Address generated\n");
                printf ("R%d cannot satisy the load/store address constraints!\n\n", rs1);
            }
            else {
                goto RS1_I;
            }
        }
        else if (addr == 0) {
            // Report an error if the above was called with vopt set
            if (vopt) {
                printf ("ERROR: Unknown Load/Store Address generated\n");
                printf ("Given IMM value (0x%08x) cannot satisy the load/store address constraints!\n\n", imm);
            }
            else {
                goto IMM_I;
            }
        }
        else {
            // The address is fine. Add it to the LS array
            ls_addr[instr_gen+1] = addr;
        }
    }
    else if ((funct == JALR)) {
      if (check_j_addr (imm, JALR, rs1) == 0) {
        goto RS1_I;
      }
    }

    hex_instr = (imm << 20) + (rs1 << 15) + (funct3 << 12) +
                (rd << 7)   + opcode;

    printf ("[%d] I Type instr generated - 0x%-8x\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    if (instr_gen == 0)
        update_cpu (MEM_TEXT_START, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    print_assembled_i_instr (funct_idx, rs1, rd, imm);
    instr_gen++;
}

/* S instruction format     */
/* 31:25    imm[11:5]       */
/* 24:20    rs2             */
/* 19:15    rs1             */
/* 14:12    funct3          */
/* 11:7     imm[4:0]        */
/* 6:0      opcode          */
void print_assembled_s_instr (int funct, int rs1, int rs2, int imm) {
    int sign_ext = 0;
    int sign = ((imm & 0x800)>>11);
    if (sign_ext) {
        imm = (sign) ? (imm | 0xFFFFF000) : (unsigned)imm;
    }
    printf ("%-4s %s, %s, 0x%x\n\n", 
            opcode_str_s_type[funct],
            register_str[rs1],
            register_str[rs2],
            imm
    );
}

void gen_s_instr (int vopt, ...) {
    int     rs1, rs2;
    int     hex_instr;
    int     imm;
    int     funct_idx;
    int     funct3;
    int     opcode;
    int     i;
    va_list valist;
    unsigned int addr;

    funct_idx  = 0;
    if (vopt) {
        va_start (valist, vopt);
        funct3  = va_arg (valist, int);
        rs1     = va_arg (valist, int);
        rs2     = va_arg (valist, int);
        imm     = va_arg (valist, int);
        va_end (valist);

        for (i = 0; i < 1; i++) {
            if (opcode_val_s_type[i] == funct3) {
                funct_idx = i;
                break;
            }
        }
    }
    else {
        funct_idx   = rand()%1;
        opcode      = 0x23;
        funct3      = opcode_val_s_type [funct_idx];
        rs1         = rand() % 32;
        rs2         = rand() % 32;
        imm         = rand() % 0xFFF;   /* 12-bit signal */
        goto OUT_S;
    RS2_S:
        rs2         = rand() % 32;
        goto OUT_S;
    IMM_S:    
        imm         = rand() % 0xFFF;   /* 12-bit signal */
        goto OUT_S;
    }
    OUT_S:
    addr = check_ls_addr (rs2, imm);
    if (addr == 2) {
        // Report an error if the above was called with vopt set
        if (vopt) {
            printf ("ERROR: Unknown Load/Store Address generated\n");
            printf ("R%d cannot satisy the load/store address constraints!\n\n", rs2);
        }
        else {
            goto RS2_S;
        }
    }
    else if (addr == 0) {
        // Report an error if the above was called with vopt set
        if (vopt) {
            printf ("ERROR: Unknown Load/Store Address generated\n");
            printf ("Given IMM value (0x%08x) cannot satisy the load/store address constraints!\n\n", imm);
        }
        else {
            goto IMM_S;
        }
    }
    else {
        // The address is fine. Add it to the LS array
        ls_addr[instr_gen+1] = addr;
    }

    hex_instr = ((imm >> 5) << 25) + (rs2 << 20) + (rs1 << 15) + 
                (funct3 << 12) + ((imm & 0x1F) << 7) + opcode;

    printf ("[%d] S Type instr generated - 0x%-8x\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    if (instr_gen == 0)
        update_cpu (MEM_TEXT_START, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    print_assembled_s_instr (funct_idx, rs1, rs2, imm);
    instr_gen++;
}

/* B instruction format     */
/* 31:25    imm[12|10:5]    */
/* 24:20    rs2             */
/* 19:15    rs1             */
/* 14:12    funct3          */
/* 11:7     imm[4:1|11]     */
/* 6:0      opcode          */
void print_assembled_b_instr (int funct, int rs1, int rs2, int imm) {
    int sign_ext = 0;
    int sign = ((imm & 0x1000)>>12);
    if (sign_ext) {
        imm = (sign) ? (imm | 0xFFFFE000) : (unsigned)imm;
    }
    printf ("%-4s %s, %s, 0x%x\n\n", 
            opcode_str_b_type[funct],
            register_str[rs1],
            register_str[rs2],
            imm
    );
}

void gen_b_instr (int vopt, ...) {
    int     rs1, rs2;
    int     hex_instr;
    int     imm;
    int     funct_idx;
    int     funct3;
    int     i;
    int     opcode;
    int     branch_taken;
    unsigned int addr;
    va_list valist;

    funct_idx  = 0;
    if (vopt) {
        va_start (valist, vopt);
        funct3  = va_arg (valist, int);
        rs1     = va_arg (valist, int);
        rs2     = va_arg (valist, int);
        imm     = va_arg (valist, int);
        va_end (valist);

        for (i = 0; i < 3; i++) {
            if (opcode_val_b_type[i] == funct3) {
                funct_idx = i;
                break;
            }
        }
    }
    else {
        funct_idx   = rand()%6;
        opcode      = 0x63;
        funct3      = opcode_val_b_type [funct_idx];
        rs1         = rand() % 32;
        rs2         = rand() % 32;
    IMM_B:    
        imm         = rand() % 0xFFF;   /* 12-bit signal */
        imm         = imm << 2;
    }
    branch_taken = decode_brn_result (rs1, rs2, funct3);
    if (branch_taken) {
      addr = check_brn_addr (rs1, imm);
      if (addr == -1) {
          // Report an error if the above was called with vopt set
          if (vopt) {
              printf ("ERROR: Unknown Branch Address generated\n");
              printf ("Given IMM value (0x%08x) cannot satisy the Branch address constraints!\n\n", imm);
          }
          else {
              goto IMM_B;
          }
      }
      else {
          // The address is fine. Add it to the BR array
          br_addr[instr_gen+1] = addr;
      }
    }

    hex_instr = ((imm >> 12) << 31) + (((imm >> 5) & 0x3F) << 25) + (rs2 << 20) + 
                (rs1 << 15) + (funct3 << 12) + (((imm >> 1) & 0xF) << 8) +
                (((imm >> 11) & 0x1) << 7)   + opcode;

    printf ("[%d] B Type instr generated - 0x%-8x\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    if (instr_gen == 0)
        update_cpu (MEM_TEXT_START, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    print_assembled_b_instr (funct_idx, rs1, rs2, imm);
    instr_gen++;
}

int decode_brn_result (rs1, rs2, funct3) {
  int branch_taken = 0;

  switch (funct3) {
      case (BEQ): //BEQ
          if (CURRENT_STATE.REGS[rs1] == CURRENT_STATE.REGS[rs2]) {
            branch_taken = 1;
          }
      break;
      case (BNE): //BNE
          if (CURRENT_STATE.REGS[rs1] != CURRENT_STATE.REGS[rs2]) {
            branch_taken = 1;
          }
      break;
      case (BLT): //BLT
          if ((signed)CURRENT_STATE.REGS[rs1] < (signed)CURRENT_STATE.REGS[rs2]) {
            branch_taken = 1;
          }
      break;
      case (BLTU): //BLTU
          if ((unsigned)CURRENT_STATE.REGS[rs1] < (unsigned)CURRENT_STATE.REGS[rs2]) {
            branch_taken = 1;
          }
      break;
      case (BGE): //BGE
          if ((signed)CURRENT_STATE.REGS[rs1] >= (signed)CURRENT_STATE.REGS[rs2]) {
            branch_taken = 1;
          }
      break;
      case (BGEU): //BGEU
          if (CURRENT_STATE.REGS[rs1] >= CURRENT_STATE.REGS[rs2]) {
            branch_taken = 1;
          }
      break;
  }
  return branch_taken;
}

/* U instruction format     */
/* 31:12    imm             */
/* 11:7     rd              */
/* 6:0      opcode          */
void print_assembled_u_instr (int opcode, int rd, int imm) {
    printf ("%-4s %s, 0x%x\n\n", 
            opcode_str_u_type[opcode],
            register_str[rd],
            imm
    );
}

void gen_u_instr (int vopt, ...) {
    int     rd;
    int     hex_instr;
    int     imm;
    int     opcode_idx;
    int     opcode;
    int     i;
    va_list valist;

    opcode_idx  = 0;
    if (vopt) {
        va_start (valist, vopt);
        opcode  = va_arg (valist, int);
        rd      = va_arg (valist, int);
        imm     = va_arg (valist, int);
        va_end (valist);

        for (i = 0; i < 3; i++) {
            if (opcode_val_u_type[i] == opcode) {
                opcode_idx = i;
                break;
            }
        }
    }
    else {
        opcode_idx  = rand()%2;
        opcode      = opcode_val_u_type [opcode_idx];
        rd          = rand() % 32;
        imm         = rand() % 0xFFFFF;   /* 20-bit signal */
    }

    hex_instr = (imm << 12) + (rd << 7) + opcode;

    printf ("[%d] U Type instr generated - 0x%-8x\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    if (instr_gen == 0)
        update_cpu (MEM_TEXT_START, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    print_assembled_u_instr (opcode_idx, rd, imm);
    instr_gen++;
}

/* J instruction format             */
/* 31:12    imm[20|10:1|11|19:12]   */
/* 11:7     rd                      */
/* 6:0      opcode                  */
void print_assembled_j_instr (int opcode, int rd, int imm) {
    printf ("%-4s %s, 0x%-8x\n\n", 
            opcode_str_j_type[opcode],
            register_str[rd],
            imm
    );
}

void gen_j_instr (int vopt, ...) {
    int     opcode, imm;
    int     rd;
    int     hex_instr;
    va_list valist;
    int     i;
    int     opcode_idx = rand()%1;

    opcode  = 0x6F;
    if (vopt) {
        va_start (valist, vopt);
        opcode  = va_arg (valist, int);
        rd      = va_arg (valist, int);
        imm     = va_arg (valist, int);
        va_end (valist);

        for (i = 0; i < 1; i++) {
            if (opcode_val_u_type[i] == opcode) {
                opcode_idx = i;
                break;
            }
        }
    }
    else {
        rd = rand() % 32;
    IMM_J:
        imm = (rand() % 0x100000) + 1;
        imm = imm << 2;
    }

    if ((check_j_addr(imm, 0, 0) == 0)) {
        goto IMM_J;
    }
    
    hex_instr = (((imm >> 20) & 0x1) << 31) + (((imm >> 1) & 0x3FF) << 21) +
                (((imm >> 11) & 0x1) << 20) + (((imm >> 12) & 0xFF) << 12) +
                (rd << 7) + opcode;
    printf ("[%d] J Type instr generated - 0x%.7x\t\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    print_assembled_j_instr (opcode_idx, rd, imm);
    if (instr_gen == 0)
        update_cpu (MEM_TEXT_START, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    instr_gen++;
}

int gen_j (int address) {
    int opcode = 0;
    int target;
    target = (address - CURRENT_STATE.PC)>>1;
    //printf ("TARGET:0x%.8x\tCURRENT_PC:0x%.8x\n", target, CURRENT_STATE.PC);
    opcode = (((target >> 19) & 0x1) << 31) + (((target >> 0) & 0x3FF) << 21) +
             (((target >> 10) & 0x1) << 20) + (((target >> 11) & 0xFF) << 12) +
             ((rand()%32) << 7) + 0x6F;
    return opcode;
}

/* Function to check if there is enough      */
/* space available to generate the instr     */
/* If need more space the function would     */
/* insert a J instr to a somewhat free space */
void make_room () {
    unsigned i;
    int opcode = 0;
    unsigned int pc   = (unsigned)(CURRENT_STATE.PC - MEM_TEXT_START);
    unsigned int pc_q = (unsigned)(CURRENT_STATE.PC + 4 - MEM_TEXT_START);
    // There should be space for at least
    // two instructions. Check for PC valid
    //  if valid -> no space else it is okay
    if (((PC[pc] == 0) && (PC[pc_q]==0)) &&
        !(pc == (MEM_TEXT_START+MEM_TEXT_SIZE-0xFF))) {
        return;
    }
    // No space available. Insert Jump instr
    // Start the loop from 4 as there is
    // no need to check the [0] index since
    // it will always be valid
    //printf ("PC:%x\n", CURRENT_STATE.PC);
    for (i = MEM_TEXT_START+4; i < (MEM_TEXT_START+MEM_TEXT_SIZE); i=i+4) {
        if ((PC[i-MEM_TEXT_START] == 0) && (PC[i+4-MEM_TEXT_START]==0)) {
            //printf("Branching to the following PC:0x%.8x\n", i);
            opcode = gen_j ((int)i);
            load_instr_opcode ((uint32_t)opcode);
            run (1);
            update_cpu (prev_pc, opcode);
            return;
        }
    }
    printf ("\nExit! PC overflow.\n");
    exit (0);
}

void gen_end_seq () {
    //FILE * dump;
    make_room ();
    int opcode = 0x2002000a;  // ADDU R10, R0, 0xa
    update_cpu (CURRENT_STATE.PC, opcode);
    load_instr_opcode ((uint32_t)opcode);
    run (1);
    instr_gen++;

    make_room ();
    opcode = 0x0000000c;      // SYSCALL
    update_cpu (CURRENT_STATE.PC, opcode);
    load_instr_opcode ((uint32_t)opcode);
    run (1);
    //dump = fopen ("dump", "w");
    //rdump (dump);
}

void gen_instr_hex (int num_r, int num_i, int num_s, int num_b, int num_u, int num_j) {
    int i = 0;
    int n = num_r + num_i + num_s + num_b + num_u + num_j;
    int r_gen = 0, i_gen = 0, s_gen = 0, b_gen = 0, u_gen = 0, j_gen = 0;
    int choice;
    for (i = 0; i < n;) {
        choice = rand () % 6;
        switch (choice) {
            case 0: if (r_gen < num_r) {
                        make_room();
                        gen_r_instr (0);
                        r_gen++;
                        i++;
                        break;
                    }
                    else break;
            case 1: if (i_gen < num_i) {
                        make_room();
                        gen_i_instr (0);
                        i_gen++;
                        i++;
                        break;
                    }
                    else break;
            case 2: if (s_gen < num_s) {
                        make_room();
                        gen_s_instr (0);
                        s_gen++;
                        i++;
                        break;
                    }
                    else break;
            case 3: if (b_gen < num_b) {
                        make_room();
                        gen_b_instr (0);
                        b_gen++;
                        i++;
                        break;
                    }
                    else break;
            case 4: if (u_gen < num_u) {
                        make_room();
                        gen_u_instr (0);
                        u_gen++;
                        i++;
                        break;
                    }
                    else break;
            case 5: if (j_gen < num_j) {
                        make_room();
                        gen_j_instr (0);
                        j_gen++;
                        i++;
                        break;
                    }
                    else break;
        }
    }
}

void print_to_file (FILE* pc_hex_val, FILE* instr_hex_val) {
    int i = 0;
    for (i = 0; i < (IMEM_SIZE); i=i+4) {
        if (PC[i]) {
            fprintf(pc_hex_val, "%x\n", i+MEM_TEXT_START);
            fprintf(instr_hex_val, "%x\n", instr[i]);
        }
    }
}

int main (int argc, char* argv[]) {
    int num_r = 0;      /* Number of R-type instructions    */
    int num_i = 0;      /* Number of I-type instructions    */
    int num_s = 0;      /* Number of S-type instructions    */
    int num_b = 0;      /* Number of B-type instructions    */
    int num_u = 0;      /* Number of U-type instructions    */
    int num_j = 0;      /* Number of J-type instructions    */
    int n = 0;          /* Number of instructions           */
    /* Parse argv array and extract all the information     */
    /* argv array is null terminated                        */
    int i = 0;
    while (argv[i]) {
      if (!(strcmp (argv[i], (char*)"-r"))) {
        num_r = atoi(argv[i+1]);
      }
      else if (!(strcmp (argv[i], (char*)"-i"))) {
        num_i = atoi(argv[i+1]);
      }
      else if (!(strcmp (argv[i], (char*)"-s"))) {
        num_s = atoi(argv[i+1]);
      }
      else if (!(strcmp (argv[i], (char*)"-b"))) {
        num_b = atoi(argv[i+1]);
      }
      else if (!(strcmp (argv[i], (char*)"-u"))) {
        num_u = atoi(argv[i+1]);
      }
      else if (!(strcmp (argv[i], (char*)"-j"))) {
        num_j = atoi(argv[i+1]);
      }
      i++;
    }
    n = num_r + num_i + num_s + num_b + num_u + num_j;
    if (n) {
        printf ("Generating the hex for the following set of instructions\n");
        printf ("\t %3d - R-Type instructions\n", num_r);
        printf ("\t %3d - I-Type instructions\n", num_i);
        printf ("\t %3d - S-Type instructions\n", num_s);
        printf ("\t %3d - B-Type instructions\n", num_b);
        printf ("\t %3d - U-Type instructions\n", num_u);
        printf ("\t %3d - J-Type instructions\n\n", num_j);
    }
    // Initialise the HEX-GEN tool
    init_hex_gen ();
    // External call to initialise the C-models memory
    init_memory ();
    // Begin generating instructions
    gen_instr_hex (num_r, num_i, num_s, num_b, num_u, num_j);
//#ifdef GEN_USER_TEST
//    gen_user_test ();
//#endif
    //gen_end_seq ();
    pc_hex_val    = fopen ("pc_values_hex", "w");
    instr_hex_val = fopen ("instr_hex", "w");
    print_to_file (pc_hex_val, instr_hex_val);
    return 0;
}
