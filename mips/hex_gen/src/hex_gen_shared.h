/***************************************************************/
/*                                                             */
/* hex_gen_shared.h                                            */
/* Declares globally used variable/functions                   */
/*                                                             */
/*                                                             */
/***************************************************************/

#ifndef HEX_GEN_SHARED_H
#define HEX_GEN_SHARED_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "mips_instr_defines.h"
#include "mips_reg_defines.h"

// Define to specify the number of instructions in the end code
#define NUM_END_SEQ_INSTR 2
// Define to specify the I-MEM size in Bytes (default to 4K)
#define IMEM_SIZE 4096

int PC[4096];           /* Program counter arr - index using PC */
int instr[4096];        /* Stores hex value of the instruction  */

typedef struct CPU_State_Struct {
  uint32_t PC;		      /* Program counter */
  uint32_t REGS[32];    /* Register file. */
  uint32_t HI, LO;      /* Special regs for mult/div. */
} CPU_State;

/* Data Structure for Latch */
extern CPU_State CURRENT_STATE;
int instr_gen;          /* Keeps a count of the number of   */
                        /* instructions generated           */

#ifdef GEN_USER_TEST
extern void gen_user_test ();
#endif
/* Declare all the globally used functions here */
void init_hex_gen ();
void make_room ();
void gen_r_instr (int, ...);
void gen_i_instr ();
void gen_j_instr ();

/* Declare all R-type instructions here */
void gen_r_type_ADD     (int, int, int);
void gen_r_type_ADDU    (int, int, int);
void gen_r_type_AND     (int, int, int);
void gen_r_type_DIV     (int, int, int);
void gen_r_type_DIVU    (int, int, int);
void gen_r_type_JALR    (int, int, int);
void gen_r_type_JR      (int, int, int);
void gen_r_type_MFHI    (int, int, int);
void gen_r_type_MFLO    (int, int, int);
void gen_r_type_MTHI    (int, int, int);
void gen_r_type_MTLO    (int, int, int);
void gen_r_type_MULT    (int, int, int);
void gen_r_type_MULTU   (int, int, int);
void gen_r_type_NOR     (int, int, int);
void gen_r_type_OR      (int, int, int);
void gen_r_type_SLL     (int, int, int);
void gen_r_type_SLLV    (int, int, int);
void gen_r_type_SLT     (int, int, int);
void gen_r_type_SLTU    (int, int, int);
void gen_r_type_SRA     (int, int, int);
void gen_r_type_SRAV    (int, int, int);
void gen_r_type_SRL     (int, int, int);
void gen_r_type_SRLV    (int, int, int);
void gen_r_type_SUB     (int, int, int);
void gen_r_type_SUBU    (int, int, int);
void gen_r_type_SYSCALL (int, int, int);
void gen_r_type_XOR     (int, int, int);

#endif
