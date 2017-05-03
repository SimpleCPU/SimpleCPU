#!bin/perl
use strict;
use warnings;

my $opcode_file = shift;
open (FILE_H, $opcode_file) or die "Unable to open $opcode_file for reading";

while (my $opcode = <FILE_H>) {
    chomp ($opcode);
    # R-type generation function
#    print ("
#void gen_r_type_$opcode (int RD, int RS, int RT, int set_rval, ...) {
#    int     funct;
#    int     shamt;
#    int     vopt;
#    int     rs_val;
#    int     rt_val;
#    va_list valist;
#
#    funct   = $opcode;
#    shamt   = 0;
#    vopt    = 5;
#    if (set_rval) {
#        va_start (valist, set_rval);
#        rs_val  = va_arg (valist, int);
#        rt_val  = va_arg (valist, int);
#        va_end (valist);
#        //gen_i_type_ORI (RS, R0, rs_val, 0);
#        //gen_i_type_ORI (RT, R0, rt_val, 0);
#    }
#    make_room ();
#    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
#}\n");
    # I-type generation function
    print ("
void gen_i_type_$opcode (int RT, int RS, int imm, int set_rval, ...) {
    int     opcode;
    int     vopt;
    int     rs_val;
    va_list valist;

    opcode      = $opcode;
    vopt        = 4;
    if (imm > MAX_16_BIT_IMM) {
        printf (\"ERROR: Expecting a 16-bit IMM value\\n\");
        printf (\"Given IMM value (0x%08x) greater than maximum allowed value (0x%08x)\\n\\n\", imm, MAX_16_BIT_IMM);
        err_count++;
        return;
    }
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val, 0);
    }
    make_room ();
    gen_i_instr (vopt, opcode, RT, RS, imm);
}\n");
}
