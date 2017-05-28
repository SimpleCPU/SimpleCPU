/***************************************************************/
/*                                                             */
/* hex_gen_api.c                                               */
/* Defines a set of utility functions which can be             */
/* used to create a directed mips assembly test                */
/*                                                             */
/***************************************************************/

#include "hex_gen_api.h"

// The following function returns TRUE if the required
// value exists in any of the Architectural registers
int find_reg (int reg_val) {
  int i;
  int found = 0;
  
  for (i = 0; i < MIPS_REGS; i++) {
    if (CURRENT_STATE.REGS[i] == reg_val) {
      found = 1;
      return found;
    }
  }
  return found;
}

// The following function returns the reg containing the 
// required value. If the value isn't present in any of 
// the architectural registers, it issues a warning and
// returns R0
int get_reg (int reg_val) {
  int i;
  int reg = 0;
  
  for (i = 0; i < MIPS_REGS; i++) {
    if (CURRENT_STATE.REGS[i] == reg_val) {
      reg = i;
      return reg;
    }
  }
  return reg;
}

// The following function returns the current program
// counter value. 
uint32_t get_curr_PC () {
    return CURRENT_STATE.PC;
}

// Function to return random load/store address
// Note: The address returned is one of the already
// used address used by the test
uint32_t get_rand_ls_addr () {
    int rand_idx;
    int i;
    for (i = 0; i < IMEM_SIZE; i++) {
        rand_idx = rand () % instr_gen;
        if (ls_addr[rand_idx] != 0) {
            return (uint32_t) ls_addr[rand_idx];
        }
    }
    printf ("Failed to find a valid random Load/Store address!\n");
    printf ("Returning the first valid entry.\n");
    for (i = 0; i < IMEM_SIZE; i++) {
        if (ls_addr[i] != 0) {
            return (uint32_t) ls_addr[i];
        }
    }
    printf ("No valid entry exists! Returning 0\n");
    return 0;
}

// Function to return random branch address
// Note: The address returned is one of the 
// already seen address by the test
uint32_t get_rand_br_addr () {
    int rand_idx;
    int i;
    for (i = 0; i < IMEM_SIZE; i++) {
        rand_idx = rand () % instr_gen;
        if (br_addr[rand_idx] != 0) {
            return (uint32_t) br_addr[rand_idx];
        }
    }
    printf ("Failed to find a valid random branch address!\n");
    printf ("Returning the first valid entry.\n");
    for (i = 0; i < IMEM_SIZE; i++) {
        if (br_addr[i] != 0) {
            return (uint32_t) br_addr[i];
        }
    }
    printf ("No valid entry exists! Returning 0\n");
    return 0;
}
