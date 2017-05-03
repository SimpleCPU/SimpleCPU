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
