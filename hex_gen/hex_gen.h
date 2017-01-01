/***************************************************************/
/*                                                             */
/* hex_gen.h                                                   */
/* Creates a file with the hexadecimal opcodes                 */
/* of the requested instruction mix                            */
/*                                                             */
/***************************************************************/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#include "hex_gen_instr_defines.h"

struct CPU_Struct {
    int PC;             /* program counter                  */
    int instr;          /* the hex value of the instruction */
    int valid;          /* whether this entry is valid      */
} CPU[999];
int instr_gen = 0;      /* keeps a count of the number of   */
                        /* instructions generated           */
const int funct_val_r_type[13] = {
    ADD,        ADDU,       AND,
    /*DIV,        DIVU,       JALR,*/
    /*JR,         MFHI,       MFLO,*/
    /*MTHI,       MTLO,       MULT,*/
    /*MULTU,*/      NOR,        OR,
    SLL,        /*SLLV,*/       SLT,
    SLTU,       SRA,        /*SRAV,*/
    SRL,        /*SRLV,*/       SUB,
    SUBU,       /*SYSCALL,*/    XOR
};
const char* funct_str_r_type[13] = {
    "ADD",        "ADDU",       "AND",
    /*DIV,        DIVU,       JALR,*/
    /*JR,         MFHI,       MFLO,*/
    /*MTHI,       MTLO,       MULT,*/
    /*MULTU,*/      "NOR",        "OR",
    "SLL",        /*SLLV,*/       "SLT",
    "SLTU",       "SRA",        /*SRAV,*/
    "SRL",        /*SRLV,*/       "SUB",
    "SUBU",       /*SYSCALL,*/    "XOR"
};
/*const char* funct_str_r_type[27] = {
    "ADD",        "ADDU",       "AND",
    "DIV",        "DIVU",       "JALR",
    "JR",         "MFHI",       "MFLO",
    "MTHI",       "MTLO",       "MULT",
    "MULTU",      "NOR",        "OR",
    "SLL",        "SLLV",       "SLT",
    "SLTU",       "SRA",        "SRAV",
    "SRL",        "SRLV",       "SUB",
    "SUBU",       "SYSCALL",    "XOR"
};*/
const int opcode_val_i_type[7] = {
    ADDI,       ADDIU,      ANDI,
    /*BEQ,        BGEZ,       BGEZAL,
    BGTZ,       BLEZ,       BLTZ,
    BLTZAL,     BNE,        LB,
    LBU,        LH,         LHU,
    LUI,*/        /*LW,*/         ORI,
    /*SB,         SH,*/         /*SW,*/
    SLTI,       SLTIU,      XORI
};
const char* opcode_str_i_type[9] = {
    "ADDI",       "ADDIU",      "ANDI",
    /*BEQ,        BGEZ,       BGEZAL,
    BGTZ,       BLEZ,       BLTZ,
    BLTZAL,     BNE,        LB,
    LBU,        LH,         LHU,
    LUI,*/        /*"LW",*/         "ORI",
    /*SB,         SH,*/         /*"SW",*/
    "SLTI",       "SLTIU",      "XORI"
};
/*const char* opcode_str_i_type[24] = {
    "ADDI",       "ADDIU",      "ANDI",
    "BEQ",        "BGEZ",       "BGEZAL",
    "BGTZ",       "BLEZ",       "BLTZ",
    "BLTZAL",     "BNE",        "LB",
    "LBU",        "LH",         "LHU",
    "LUI",        "LW",         "ORI",
    "SB",         "SH",         "SW",
    "SLTI",       "SLTIU",      "XORI"
};*/
/*const int opcode_val_j_type[2] = {
    J,          JAL
};
const char* opcode_str_j_type[2] = {
    "J",          "JAL"
};*/
/*const char* register_str[] = {	
    "$0",       "$at",      "$v0",  
    "$v1",      "$a0",      "$a1",  
    "$a2",      "$a3",      "$t0",  
    "$t1",      "$t2",      "$t3",  
    "$t4",      "$t5",      "$t6",  
    "$t7",      "$s0",      "$s1",  
    "$s2",      "$s3",      "$s4",  
    "$s5",      "$s6",      "$s7", 
    "$t8",      "$t9",      "$k0",  
    "$k1",      "$gp",      "$sp", 
    "$fp",      "$ra",             
};*/
/* Currently the RTL only supports */
/* registers in the following format */
const char* register_str[] = {	
    "R0",       "R1",       "R2",  
    "R3",       "R4",       "R5",  
    "R6",       "R7",       "R8",  
    "R9",       "R10",      "R11",  
    "R12",      "R13",      "R14",  
    "R15",      "R16",      "R17",  
    "R18",      "R19",      "R20",  
    "R21",      "R22",      "R23", 
    "R24",      "R25",      "R26",  
    "R27",      "R28",      "R29", 
    "R30",      "R31",             
};

