/***************************************************************/
/*                                                             */
/* hex_gen_api.h                                               */
/* Declares a set of functions which can be                    */
/* used to create an mips assembly test                        */
/*                                                             */
/***************************************************************/

#ifndef HEX_GEN_API_H
#define HEX_GEN_API_H

#include "hex_gen_shared.h"

// Declare all the functions here
// Function to get random Load/Store addr
int get_rand_ls_addr ();
// Function to get an already used Load/Store addr
int get_ls_addr ();
// Function to get a random PC address
int get_rand_pc ();

#endif
