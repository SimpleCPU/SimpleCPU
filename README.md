# SimpleCPU(http://simplecpu.github.io/)
An open source CPU design and verification platform for academia 

 * [About](#what-is-SimpleCPU)
 * [Installation](#installation)
 * [Documentation](#documentation)
 * [Contribute](#contribute-to-simplecpu)


<a id="what-is-SimpleCPU"></a>
What is SimpleCPU?
-----------------
SimpleCPU is a CPU design and verification platform with a bunch of design and verification tools / designs under its hood. SimpleCPU is aimed towards students and reserachers, helping them learn and easily carry out CPU simulations in an intuitive way. Being an open source project makes it easier for one to get an indepth understanding of the the underlying concepts by glossing at the source.

SimpleCPU focusses on the fundamentals. Everything has been written from scratch such as adders, logical operations, etc. 

Our future goals include a GUI/CLI tool to help easily build/add-on more blocks to different CPU designs and carry out simulations along with various performance numbers which would help researchers on their projects. 

Brief Overview
--------------
SimpleCPU repository consists of three main parts:
  * CPU RTL and Testbench (written in Verilog/SystemVerilog)
  * Instruction Set Simulator (C-based fast CPU simulation model)
  * Hex Generator (C-based random instruction sequence (RIS) generator)

Here's an example simulation of a single cycle 32-bit MIPS CPU running a random instruction sequence along with an instruction set simulator which helps in checking the RTL state as in when each instruction retires. 
