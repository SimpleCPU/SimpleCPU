/***************************************************************/
/*                                                             */
/* hex_gen_api.c                                               */
/* Desclares a set of functions which can be                   */
/* used to create an mips assembly test                        */
/*                                                             */
/***************************************************************/

#include "hex_gen.h"
#include "hex_gen_api.h"

void gen_dir_j (char* op_str, int addr) {
//    int opcode;
//    int target;
//    target = (addr & 0xFFFFFFC)>>2;
//    opcode = (J << 26) + target;
//    return opcode;
}

void gen_dir_r_instr (char* instr_mnemonic) {
    //int     opcode, shamt, funct;
    //int     rs, rt, rd;
    //int     hex_instr;
    //int     funct_idx;
}

char* get_opcode (char* instr_mnemonic) {
    // Take max size (len of SYSCALL opcode)
    char* opcode = (char*) malloc (sizeof(char) * 7);
    int len = strlen(instr_mnemonic);
    int i;
    // Look for first space to find the opcode
    for (i = 0; i < len; i++) {
        if (instr_mnemonic[i] != ' ') {
            opcode[0] = instr_mnemonic[i];
        }
        else break;
    }
    return opcode;
}
