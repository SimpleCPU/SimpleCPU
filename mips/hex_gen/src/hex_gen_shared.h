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
// Define to specify the I-MEM size in Bytes
#define IMEM_SIZE 0x2000
// Define to specify the number of architectural registers
#define MIPS_REGS 32
// Define to hold the maximum 16-bit value possible
#define MAX_16_BIT_IMM 0xFFFF
// Defines the start of DATA section
#define MEM_DATA_START 0x00002000
// Defines the size of DATA section
#define MEM_DATA_SIZE  0x00100000
// Defines the start of TEXT section
#define MEM_TEXT_START 0x00000000
// Defines the size of TEXT section
#define MEM_TEXT_SIZE  0x00001FFF

int PC     [IMEM_SIZE];      /* Program counter arr - index using PC */
int instr  [IMEM_SIZE];      /* Stores hex value of the instruction  */
int ls_addr[IMEM_SIZE];      /* Stores the addresses used by load/store instr */
int br_addr[IMEM_SIZE];      /* Stores the addresses used by branch instrs    */

typedef struct CPU_State_Struct {
  uint32_t PC;          /* Program counter */
  uint32_t REGS[32];    /* Register file   */
  uint32_t HI, LO;      /* Special regs for mult/div */
} CPU_State;

/* Data Structure for Latch */
extern CPU_State CURRENT_STATE;
int instr_gen;          /* Keeps a count of the number of   */
                        /* instructions generated           */
int err_count;          /* Keeps a count of the number of   */
                        /* errors generated, if any         */

#ifdef GEN_USER_TEST
extern void gen_user_test ();
#endif
/* Declare all the globally used functions here */
// Function to initialise the tool
void init_hex_gen ();
// Function to find sufficient space for instruction generation
void make_room ();
// Function to generate given R-type instruction
void gen_r_instr (int, ...);
// Function to generate given I-type instruction
void gen_i_instr (int, ...);
// Function to generate given J-type instruction
void gen_j_instr ();
// Function to randomly generate R, I or J instruction depending on the count
void gen_instr_hex (int, int, int);
// Function to return the current PC value
uint32_t get_curr_PC ();
// Function to return random load/store address
// Note: The address returned is one of the already
// seen address by the test
uint32_t get_rand_ls_addr ();
// Function to return random branch address
// Note: The address returned is one of the 
// already seen address by the test
uint32_t get_rand_br_addr ();

/* Declare all R-type instructions here */
void gen_r_type_ADD     (int, int, int, int, ...);
void gen_r_type_ADDU    (int, int, int, int, ...);
void gen_r_type_AND     (int, int, int, int, ...);
void gen_r_type_DIV     (int, int, int, int, ...);
void gen_r_type_DIVU    (int, int, int, int, ...);
void gen_r_type_JALR    (int, int, int, int, ...);
void gen_r_type_JR      (int, int, int, int, ...);
void gen_r_type_MFHI    (int, int, int, int, ...);
void gen_r_type_MFLO    (int, int, int, int, ...);
void gen_r_type_MTHI    (int, int, int, int, ...);
void gen_r_type_MTLO    (int, int, int, int, ...);
void gen_r_type_MULT    (int, int, int, int, ...);
void gen_r_type_MULTU   (int, int, int, int, ...);
void gen_r_type_NOR     (int, int, int, int, ...);
void gen_r_type_OR      (int, int, int, int, ...);
void gen_r_type_SLL     (int, int, int, int, int, ...);
void gen_r_type_SLLV    (int, int, int, int, int, ...);
void gen_r_type_SLT     (int, int, int, int, ...);
void gen_r_type_SLTU    (int, int, int, int, ...);
void gen_r_type_SRA     (int, int, int, int, int, ...);
void gen_r_type_SRAV    (int, int, int, int, int, ...);
void gen_r_type_SRL     (int, int, int, int, int, ...);
void gen_r_type_SRLV    (int, int, int, int, int, ...);
void gen_r_type_SUB     (int, int, int, int, ...);
void gen_r_type_SUBU    (int, int, int, int, ...);
void gen_r_type_SYSCALL ();
void gen_r_type_XOR     (int, int, int, int, ...);

/* Declare all I-type instructions here */
void gen_i_type_ADDI    (int, int, int, int, ...);
void gen_i_type_ADDIU   (int, int, int, int, ...);
void gen_i_type_ANDI    (int, int, int, int, ...);
void gen_i_type_BEQ     (int, int, int, int, ...);
void gen_i_type_BGTZ    (int, int, int, int, ...);
void gen_i_type_BLEZ    (int, int, int, int, ...);
void gen_i_type_BNE     (int, int, int, int, ...);
void gen_i_type_BLTZ    (int, int, int, int, ...);
void gen_i_type_BGEZ    (int, int, int, int, ...);
void gen_i_type_BLTZAL  (int, int, int, int, ...);
void gen_i_type_BGEZAL  (int, int, int, int, ...);
void gen_i_type_LB      (int, int, int, int, ...);
void gen_i_type_LBU     (int, int, int, int, ...);
void gen_i_type_LH      (int, int, int, int, ...);
void gen_i_type_LHU     (int, int, int, int, ...);
void gen_i_type_LUI     (int, int, int, int, ...);
void gen_i_type_LW      (int, int, int, int, ...);
void gen_i_type_ORI     (int, int, int, int, ...);
void gen_i_type_SB      (int, int, int, int, ...);
void gen_i_type_SH      (int, int, int, int, ...);
void gen_i_type_SW      (int, int, int, int, ...);
void gen_i_type_SLTI    (int, int, int, int, ...);
void gen_i_type_SLTIU   (int, int, int, int, ...);
void gen_i_type_XORI    (int, int, int, int, ...);

#endif
