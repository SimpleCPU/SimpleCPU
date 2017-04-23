#!bin/perl
use strict;
use warnings;

my $opcode_file = shift;
open (FILE_H, $opcode_file) or die "Unable to open $opcode_file for reading";

while (my $opcode = <FILE_H>) {
    chomp ($opcode);
    print ("
void gen_r_type_$opcode (int RD, int RS, int RT) {
    int     funct;
    int     shamt;
    int     vopt;

    funct   = $opcode;
    shamt   = 0;
    vopt    = 5;
    make_room ();
    gen_r_instr (vopt, funct, RD, RS, RT, shamt);
}\n");
}
