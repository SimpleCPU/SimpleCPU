# [SimpleCPU]( https://simplecpu.github.io/)
An open source CPU design and verification platform for academia 

 * [About](#what-is-SimpleCPU)
 * [Installation](#installation)
 * [Documentation](#documentation)
 * [Contribute](#Contribute)


<a id="what-is-SimpleCPU"></a>
What is SimpleCPU?
-----------------
SimpleCPU is a CPU design and verification platform with a bunch of design and verification tools / designs under its hood. SimpleCPU is aimed towards students and researchers, helping them learn and easily carry out CPU simulations in an intuitive way. Being an open source project makes it easier for one to get an indepth understanding of the the underlying concepts by glossing at the source.

SimpleCPU focuses on the fundamentals. Everything has been written from scratch such as ALUs, multipliers, decoders etc. 

Our goal is to enable system-designers and researchers to rapidly evaluate new ideas in the field of processor design, memory hierarchy, cache design and other aspects involved in computer architecture research. We want to enable designers to quickly add the new module to  the existing RTL and the models and test the new solution effectively. Along with this, SimpleCPU organisation is also in contact with many of the universities to adopt SimpleCPU as part of the labs for Computer architecture courses. This would give students a great insight on the entire design and verification flow for system-on-chips.  

Brief Overview
--------------
SimpleCPU repository consists of three main parts:
  * CPU RTL and Testbench (written in Verilog/SystemVerilog)
  * Instruction Set Simulator (C-based fast CPU simulation model)
  * Hex Generator (C-based random instruction sequence (RIS) generator)

The CPU implementation is carried out in Verilog which is widely used across academia and industry as well. This CPU RTL is the design under test (DUT) which is verified by carrying out simulations under different random instruction sequence loads. But as the design gets vast and complicated there would be a need to add certain directed tests as well. SimpleCPU focuses on maintaining an intuitive way towards both RTL design and the verification aspects. For easy understanding of the Instruction Set Architecture, C-models were created. These help in understanding the behaviour of the different instructions and also help in verifying the RTL through SimpleCPU's co-simulation environment. The Instruction Set Simulator is therefore an important tool for carrying out RTL design and simulations. 
Since CPU verification requires that the CPU should work under all possible combinations of instructions available in the instruction set architecture, it becomes a daunting task to cover all these instructions. To avoid this we have written the Hex Generator tool from scratch and using basic C such that students find it more appealing. The tool generates random instruction sequences and dumps the hex value for every generated instruction - thus the name Hex Generator. 

Here's an example simulation of a single cycle 32-bit MIPS CPU running a random instruction sequence along with an instruction set simulator which helps in checking the RTL state as in when each instruction retires. 
```sh
perl run.pl 
make iss
gcc -fPIC -W -shared -g -m32 -O2 main.c sim.c -o iss.so
cp iss.so ../../
rm -rf vsim.wlf wlf* transcript work/
vlib work
vlog testbench/* verilog/*
Model Technology ModelSim ALTERA vlog 10.1e Compiler 2013.06 Jun 12 2013
-- Compiling module top_tb
-- Compiling module adder
-- Compiling module alu
-- Compiling module carry_lookahead_adder
-- Compiling module carry_lookahead_gen
-- Compiling module comparator
-- Compiling module control
-- Compiling module data_mem
-- Compiling module decode
-- Compiling module instr_mem
-- Compiling module issue
-- Compiling module logical
-- Compiling module pc_reg
-- Compiling module reduced_full_adder
-- Compiling module regfile
-- Compiling module shifter
-- Compiling module top

Top level modules:
	top_tb
	issue
vsim -c top_tb -sv_lib iss -do "onElabError resume;  run -all; exit" | tee sim.log

Reading /home/rahul/altera/14.0/modelsim_ase/tcl/vsim/pref.tcl # 10.1e

 vsim -do {onElabError resume;  run -all; exit} -c -sv_lib iss top_tb 
 Loading sv_std.std
 Loading work.top_tb
 Loading work.top
 Loading work.pc_reg
 Loading work.adder
 Loading work.carry_lookahead_adder
 Loading work.reduced_full_adder
 Loading work.carry_lookahead_gen
 Loading work.instr_mem
 Loading work.decode
 Loading work.regfile
 Loading work.alu
 Loading work.shifter
 Loading work.logical
 Loading work.comparator
 Loading work.data_mem
 Loading work.control
 Loading ./iss.so
 onElabError resume 
 resume
   run -all 
 ** Warning: (vsim-PLI-3408) Too few data words read on line 13 of file "instr_hex". Expected 1000, found 12.    : testbench/init_imem.sv(7)
    Time: 0 ps  Iteration: 0  Instance: /top_tb
 MIPS Simulator
 
 Loading instr_hex
 Read 12 words from program into memory.
 
 Init done
 CPU initialised
 
 [RTL]  	PC:00000000	Instr:ae695102	R19:00000000	R9:00000000
 [MODEL]	PC:00000000	Instr:ae695102	R19:00000000	R9:00000000
 
 [RTL]  	PC:00000004	Instr:ad2c282a	R9:00000000	R12:00000000
 [MODEL]	PC:00000004	Instr:ad2c282a	R9:00000000	R12:00000000
 
 [RTL]  	PC:00000008	Instr:00dc10e5	R2:00000000	R6:00000000	R28:00000000
 [MODEL]	PC:00000008	Instr:00dc10e5	R2:00000000	R6:00000000	R28:00000000
 
 [RTL]  	PC:0000000c	Instr:01076ee3	R13:00000000	R8:00000000	R7:00000000
 [MODEL]	PC:0000000c	Instr:01076ee3	R13:00000000	R8:00000000	R7:00000000
 
 [RTL]  	PC:00000010	Instr:0073fb80	R31:00000000	R19:00000000	R19:00000000
 [MODEL]	PC:00000010	Instr:0073fb80	R31:00000000	R19:00000000	R19:00000000
 
 [RTL]  	PC:00000014	Instr:3246a1a8	R18:00000000	R6:00000000
 [MODEL]	PC:00000014	Instr:3246a1a8	R18:00000000	R6:00000000
 
 [RTL]  	PC:00000018	Instr:38bd1535	R5:00000000	R29:00001535
 [MODEL]	PC:00000018	Instr:38bd1535	R5:00000000	R29:00001535
 
 [RTL]  	PC:0000001c	Instr:028b9780	R18:00000000	R11:00000000	R11:00000000
 [MODEL]	PC:0000001c	Instr:028b9780	R18:00000000	R11:00000000	R11:00000000
 
 [RTL]  	PC:00000020	Instr:ae9b2012	R20:00000000	R27:00000000
 [MODEL]	PC:00000020	Instr:ae9b2012	R20:00000000	R27:00000000
 
 [RTL]  	PC:00000024	Instr:03bc3862	R7:00001535	R29:00001535	R28:00000000
 [MODEL]	PC:00000024	Instr:03bc3862	R7:00001535	R29:00001535	R28:00000000
 
 [RTL]  	PC:00000028	Instr:2402000a	R0:00000000	R2:0000000a
 [MODEL]	PC:00000028	Instr:2402000a	R0:00000000	R2:0000000a
 
 [RTL]  	PC:0000002c	Instr:0000000c	R0:00000000	R0:00000000	R0:00000000
 [MODEL]	PC:0000002c	Instr:0000000c	R0:00000000	R0:00000000	R0:00000000
 
 End of simulation reached
 
 ** Note: $finish    : testbench/top_tb.sv(83)
    Time: 240 ps  Iteration: 1  Instance: /top_tb
```

The entire simulation can be carried out by simply running the "run.pl" perl script. The script compiles the model version and dumps the .so file used by the simulator for C-DPI calls. If there aren't any errors during make, the HDL code is then compiled and simulated. From the above simulation log it is quite evident that both model and RTL are simulating the same set of instructions and as the instruction retires the values are compared to remove any differences between the two implementations. The simulation is finished once the testbench detects the "syscall" instruction with register R2 containing the value 10.

<a id="Installation"></a>
Installation
------------

## Linux

Download the Altera modelsim version (for linux) from their webiste:

https://www.altera.com/downloads/software/modelsim-starter/121.html

(Note: You need to be enrolled in a university to download this edition)

You can also download a reduced version of modelsim:
```
wget https://github.com/SimpleCPU/SimpleCPU/releases/download/v0.0.1/modelsim_reduced.tgz
```
Untar the tarball and set the path in the env variable:
```sh
tar -xvf modelsim_reduced.tgz
export PATH=$PATH:<Complete path to modelsim>/modelsim_reduced/linux
```

Note: The free version of modelsim supports 32-bit only. To install the dependent 32-bit libraries on a 64-bit linux machine:
```sh
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install libc6-dev-i386
sudo apt-get install gcc-multilib g++-multilib \
lib32z1 lib32stdc++6 lib32gcc1 \
expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 \
libcanberra0:i386 libpng12-0:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 \
libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 \
libxt6:i386 libxtst6:i386
```

Get the latest perl module:
```sh
sudo apt-get install perl
```

Run the simulation (for single cycle MIPS CPU) - 
```
perl run.pl
```
The entire simulation is carried out by the "run.pl" perl script. The script first compiles the model version and dumps the .so file used by the simulator for C-DPI calls. If there aren't any errors during make, the HDL code is then compiled and simulated.

The SimpleCPU project has been tested on Linux (Ubuntu 14.04) only. Though it shouldn't be hard to port the scripts for windows as well. We are working towards testing the project on windows environment as well. 

<a id="Documentation"></a>
Documentation
-----

The documentation for every tool is present in the README file. The following files/directories may be of interest:
  - verilog/README
  - testbench/iss/README
  - hex_gen/README

<a id="Contribute"></a>
Contribute
-----
See [Contributing](CONTRIBUTING.md)

Future Work and Ideas
-----
See [Future Work](https://github.com/SimpleCPU/SimpleCPU/wiki/Future-Work-and-ideas)
