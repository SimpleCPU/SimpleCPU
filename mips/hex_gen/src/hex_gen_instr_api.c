/***************************************************************/
/*                                                             */
/* hex_gen_instr_api.c                                         */
/* Defines all the functions used to                           */
/* generate a directed MIPS instruction                        */
/*                                                             */
/***************************************************************/

#include "hex_gen_shared.h"

void gen_r_type_ADD (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = ADD;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_ADDU (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = ADDU;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_AND (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = AND;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_DIV (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = DIV;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_DIVU (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = DIVU;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_JALR (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = JALR;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_JR (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = JR;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MFHI (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = MFHI;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MFLO (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = MFLO;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MTHI (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = MTHI;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MTLO (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = MTLO;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MULT (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = MULT;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_MULTU (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = MULTU;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_NOR (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = NOR;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_OR (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = OR;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLL (int RD, int RS, int RT, int shamt, int set_rval, ...) {
    int     funct;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SLL;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLLV (int RD, int RS, int RT, int shamt, int set_rval, ...) {
    int     funct;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SLLV;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLT (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SLT;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SLTU (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SLTU;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRA (int RD, int RS, int RT, int shamt, int set_rval, ...) {
    int     funct;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SRA;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRAV (int RD, int RS, int RT, int shamt, int set_rval, ...) {
    int     funct;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SRAV;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRL (int RD, int RS, int RT, int shamt, int set_rval, ...) {
    int     funct;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SRL;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SRLV (int RD, int RS, int RT, int shamt, int set_rval, ...) {
    int     funct;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SRLV;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SUB (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SUB;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SUBU (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = SUBU;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_SYSCALL () {
    int     funct;
    int     shamt;
    int     vopt;
    int     RD;
    int     RS;
    int     RT;

    funct   = SYSCALL;
    shamt   = 0;
    vopt    = 5;
    RD      = 0;
    RS      = 0;
    RT      = 0;
    
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_r_type_XOR (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = XOR;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}

void gen_i_type_ADDI (int RT, int RS, int imm, int set_rval, ...) {
    int     opcode;
    int     vopt;
    int     rs_val;
    va_list valist;

    opcode      = ADDI;
    vopt        = 4;
    if (imm > MAX_16_BIT_IMM) {
        printf ("ERROR: Expecting a 16-bit IMM value\n");
        printf ("Given IMM value (0x%08x) greater than maximum allowed value (0x%08x)\n\n", imm, MAX_16_BIT_IMM);
        err_count++;
        return;
    }
    make_room ();
    gen_i_instr (vopt, opcode, RT, RS, imm);
}
