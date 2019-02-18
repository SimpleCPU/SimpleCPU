/***************************************************************/
/*                                                             */
/* hex_gen.h                                                   */
/* Creates a file with the hexadecimal opcodes                 */
/* of the requested instruction mix                            */
/*                                                             */
/***************************************************************/

#ifndef HEX_GEN_H
#define HEX_GEN_H

#include "hex_gen_shared.h"

/* Declare all the external functions here */
extern int shift_const (int);
extern void load_instr_opcode (uint32_t);
extern void run (int);
extern int check_ls_addr (int, int);
extern void init_memory ();

/* Declare all the internally used functions here */
void update_cpu (int, int);
int  check_brn_addr (int, int);
int  decode_brn_result (int, int, int);
int  check_ls_addr (int, int);
int  check_j_addr (int, int, int);
void print_assembled_r_instr (int, int, int, int);
void print_assembled_i_instr (int, int, int, int);
void print_assembled_s_instr (int, int, int, int);
void print_assembled_j_instr (int, int, int);
void gen_end_seq ();
void print_to_file (FILE*, FILE*);

extern int prev_pc;
FILE* pc_hex_val;
FILE* instr_hex_val;

const int funct_val_r_type[10] = {
    SLL,     SRL,       SRA,
    ADD,     SUB,       AND,
    OR,      XOR,       SLT,
    SLTU
};
const char* funct_str_r_type[10] = {
    "SLL",     "SRL",       "SRA",
    "ADD",     "SUB",       "AND",
    "OR",      "XOR",       "SLT",
    "SLTU"
};
const int opcode_val_i_type[8] = {
    ADDI,       SLTI,       SLTIU,
    ANDI,       ORI,        XORI,
    JALR,       /*LB,         LH,*/
    LW         /*LBU,        LHU*/
};
const char* opcode_str_i_type[8] = {
    "ADDI",       "SLTI",       "SLTIU",
    "ANDI",       "ORI",        "XORI",
    "JALR",      /*"LB",         "LH",*/
    "LW"         /*"LBU",        "LHU"*/
};
const int opcode_val_s_type[1] = {
    /*SB,         SH,*/         SW
};
const char* opcode_str_s_type[1] = {
    /*"SB",         "SH",*/         "SW"
};
const int opcode_val_b_type[6] = {
    BEQ,        BNE,        BLT,
    BLTU,       BGE,        BGEU
};
const char* opcode_str_b_type[6] = {
    "BEQ",        "BNE",        "BLT",
    "BLTU",       "BGE",        "BGEU"
};
const int opcode_val_u_type[2] = {
    LUI,        AUIPC
};
const char* opcode_str_u_type[2] = {
    "LUI",        "AUIPC"
};
const int opcode_val_j_type[1] = {
    JAL
};
const char* opcode_str_j_type[1] = {
    "JAL"
};
/* Currently the RTL only supports */
/* registers in the following format */
const char* register_str[] = {	
    "X0",       "X1",       "X2",  
    "X3",       "X4",       "X5",  
    "X6",       "X7",       "X8",  
    "X9",       "X10",      "X11",  
    "X12",      "X13",      "X14",  
    "X15",      "X16",      "X17",  
    "X18",      "X19",      "X20",  
    "X21",      "X22",      "X23", 
    "X24",      "X25",      "X26",  
    "X27",      "X28",      "X29", 
    "X30",      "X31",             
};

#endif
