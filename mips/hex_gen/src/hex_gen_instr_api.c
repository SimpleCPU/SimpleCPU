/***************************************************************/
/*                                                             */
/* hex_gen_instr_api.c                                         */
/* Defines all the functions used to                           */
/* generate a directed MIPS instruction                        */
/*                                                             */
/***************************************************************/

#include "hex_gen_shared.h"

void gen_r_type_ADD (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = ADD;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);

}
