	.text
	
	.equ PS2_DATA, 0xFF200100
	.equ PS2_CONTROL, 0xFF200104

	.global read_PS2_data_ASM
	

/* 1. Checks RVALID bit in the PS/2 Data register, if it's valid
	  then the data from the same register should be stored at the address in the char pointer argument
   2. Retuns 1 to denote valid data, if RVALID is not set, then it returns 0
*/
read_PS2_data_ASM:
	LDR R1, =PS2_DATA
	LDR R2, [R1]
	AND R3, R2, #0x8000							//R3 has the RVALID bit of the PS2_DATA register (16th bit)
	CMP R3, #0x8000								//check if RVALID is 1
	BEQ VALID
	MOV R0, #0
	BX	LR

VALID:
	AND R2, R2, #0x000000FF
	STRB R2, [R0]
	MOV R0, #1
	BX 	LR


	.end
