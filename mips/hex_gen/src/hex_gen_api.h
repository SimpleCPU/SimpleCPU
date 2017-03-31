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
// Function to get a random PC address
int get_rand_pc ();
// Function to generate a specific R-type instruction
void gen_r_instr (char*);
// Function to generate a specific I-type instruction
void gen_i_instr (char*, int);
// Function to generate a specific J-type instruction
void gen_j_instr (char*, int);
