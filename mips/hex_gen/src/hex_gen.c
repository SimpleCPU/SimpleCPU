/***************************************************************/
/*                                                             */
/* hex_gen.c                                                   */
/* Creates a file with the hexadecimal opcodes                 */
/* of the requested instruction mix                            */
/*                                                             */
/***************************************************************/

#include "hex_gen.h"

void update_cpu (int pc, int hex_instr) {
    PC[pc]           = 1;
    instr[pc]        = hex_instr;
    //printf ("PC Update: PC[%x] = %d\tinstr[%x] = %x\n", pc, PC[pc], pc, instr[pc]);
    prev_pc = CURRENT_STATE.PC;
}

/* The following function checks if the calculated address      */
/* is a valid address. If the address is valid, the function    */
/* returns the addr.                                            */
int check_ls_addr (int rs, int imm) {
    int shift_val = shift_const(16);
    int sign = (imm & 0x8000)>>15;
    imm = (sign) ? (imm | shift_val) : imm;
    unsigned int addr = ((unsigned)CURRENT_STATE.REGS[rs] + (unsigned)imm);
    //printf("[LS] RS is %x\tIMM is %x\t ADDR is %x\n", CURRENT_STATE.REGS[rs], imm, addr);
    /* For now just check if the addr > 0   */
    /* if true, then the instruction is ok  */
    if ((addr > MEM_DATA_START) && (addr < (MEM_DATA_START + MEM_DATA_SIZE))) {
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
int check_brn_addr (int imm) {
    int shift_val = shift_const(14);
    int sign = (imm & 0x8000)>>15;
    imm = imm << 2;
    imm = (sign) ? (imm | shift_val) : imm;
    unsigned int addr = (unsigned) CURRENT_STATE.PC + 4 + (unsigned)imm;
    //printf("BRN ADDR is %x\n", addr);
    if ((addr > MEM_TEXT_START) && 
        (addr <= (MEM_TEXT_START + MEM_TEXT_SIZE - 0xFF)) && 
        (PC[addr]==0)) {
        return addr;
    }
    return -1;
}

/* The following function checks if the calculated address           */
/* is a valid jump address. If the address is valid, the function    */
/* returns 1.                                                        */
int check_j_addr (int addr) {
    // printf("Target is %x\t ADDR is %x\n", target, addr);
    // Reducing the range of jump address to avoid
    // PC from overflowing the memory region
    if ((addr > MEM_TEXT_START) && 
        (addr < (MEM_TEXT_START + MEM_TEXT_SIZE - 0xFF)) && 
        (PC[addr]==0)) {
        return 1;
    }
    return 0;
}

/* R instruction format     */
/* 31:26    opcode          */
/* 25:21    rs              */
/* 20:16    rt              */
/* 15:11    rd              */
/* 10:6     shamt           */
/* 5:0      funct           */
void print_assembled_r_instr (int funct, int rs, int rt, int rd) {
    printf ("%-4s %s, %s, %s\n\n", 
            funct_str_r_type[funct],
            register_str[rd],
            register_str[rs],
            register_str[rt]
    );
}

void gen_r_instr (int vopt, ...) {
    int     opcode, shamt, funct;
    int     rs, rt, rd;
    int     hex_instr;
    int     funct_idx;
    int     i;
    va_list valist;

    opcode      = 0;
    funct_idx   = 0;
    if (vopt) {
        va_start (valist, vopt);
        funct   = va_arg (valist, int);
        rd      = va_arg (valist, int);
        rs      = va_arg (valist, int);
        rt      = va_arg (valist, int);
        shamt   = va_arg (valist, int);
        va_end (valist);

        for (i = 0; i < 13; i++) {
            if (funct_val_r_type[i] == funct) {
                funct_idx = i;
                break;
            }
        }
    }
    else {
        funct_idx   = rand()%13;
        funct       = funct_val_r_type [funct_idx];
        rs          = rand ()%32;
        rt          = rand ()%32;
        rd          = rand ()%32;
        shamt       = rand ()%32;
    }

    hex_instr = (opcode << 26) + (rs << 21) +
                (rt << 16) + (rd << 11) +
                (shamt << 6) + funct;

    printf ("[%d] R Type instr generated - 0x%.7x\t\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    if (instr_gen == 0)
        update_cpu (0, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    print_assembled_r_instr (funct_idx, rs, rt, rd);
    instr_gen++;
}

/* I instruction format     */
/* 31:26    opcode          */
/* 25:21    rs              */
/* 20:16    rt              */
/* 15:0     imm             */
void print_assembled_i_instr (int opcode, int rs, int rt, int imm) {
    int sign_ext = 0;
    int sign = ((imm & 0x8000)>>15);
    if ((opcode_val_i_type[opcode] == ANDI) || 
        (opcode_val_i_type[opcode] == ORI)  ||
        (opcode_val_i_type[opcode] == XORI)
    ) {
        sign_ext = 0;
    }
    else {
        sign_ext = 1;
    }
    if (sign_ext) {
        imm = (sign) ? (imm | 0xFFFF0000) : (unsigned)imm;
    }
    printf ("%-4s %s, %s, 0x%x\n\n", 
            opcode_str_i_type[opcode],
            register_str[rt],
            register_str[rs],
            imm
    );
}

void gen_i_instr (int vopt, ...) {
    int     opcode;
    int     rs, rt;
    int     hex_instr;
    int     imm;
    int     opcode_idx;
    int     i;
    va_list valist;

    opcode_idx  = 0;
    if (vopt) {
        va_start (valist, vopt);
        opcode  = va_arg (valist, int);
        rt      = va_arg (valist, int);
        rs      = va_arg (valist, int);
        imm     = va_arg (valist, int);
        va_end (valist);

        for (i = 0; i < 17; i++) {
            if (opcode_val_i_type[i] == opcode) {
                opcode_idx = i;
                break;
            }
        }
    }
    else {
        opcode_idx  = rand()%17;
        opcode      = opcode_val_i_type [opcode_idx];
        rt          = rand() % 32;
    RS:
        rs      = rand() % 32;
    IMM:    
        imm     = rand() % 0xFFFF;   /* 16-bit signal */
    }
    if ((opcode == BGEZ) || (opcode == BGEZAL) ||
        (opcode == BLTZ) || (opcode == BLTZAL)
    ) {
        // This is true for the above mentioned branch variants.
        // ISA specifies that if opcode = 0x1 then the instruction
        // should further be decoded using the value present
        // at [20:16] field (which is RT itself)
        rt = opcode;
        opcode = 0x1;
    }
    if ((opcode == LW) || (opcode == SW)) {
        unsigned int addr = check_ls_addr (rs, imm);
        if (addr == 2) {
            // Report an error if the above was called with vopt set
            if (vopt) {
                printf ("ERROR: Unknown Load/Store Address generated\n");
                printf ("R%d cannot satisy the load/store address constraints!\n\n", rs);
            }
            else {
                goto RS;
            }
        }
        else if (addr == 0) {
            // Report an error if the above was called with vopt set
            if (vopt) {
                printf ("ERROR: Unknown Load/Store Address generated\n");
                printf ("Given IMM value (0x%08x) cannot satisy the load/store address constraints!\n\n", imm);
            }
            else {
                goto IMM;
            }
        }
        else {
            // The address is fine. Add it to the LS array
            ls_addr[instr_gen+1] = addr;
        }
    }
    if ((opcode == BVAR) || (opcode == BEQ)  ||
        (opcode == BGTZ) || (opcode == BLEZ) ||
        (opcode == BNE)) {
        unsigned int addr = check_brn_addr (imm);
        if ( addr == -1) {
            // Report an error if the above was called with vopt set
            if (vopt) {
                printf ("ERROR: Unknown Branch Address generated\n");
                printf ("Given IMM value (0x%08x) cannot satisy the branch target address constraints!\n\n", imm);
            }
            else {
                goto IMM;
            }
        }
        else {
            // The address is fine. Add it to the BR array
            br_addr[instr_gen+1] = addr;
        }
    }

    hex_instr = (opcode << 26) + (rs << 21) +
                (rt << 16)     + imm;

    printf ("[%d] I Type instr generated - 0x%-8x\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    if (instr_gen == 0)
        update_cpu (0, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    print_assembled_i_instr (opcode_idx, rs, rt, imm);
    instr_gen++;
}

/* J instruction format     */
/* 31:26    opcode          */
/* 25:0     target          */
void print_assembled_j_instr (int opcode, int target) {
    printf ("%-4s 0x%-8x\n\n", 
            opcode_str_j_type[opcode],
            target
    );
}

void gen_j_instr () {
    int     opcode, target;
    int     hex_instr;
    int     rand_opcode_idx = rand()%2;

    opcode  = opcode_val_j_type [rand_opcode_idx];
TARGET:
    target   = rand ()%0x3FFFFFF; // random number for 26 bit ie (2^26 - 1)
    unsigned int addr = (unsigned) (((CURRENT_STATE.PC+4) & 0xF0000000) | (target<<2));
    if ((check_j_addr (addr) == 0)) {
        goto TARGET;
    }
    else if (!PC[addr] == 0) {
        goto TARGET;
    }
    hex_instr = (opcode << 26) + target;

    printf ("[%d] J Type instr generated - 0x%.7x\t\n", instr_gen, hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    print_assembled_j_instr (rand_opcode_idx, target);
    if (instr_gen == 0)
        update_cpu (0, hex_instr);
    else
        update_cpu (prev_pc, hex_instr);
    instr_gen++;
}

int gen_j (int address) {		
    int opcode;		
    int target;		
    target = (address & 0xFFFFFFC)>>2;		
    opcode = (J << 26) + target;		
    return opcode;		
}

/* Function to check if there is enough      */
/* space available to generate the instr     */
/* If need more space the function would     */
/* insert a J instr to a somewhat free space */
void make_room () {
    int i;
    int opcode = 0;
    // There should be space for at least
    // two instructions. Check for PC valid
    //  if valid -> no space else it is okay
    if (((PC[CURRENT_STATE.PC] == 0) && (PC[CURRENT_STATE.PC+4]==0)) &&
        !(CURRENT_STATE.PC == 0xFFC)) {
        return;
    }
    // No space available. Inset Jump instr
    // Start the loop from 4 as there is
    // no need to check the [0] index since
    // it will always be valid
    //printf ("PC:%x\n", CURRENT_STATE.PC);
    for (i = 4; i < IMEM_SIZE; i=i+4) {
        if ((PC[i] == 0) && (PC[i+4]==0)) {
            //printf("Branching to the following PC:%x\n", i);
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

void gen_instr_hex (int num_r, int num_i, int num_j) {
    int i = 0;
    int n = num_r + num_i + num_j;
    int r_gen = 0, i_gen = 0, j_gen = 0;
    for (i = 0; i < n;) {
        int choice = rand () % 3;
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
            case 2: if (j_gen < num_j) {
                        make_room();
                        gen_j_instr ();
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
    for (i = 0; i < IMEM_SIZE; i=i+4) {
        if (PC[i]) {
            fprintf(pc_hex_val, "%x\n", i);
            fprintf(instr_hex_val, "%x\n", instr[i]);
        }
    }
}

int main (int argc, char* argv[]) {
    int num_r = 0;      /* Number of R-type instructions    */
    int num_i = 0;      /* Number of I-type instructions    */
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
      else if (!(strcmp (argv[i], (char*)"-j"))) {
        num_j = atoi(argv[i+1]);
      }
      i++;
    }
    n = num_r + num_i + num_j;
    if (n) {
        printf ("Generating the hex for the following set of instructions\n");
        printf ("\t %3d - R-Type instructions\n", num_r);
        printf ("\t %3d - I-Type instructions\n", num_i);
        printf ("\t %3d - J-Type instructions\n\n", num_j);
    }
    // Initialise the HEX-GEN tool
    init_hex_gen ();
    // External call to initialise the C-models memory
    init_memory ();
    // Begin generating instructions
    gen_instr_hex (num_r, num_i, num_j);
#ifdef GEN_USER_TEST
    gen_user_test ();
#endif
    gen_end_seq ();
    pc_hex_val    = fopen ("pc_values_hex", "w");
    instr_hex_val = fopen ("instr_hex", "w");
    print_to_file (pc_hex_val, instr_hex_val);
    return 0;
}
