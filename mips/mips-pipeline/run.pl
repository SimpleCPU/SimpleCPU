#!/usr/bin/perl -w
use strict;
use warnings;
use Getopt::Long qw(GetOptions);

my $sim_mode  = 0;
my $test_name = "alu_ops_stress";
my $regress_mode = 0;
my $help;

GetOptions (
    'help'          =>  \$help,
    'sim_only=i'    =>  \$sim_mode,
    'test=s'        =>  \$test_name,
    'regress=i'     =>  \$regress_mode
);

my $usage =<<USAGE;

This script is used to compile, build and run RTL simulations
along with the co-simulated model runs. The script compiles
the C-model and copies the generated so file to the lib/ dir.
If this goes fine, then the RTL is compiled and simulation
starts. 
You can pass the following options to the script - 
  -help                => Prints this message
  -sim_mode = <value>  => To run in simulation mode only i.e. RTL won't be compiled
  -test = <name>       => Pass the test name to both model and RTL
  -regress = <value>   => Use this flag to tell the script we are in regress mode

USAGE

if ($help) {
    print $usage;
    exit;
}
# We only need to copy the hex files when
# we are not in regress mode. As in regress
# mode the script is provided with the 
# complete path of the hex files.
if (!$regress_mode) {
    my $dir_name = $test_name;
    if ($dir_name =~ /basic/) {
      $dir_name =~ s/_basic//;
    }
    elsif ($dir_name =~ /stress/) {
      $dir_name =~ s/_stress//;
    }
    # Get the test from hex-gen
    print ("cp ../hex_gen/tests/rand_$dir_name/hex/$test_name* ");
    system ("cp ../hex_gen/tests/rand_$dir_name/hex/$test_name* .");
}
# Compile the ISS first
chdir '../iss';
print ("make iss\n");
if (system ("make iss")) {
    print "Make failed..! Exiting!\n";
    exit;
}
else {
    # Copy the iss.so file to the main directory
    if (!(-d "../mips-pipeline/lib")) {
      system ("mkdir ../mips-pipeline/lib");
    }
    print ("cp iss.so ../mips-pipeline/lib/\n");
    system ("cp iss.so ../mips-pipeline/lib/");
    # Compile the RTL only when sim_mode = 0
    chdir "../mips-pipeline";
    if ($sim_mode eq 0) {
        print ("rm -rf vsim.wlf wlf* transcript work/\n");
        system ("rm -rf vsim.wlf wlf* transcript work/");
        print ("vlib work\n");
        system ("vlib work");
        print ("vlog testbench/* verilog/*\n");
        system ("vlog testbench/* verilog/*");
    }
    # Run the simulation
    print ("vsim -c top_tb -sv_lib lib/iss -do \"run -all; exit\" +test=$test_name  | tee sim.log");
    system ("vsim -c top_tb -sv_lib lib/iss -do \"run -all; exit\" +test=$test_name | tee sim.log");
    system ("rm -rf vsim.wlf wlf* transcript");
    # Remove the test from the current dir
    # if we are not in the regress mode
    if (!$regress_mode) {
        system ("rm -rf $test_name.hex $test_name\_pc.hex");
    }
}
