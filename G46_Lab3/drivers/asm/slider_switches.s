			.text
			.equ SW_BASE, 0xFF200040
			.global read_slider_switches_ASM 
			.global read_slider_switches_4_bits_ASM

/*
 this subroutine reads the value at the the base address of the slider switches
 and returns this value
 */

read_slider_switches_ASM:
			LDR R1, =SW_BASE
			LDR R0,[R1]
			BX LR

/*
  this subroutine reads the last 4 bits of the value at the slider switch's
  base address
  */ 
read_slider_switches_4_bits_ASM:
			LDR R1, =SW_BASE
			LDR R0,[R1]
			BFC R0, #4, #28
			BX LR
		
			.end



