/***************************************************************/
/*                                                             */
/* hex_gen_api.h                                               */
/* Desclares a set of functions which can be                   */
/* used to create an mips assembly test                        */
/*                                                             */
/***************************************************************/

#include "hex_gen.h"

// Declare all the functions here
// Function to get random Load/Store addr
int get_rand_ls_addr ();
// Function to get an already used Load/Store addr
int get_ls_addr ();
int get_rand_pc ();
void gen_r_instr (char*);
void gen_i_instr (char*, int);
void gen_j_instr (char*, int);
