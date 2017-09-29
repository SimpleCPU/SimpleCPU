#include <stdint.h>
#include "mips_instr_defines.h"

#define FALSE 0
#define TRUE  1
#define MEM_DATA_START  0x00002000
#define MEM_DATA_SIZE   0x00100000
#define MEM_TEXT_START  0x00000000
#define MEM_TEXT_SIZE   0x00001FFF
#define MEM_STACK_START 0x7ff00000
#define MEM_STACK_SIZE  0x00100000
#define MEM_KDATA_START 0x90000000
#define MEM_KDATA_SIZE  0x00100000
#define MEM_KTEXT_START 0x80000000
#define MEM_KTEXT_SIZE  0x00100000
#define R_TYPE          0x0
#define J_TYPE          0x1
#define I_TYPE          0x2
// Exception/Interrupts causes
// External interrupt
#define INT             0x0
// Invalid Opcode
#define IOPC            0x1
// Overflow
#define OVF             0x2
// SYSCALL
#define SYS             0x3

#define MIPS_REGS 32

typedef struct CPU_State_Struct {

  uint32_t PC;                  /* program counter */
  uint32_t REGS[MIPS_REGS];     /* register file. */
  uint32_t HI, LO;              /* special regs for mult/div. */
  uint32_t EPC;                 /* Exception link register to hold current PC */
  uint32_t ESR;                 /* Exception syndrome register -- Cause of EXC */
  uint32_t ECR;                 /* Exception conntrol register -- Status reg */
} CPU_State;

/* Data Structure for Latch */

extern CPU_State CURRENT_STATE, NEXT_STATE;

extern int RUN_BIT; 	/* Run bit                  */
extern int prev_pc;     /* Previous program counter */
extern int rt_as_src;   /* Use RT reg as source     */
extern int instr_count;
uint32_t   instr_opcode;
int        wr_link_reg; /* Instr updates R31 reg    */

uint32_t mem_read_32(uint32_t address);
void     mem_write_32(uint32_t address, uint32_t value);
void     mdump (int, int);

void process_instruction();
extern void init();
extern void run(int num_cycles);
extern int compare_r (int pc, int instr, int rd, int rs, int rt, int rd_val, int rs_val, int rt_val);
extern int compare_i (int pc, int instr, int rs, int rt, int rs_val, int rt_val);
extern int compare_j (int pc, int instr, int rt, int rt_val);
