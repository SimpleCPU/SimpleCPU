/***************************************************************/
/*                                                             */
/* hex_gen_instr_api.c                                         */
/* Defines all the functions used to                           */
/* generate a directed MIPS instruction                        */
/*                                                             */
/***************************************************************/

#include "hex_gen_shared.h"

void gen_r_type_ADD (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = ADD;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_ADDU (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = ADDU;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_AND (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = AND;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_DIV (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = DIV;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_DIVU (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = DIVU;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_JALR (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = JALR;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_JR (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = JR;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MFHI (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = MFHI;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MFLO (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = MFLO;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MTHI (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = MTHI;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MTLO (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = MTLO;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MULT (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = MULT;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MULTU (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = MULTU;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_NOR (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = NOR;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_OR (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = OR;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLL (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SLL;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLLV (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SLLV;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLT (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SLT;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLTU (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SLTU;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRA (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SRA;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRAV (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SRAV;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRL (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SRL;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRLV (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SRLV;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SUB (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SUB;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SUBU (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SUBU;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SYSCALL (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = SYSCALL;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_XOR (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = XOR;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}
