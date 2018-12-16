#include <stdint.h>
#include "riscv_instr_defines.h"

#define FALSE 0
#define TRUE  1
#define MEM_TEXT_START  0x00002000
#define MEM_TEXT_SIZE   0x00001FFF
#define MEM_DATA_START  0x00000000
#define MEM_DATA_SIZE   0x00001FFF
#define MEM_STACK_START 0x7ff00000
#define MEM_STACK_SIZE  0x00100000
#define MEM_KDATA_START 0x90000000
#define MEM_KDATA_SIZE  0x00100000
#define MEM_KTEXT_START 0x80000000
#define MEM_KTEXT_SIZE  0x00100000
#define R_TYPE          0x0
#define I_TYPE          0x1
#define S_TYPE          0x2
#define B_TYPE          0x3
#define U_TYPE          0x4
#define J_TYPE          0x5

#define RISCV_REGS 32

typedef struct CPU_State_Struct {
  uint32_t PC;                  /* program counter */
  uint32_t REGS[RISCV_REGS];    /* register file. */
} CPU_State;

/* Data Structure for Latch */
extern CPU_State CURRENT_STATE, NEXT_STATE;

extern int RUN_BIT;     /* Run bit                  */
extern int prev_pc;     /* Previous program counter */
extern int instr_count; /* Instruction count        */
uint32_t   instr_opcode;
extern int my_count;

uint32_t mem_read_32(uint32_t address);
void     mem_write_32(uint32_t address, uint32_t value);

void process_instruction();
extern void init();
extern void run(int num_cycles);
