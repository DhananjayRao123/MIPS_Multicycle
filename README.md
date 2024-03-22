### MIPS_Multicycle

This is an implementation of a simple MIPS multicycle 32 bit processor. It can currenty execute R type and Conditional branch instructions, but can easily be modified to fit in immediate, data accesss and jump instructions by modifying the control unit to include more states for the same.

![Block Diagram](https://github.com/DhananjayRao123/MIPS_Multicycle/blob/main/Screenshot%202024-03-21%20224550.png)

Here is a brief description of all the modules:
1) multi_cycle.v - module multi_cycle
Contains instantiation of all sub-modules of the processor. This is the top module. This module contains all the multiplexers except the one at Address input. It also contains the OR and AND gates. It contains the ‘snex’, the sign extender and the ‘Shift’ which left shifts by 2 bits. 

2) MUX.v - Contains modules MUX_2to1_32, MUX_2to1_5 and MUX_4to1_32 which are the multiplexers used in the datapath.

3) control.v - Contains the control unit of the multicycle processor under the module name control. It is built to handle AND R-Type and BEQ instructions.

4) ALU_top.v - Contains the instantiations of the ALU_MIPS and ALU_control modules. It also contains the ALUOut register as output.

5) ALU_MIPS.v - Contains the functional unit of the ALU.
  
6) ALU_control.v - Contains the ALU control unit for the processor.

7) mem.v - Contains the combined instruction and data memory, along with the PC register. Its outputs are the IR and MDR registers.

8) Register_file.v - Contains all the 16 registers, along with the A and B registers as outputs.

![State Diagram](https://github.com/DhananjayRao123/MIPS_Multicycle/blob/main/Screenshot%202024-03-23%20002351.png)
