#include "gen_user_test.h"

void gen_user_test () {
    printf ("Generating user test...\n\n");
    gen_r_type_ADD (R4, R2, R1, 1, 16, 16);
    gen_r_type_ADD (R24, R22, R12, 1, 24, 20);
    gen_i_type_ADDI (R24, R22, 0xFFFF, 1, 0);
}
