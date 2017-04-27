#!bin/perl
use strict;
use warnings;

my $opcode_file = shift;
open (FILE_H, $opcode_file) or die "Unable to open $opcode_file for reading";

while (my $opcode = <FILE_H>) {
    chomp ($opcode);
    print ("
void gen_r_type_$opcode (int RD, int RS, int RT, int set_rval, ...) {
    int     funct;
    int     shamt;
    int     vopt;
    int     rs_val;
    int     rt_val;
    va_list valist;

    funct   = $opcode;
    shamt   = 0;
    vopt    = 5;
    if (set_rval) {
        va_start (valist, set_rval);
        rs_val  = va_arg (valist, int);
        rt_val  = va_arg (valist, int);
        va_end (valist);
        //gen_i_type_ORI (RS, R0, rs_val);
        //gen_i_type_ORI (RT, R0, rt_val);
    }
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}\n");
}
