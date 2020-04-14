 .text
 .equ	SW_BASE, 0xFF200040
 .global	read_slider_switches_ASM

//reads value at the memory location designated for the slider switches
//data into the R0 register, and then branch to the link register
read_slider_switches_ASM:
	LDR R1, =SW_BASE
	LDR R0, [R1]
	BX LR

 .end
