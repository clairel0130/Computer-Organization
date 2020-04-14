			.text
			.equ LED_BASE, 0xFF200000
			.global read_LEDs_ASM
			.global write_LEDs_ASM

/*
load the value at the LED base address into R0 and then branch exit to 
the main method
 */
 
read_LEDs_ASM:
			LDR R1, =LED_BASE
        	LDR R0,[R1]
			BX LR


/*
store the value in R0 at the LED base address,
and then branch exit to main method.
 */

write_LEDs_ASM:
			LDR R1, =LED_BASE
			STR R0,[R1] // R0 is the argument that is written to the LED address
			BX LR


			.end
