/***************************************************************/
/*                                                             */
/* hex_gen_api.c                                               */
/* Defines a set of utility functions which can be             */
/* used to create a directed mips assembly test                */
/*                                                             */
/***************************************************************/

#include "hex_gen_api.h"

int find_reg (int reg_val) {
  int i;
  int found = 0;
  
  for (i = 0; i < MIPS_REG; i++) {
    if (CURRENT_STATE.REGS[i] == reg_val) {
      found = 1;
      return found;
    }
  }
  return found;
}
