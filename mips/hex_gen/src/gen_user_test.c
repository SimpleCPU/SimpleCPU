#include "gen_user_test.h"

void gen_user_test () {
    printf ("Generating user test...\n\n");
    gen_r_type_ADD (R4, R2, R1, 0);
    gen_r_type_ADD (R24, R22, R12, 0);
    gen_i_type_ADDI (R24, R22, 0xFFFFF, 0);
}
