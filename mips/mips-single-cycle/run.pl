#!/usr/bin/perl -w
use strict;
use warnings;

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
    # Compile the RTL
    chdir "../mips-single-cycle";
    print ("rm -rf vsim.wlf wlf* transcript work/\n");
    system ("rm -rf vsim.wlf wlf* transcript work/");
    print ("vlib work\n");
    system ("vlib work");
    print ("vlog testbench/* verilog/*\n");
    system ("vlog testbench/* verilog/*");
    # Run the simulation
    print ("vsim -c top_tb -sv_lib iss -do \"onElabError resume;  run -all; exit\" | tee sim.log");
    system ("vsim -c top_tb -sv_lib iss -do \"run -all; exit\" | tee sim.log");
    print ("rm -rf vsim.wlf wlf* transcript \n");
    system ("rm -rf vsim.wlf wlf* transcript ");
}
