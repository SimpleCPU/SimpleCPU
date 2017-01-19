/***************************************************************/
/*                                                             */
/* hex_gen.c                                                   */
/* Creates a file with the hexadecimal opcodes                 */
/* of the requested instruction mix                            */
/*                                                             */
/***************************************************************/

#include "hex_gen.h"

void update_cpu (int pc, int instr, int valid) {
    CPU[instr_gen].PC       = pc;
    CPU[instr_gen].instr    = instr;
    CPU[instr_gen].valid    = valid;
}

/* I instruction format     */
/* 31:26    opcode          */
/* 25:21    rs              */
/* 20:16    rt              */
/* 15:0     imm             */
void print_assembled_i_instr (int opcode, int rs, int rt, int imm) {
    int sign_ext = 0;
    int sign = ((imm & 0x8000)>>15);
    if ((opcode == 2) || 
        (opcode == 5) ||
        (opcode == 9)
    ) {
        sign_ext = 0;
    }
    else {
        sign_ext = 1;
    }
    if (sign_ext) {
        imm = (sign) ? imm | 0xFFFF0000 : imm;
    }
    printf ("%4s %s, %s, %x\n", 
            opcode_str_i_type[opcode],
            register_str[rt],
            register_str[rs],
            imm
    );
}

void gen_i_instr () {
    int     opcode;
    int     rs, rt;
    int     hex_instr;
    int     imm;
    int     rand_opcode_idx;
    START:
    rand_opcode_idx = rand()%10;

    opcode  = opcode_val_i_type [rand_opcode_idx];
    rt      = rand() % 32;
RS:
    rs      = rand() % 32;
IMM:    
    imm     = rand() % 65535;   /* 16-bit signal */

    if ((rand_opcode_idx == 4) || (rand_opcode_idx == 6)) {
        if ((check_ls_addr (rs, imm)) == 2) goto RS;
        if ((check_ls_addr (rs, imm)) == 0) goto IMM;
    }
    if ((rand_opcode_idx == 3)) {
        goto START;
        //if ((check_brn_addr (imm)) == 0) goto IMM;
    }
    hex_instr = (opcode << 26) + (rs << 21) +
                (rt << 16)     + imm;

    printf ("I Type instr generated - 0x%8x\t\n", hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    print_assembled_i_instr (rand_opcode_idx, rs, rt, imm);
    if (instr_gen == 0)
        update_cpu (0, hex_instr, 1);
    else
        update_cpu (prev_pc, hex_instr, 1);
    prev_pc = CURRENT_STATE.PC;
    instr_gen++;
}

/* R instruction format     */
/* 31:26    opcode          */
/* 25:21    rs              */
/* 20:16    rt              */
/* 15:11    rd              */
/* 10:6     shamt           */
/* 5:0      funct           */
void print_assembled_r_instr (int funct, int rs, int rt, int rd) {
    printf ("%4s %s, %s, %s\n", 
            funct_str_r_type[funct],
            register_str[rd],
            register_str[rs],
            register_str[rt]
    );
}

void gen_r_instr () {
    int     opcode, shamt, funct;
    int     rs, rt, rd;
    int     hex_instr;
    int     rand_funct_idx = rand()%13;

    opcode  = 0;
    funct   = funct_val_r_type [rand_funct_idx];
    shamt   = rand ()%32;
    rs      = rand ()%32;
    rt      = rand ()%32;
    rd      = rand ()%32;

    hex_instr = (opcode << 26) + (rs << 21) +
                (rt << 16) + (rd << 11) +
                (shamt << 6) + funct;

    printf ("R Type instr generated - 0x%.7x\t\n", hex_instr);
    load_instr_opcode ((uint32_t) hex_instr);
    run (1);
    print_assembled_r_instr (rand_funct_idx, rs, rt, rd);
    if (instr_gen == 0)
        update_cpu (0, hex_instr, 1);
    else
        update_cpu (prev_pc, hex_instr, 1);
    prev_pc = CURRENT_STATE.PC;
    instr_gen++;
}

void gen_end_seq () {
    //FILE * dump;
    int opcode = 0x2402000a;
    update_cpu (CPU[instr_gen-1].PC + 4, opcode, 1);
    load_instr_opcode ((uint32_t)opcode);
    run (1);
    instr_gen++;
    opcode = 0x0000000c;
    update_cpu (CPU[instr_gen-1].PC + 4, opcode, 1);
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
        int choice = rand () % 2;
        switch (choice) {
            // TODO: Add logic such that exact number 
            // of R, I and J instructions are generated
            case 0: if (r_gen < num_r) {
                        gen_r_instr ();
                        r_gen++;
                        i++;
                        break;
                    }
                    else break;
            case 1: if (i_gen < num_i) {
                        gen_i_instr ();
                        i_gen++;
                        i++;
                        break;
                    }
                    else break;
            case 2: if (j_gen < num_j) {
                        //gen_j_instr ();
                        j_gen++;
                        i++;
                        break;
                    }
                    else break;
        }
    }
    gen_end_seq ();
}

void print_to_file (FILE* pc_val, FILE* instr_hex, int n) {
    int i = 0;
    for (i = 0; i < n + NUM_END_SEQ_INSTR; i++) {
        fprintf(pc_val, "%x\n", CPU[i].PC);
        fprintf(instr_hex, "%x\n", CPU[i].instr);
    }
}

void init () {
    CPU[0].PC = 0;
}

int main (int argc, char* argv[]) {
    int num_r = 0;      /* number of r-type instructions    */
    int num_i = 0;      /* number of i-type instructions    */
    int num_j = 0;      /* number of j-type instructions    */
    int n = 0;          /* number of instructions           */
    FILE *pc_val;       /* output file pointer for PC values*/
    FILE *instr_hex;    /* output file pointer for instr hex*/
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
    if (n == 0) {
        printf ("Zero instructions were generated\n");
        return 1;
    }
    else {
        printf ("Generating the hex for the following set of instructions\n");
        printf ("\t %3d - R-Type instructions\n", num_r);
        printf ("\t %3d - I-Type instructions\n", num_i);
        printf ("\t %3d - J-Type instructions\n", num_j);
    }

    init ();
    init_memory ();
    gen_instr_hex (num_r, num_i, num_j);
    pc_val    = fopen ("pc_values_hex", "w");
    instr_hex = fopen ("instr_hex", "w");
    print_to_file (pc_val, instr_hex, n);
    return 0;
}
