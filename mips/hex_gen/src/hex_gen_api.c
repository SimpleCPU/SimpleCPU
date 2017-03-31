/***************************************************************/
/*                                                             */
/* hex_gen_api.c                                               */
/* Desclares a set of functions which can be                   */
/* used to create an mips assembly test                        */
/*                                                             */
/***************************************************************/

#include "hex_gen_api.h"

void gen_dir_j (char* op_str, int addr) {
    int opcode;
    int target;
    target = (address & 0xFFFFFFC)>>2;
    opcode = (J << 26) + target;
    return opcode;
}

void gen_dir_r_instr (char* instr_mnemonic) {
    
}
