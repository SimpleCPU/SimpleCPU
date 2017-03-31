/***************************************************************/
/*                                                             */
/* hex_gen.h                                                   */
/* Creates a file with the hexadecimal opcodes                 */
/* of the requested instruction mix                            */
/*                                                             */
/***************************************************************/

#ifndef HEX_GEN_H
#define HEX_GEN_H
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "mips_instr_defines.h"

#define NUM_END_SEQ_INSTR 2

int PC[4096];             /* program counter arr - index using PC */
int instr[4096];          /* the hex value of the instruction     */

typedef struct CPU_State_Struct {
  uint32_t PC;		      /* program counter */
  uint32_t REGS[32];      /* register file. */
  uint32_t HI, LO;        /* special regs for mult/div. */
} CPU_State;

/* Data Structure for Latch */
extern CPU_State CURRENT_STATE;
int instr_gen = 0;      /* keeps a count of the number of   */
                        /* instructions generated           */

/* Declare all the external functions here */
extern int shift_const (int);
extern void load_instr_opcode (uint32_t);
extern void run (int);
extern int check_ls_addr (int, int);
extern void init_memory ();

/* Declare all the internally used functions here */
void update_cpu (int, int);
int check_brn_addr (int);
int check_j_addr (int);
void gen_r_instr ();
void print_assembled_r_instr (int, int, int, int);
void gen_i_instr ();
void print_assembled_i_instr (int, int, int, int);
void gen_j_instr ();
void print_assembled_j_instr (int, int);
void make_room ();
void gen_end_seq ();
void gen_instr_hex (int, int, int);
void print_to_file (FILE*, FILE*);

extern int prev_pc;
FILE* pc_hex_val;
FILE* instr_hex_val;

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
const int opcode_val_i_type[17] = {
    ADDI,       ADDIU,      ANDI,
    BEQ,        BGEZ,       BGEZAL,
    BGTZ,       BLEZ,       BLTZ,
    BLTZAL,     BNE,        /*LB,
    LBU,        LH,         LHU,
    LUI,*/        LW,         ORI,
    /*SB,         SH,*/         SW,
    SLTI,       SLTIU,      XORI
};
const char* opcode_str_i_type[17] = {
    "ADDI",       "ADDIU",      "ANDI",
    "BEQ",        "BGEZ",       "BGEZAL",
    "BGTZ",       "BLEZ",       "BLTZ",
    "BLTZAL",     "BNE",        /*LB,
    LBU,        LH,         LHU,
    LUI,*/        "LW",         "ORI",
    /*SB,         SH,*/         "SW",
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
const int opcode_val_j_type[2] = {
    J,          JAL
};
const char* opcode_str_j_type[2] = {
    "J",          "JAL"
};
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

#endif
