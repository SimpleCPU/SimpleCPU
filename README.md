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

SimpleCPU focusses on the fundamentals. Everything has been written from scratch such as ALUs, multipliers, decoders etc. 

Our future goals include a GUI/CLI tool to help easily build/add-on more blocks to different CPU designs and carry out simulations along with various performance numbers which would help researchers on their projects. 

Brief Overview
--------------
SimpleCPU repository consists of three main parts:
  * CPU RTL and Testbench (written in Verilog/SystemVerilog)
  * Instruction Set Simulator (C-based fast CPU simulation model)
  * Hex Generator (C-based random instruction sequence (RIS) generator)

The CPU implementation is carried out in Verilog which is widely used across academia and industry as well. This CPU RTL is the design under test (DUT) which is verified by carrying out simulations under different randon instruction sequence loads. But as the design gets vast and complicated there would be a need to add certain directed tests as well. SimpleCPU focuses on maintaining an intuitive way towards both RTL design and the verification aspects. For easy understanding of the Instruction Set Architecture, C-models were created. These help in understanding the behaviour of the different instructions and also help in verifying the RTL through SimpleCPU's co-simulation environment. The Instruction Set Simulator is therefore an important tool for carrying out RTL design and simulations. 
Since CPU verification requires that the CPU should work under all possible combinations of instructions available in the instruction set architecture, it becomes a daunting task to cover all these instructions. To avoid this we have written the Hex Generator tool from scracth and using basic C such that students find it more appealing. The tool generates random instruction sequences and dumps the hex value for every generated instruction - thus the name Hex Generator. 
Here's an example simulation of a single cycle 32-bit MIPS CPU running a random instruction sequence along with an instruction set simulator which helps in checking the RTL state as in when each instruction retires. 

<a id="Installation"></a>
Installation
------------

## Linux

