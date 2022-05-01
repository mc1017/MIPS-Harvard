# IAC-Coursework
IAC Coursework

Start Date: 13/11/2021 End Date: 17/12/2021

The overall goals are to develop a working synthesisable MIPS-compatible CPU. This CPU will interface with the world using a memory-mapped bus, which gives it access to memory and other peripherals.

The goal of this coursework is not to get a single circuit working in a single piece of hardware. Instead it is to develop a piece of IP which could be sold and distributed to many clients, allowing them to integrate you CPU into any number of products. As a consequence the emphasis is on producing a production quality CPU with a robust testing process - you should deliver something that you expect to work on any FPGA or ASIC, rather than something that just works on a single device.

The emphasis on creating a "real" CPU makes this a more complex task than implementing a toy CPU with lots of extra debug hooks. In particular, the emphasis on memory-based input/output is very realistic. 


**Deliverables**

rtl/mips_cpu_bus.v or rtl/mips_cpu_harvard.v : An implementation of a MIPS CPU which meets the pre-specified template for signal names and interface timings. You may also include other verilog modules in files of the form rtl/mips_cpu/*.v and/or rtl/mips_cpu_*.v. If you include both a bus and a harvard verilog file it will be assumed that you want the bus version to be assessed. Any files not matching these patterns will be ignored.

test/test_mips_cpu_bus.sh or rtl/test_mips_cpu_harvard.sh : A test-bench for any CPU meeting the given interface. This will act as a test-bench for your own CPU, but should also aim to check whether any other CPU works as well. You can include both scripts, but only the one corresponding to your submitted CPU (bus or harvard) will be evaluated.

docs/mips_data_sheet.pdf : A data-sheet for your CPU, consisting of at most 4 A4 pages. This data-sheet should cover:

The overall architecture of your CPU.
At least one diagram of your CPU's architecture.
Design decisions taken when implementing the CPU.
The approach taken to testing CPUs.
At least one diagram or flow-chart describing your testing flow or approach.
Area and timing summary for the "Cyclone IV E ‘Auto’" variant in Quartus (same as used in the EE1 "CPU" project).
(2021/12/13) A 5th page may be used, but only for references.

**Instruction Set**

The target instruction-set is 32-bit big-endian MIPS1, as defined by the MIPS ISA Specification (Revision 3.2).

The instructions to be tested are:

Code	Meaning
ADDIU	Add immediate unsigned (no overflow)
ADDU	Add unsigned (no overflow)
AND	Bitwise and
ANDI	Bitwise and immediate
BEQ	Branch on equal
BGEZ	Branch on greater than or equal to zero
BGEZAL	Branch on non-negative (>=0) and link
BGTZ	Branch on greater than zero
BLEZ	Branch on less than or equal to zero
BLTZ	Branch on less than zero
BLTZAL	Branch on less than zero and link
BNE	Branch on not equal
DIV	Divide
DIVU	Divide unsigned
J	Jump
JALR	Jump and link register
JAL	Jump and link
JR	Jump register
LB	Load byte
LBU	Load byte unsigned
LH	Load half-word
LHU	Load half-word unsigned
LUI	Load upper immediate
LW	Load word
LWL	Load word left
LWR	Load word right
MTHI	Move to HI
MTLO	Move to LO
MULT	Multiply
MULTU	Multiply unsigned
OR	Bitwise or
ORI	Bitwise or immediate
SB	Store byte
SH	Store half-word
SLL	Shift left logical
SLLV	Shift left logical variable
SLT	Set on less than (signed)
SLTI	Set on less than immediate (signed)
SLTIU	Set on less than immediate unsigned
SLTU	Set on less than unsigned
SRA	Shift right arithmetic
SRAV	Shift right arithmetic
SRL	Shift right logical
SRLV	Shift right logical variable
SUBU	Subtract unsigned
SW	Store word
XOR	Bitwise exclusive or
XORI	Bitwise exclusive or immediate
It is strongly suggested that you implement the following instructions first: JR, ADDU, ADDIU, LW, SW. This will match the instructions considered in the sanity checks.
