#include "gen_user_test.h"

void gen_user_test () {
    uint32_t pc;
    uint32_t ls_addr;

    gen_r_type_ADD (R4, R2, R1, 1, 16, 16);
    gen_r_type_ADD (R24, R22, R12, 1, 24, 20);
    gen_i_type_ADDI (R24, R22, 0xFFFF, 1, 0);

    pc = get_curr_PC ();
    gen_i_type_ADDI (R1, R2, 4, 1, pc & 0xFFFF);
    gen_i_type_ADDIU (R1, R2, 4, 1, (pc>>16) & 0xFFFF);
    // Demonstrate the usage of get_ls_addr here
}
