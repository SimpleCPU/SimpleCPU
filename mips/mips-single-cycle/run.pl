#!/usr/bin/perl -w
use strict;
use warnings;
use Getopt::Long qw(GetOptions);

my $sim_mode  = 0;
my $test_name = "alu_ops_stress";

GetOptions (
    'sim_only=i'    =>  \$sim_mode,
    'test=s'        =>  \$test_name
    );

my $dir_name = $test_name;
if ($dir_name =~ /basic/) {
  $dir_name =~ s/_basic//;
}
elsif ($dir_name =~ /stress/) {
  $dir_name =~ s/_stress//;
}
# get the test from hex-gen
print ("cp ../hex_gen/tests/rand_$dir_name/hex/$test_name* ");
system ("cp ../hex_gen/tests/rand_$dir_name/hex/$test_name* .");

# compile the ISS first
chdir '../iss';
print ("make iss\n");
if (system ("make iss")) {
    print "Make failed..! Exiting!\n";
    exit;
}
else {
    # Copy the sim.so file to the main directory
    print ("cp iss.so ../mips-single-cycle/\n");
    system ("cp iss.so ../mips-single-cycle/");
    # Compile the RTL only when sim_mode = 0
    chdir "../mips-single-cycle";
    if ($sim_mode eq 0) {
        print ("rm -rf vsim.wlf wlf* transcript work/\n");
        system ("rm -rf vsim.wlf wlf* transcript work/");
        print ("vlib work\n");
        system ("vlib work");
        print ("vlog testbench/* verilog/*\n");
        system ("vlog testbench/* verilog/*");
    }
    # Run the simulation
    print ("vsim -c top_tb -sv_lib iss -do \"run -all; exit\" +test=$test_name  | tee sim.log");
    system ("vsim -c top_tb -sv_lib iss -do \"run -all; exit\" +test=$test_name | tee sim.log");
    system ("rm -rf vsim.wlf wlf* transcript $test_name.hex $test_name\_pc.hex");
}
