		.text
		.global _start
_start:
		LDR	R3, =N				//R3 stores the address of N
		LDR R0, [R3,#4] 		//load first number in the list to R0
		STR	R0, [SP, #-4]! 		//update the SP
		LDR R0, [R1, #8]		//load second number in the list to R0
		STR R0, [SP, #-4]!		//update the SP
		LDR R0, [R1, #12]		//load third number in the list to R0
		STR R0, [SP,#-4]!		//update the SP 
		LDR R0, [SP], #4		//pop()
		LDR R1, [SP], #4		//pop()
		LDR R2, [SP], #4		//pop()


N:		.word 3
NUMBERS:.word 7,3,5
