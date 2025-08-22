#include <stdint.h>
#include "uthash.h"
#include "riscv_instr_defines.h"

#define FALSE 0
#define TRUE  1
#define MEM_TEXT_START  0x00001000
#define MEM_TEXT_SIZE   0x1FFFFFFF
#define MEM_DATA_START  0x00000000
#define MEM_DATA_SIZE   0x00000000
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

typedef enum {
    BYTE      = 0,
    HALF_WORD = 1,
    WORD      = 3
} data_size_t;

typedef struct CPU_State_Struct {
  uint32_t      PC;                  /* program counter */
  uint32_t      REGS[RISCV_REGS];    /* register file. */
  int           STORE_OP;
  int           LOAD_OP;
  int           DATA_MEM_ADDR;
  int           DATA_MEM_DATA;
  data_size_t   BYTE_EN;
} CPU_State;

typedef struct {
    int key;             // integer key
    int value;           // value
    UT_hash_handle hh;   // makes this structure hashable
} AssocEntry;

/* Data Structure for Latch */
extern CPU_State PREV_STATE, CURRENT_STATE, NEXT_STATE;

extern int RUN_BIT;     /* Run bit                  */
/*extern int prev_pc;      Previous program counter */
extern int instr_count; /* Instruction count        */
uint32_t   instr_opcode;
extern int my_count;

uint32_t mem_read_32(uint32_t address);
void     mem_write_32(uint32_t address, uint32_t value);

void process_instruction(uint32_t);
void load_instr_opcode(uint32_t);
extern void init();
extern void step(int instruction);
extern int  compare_instruction_address(int address);
extern int  compare_data_memory_access(int address, int byte_en, int write, int write_data);
extern int  compare_architecture_register(int regnum, int value);
