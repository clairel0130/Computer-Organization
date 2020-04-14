	.text
	
	.equ FIFO_SPACE, 0xFF203044
	.equ LEFT_DATA,  0xFF203048
	.equ RIGHT_DATA, 0xFF20304C

	.global audio_ASM
	
	/* 1. Take one int argument and write it to both the left and right FIFO only if there's space
	   2. Returns 1 if the data was written to the FIFOs, and returns 0 otherwise
	*/

audio_ASM:
	PUSH {R4-R5, LR}
	LDR R1, =FIFO_SPACE
	LDR R2, =LEFT_DATA
	LDR R3, =RIGHT_DATA
	LDR R1, [R1]						//load content of FIFO_SPACE into R1
	AND R4, R1, #0x00FF0000				//R4 now has WSRC
	AND R5, R1, #0xFF000000				//R5 now has WSLC
	CMP R4, #0							//Compare WSRC with 0
	BEQ	INVALID							//if WSRC = 0, go to INVALID
	CMP R5, #0							//Compare WSLC with 0
	BEQ	INVALID							//if WSRC = 0, go to INVALID
	STR R0, [R2]						//store input int to LEFT_DATA
	STR R0, [R3]						//store input int to RIGHT_DATA
	MOV R0, #1							//return value = 1
	POP {R4-R5, LR}
	BX	LR								//return


INVALID:
	MOV R0, #0							//return value = 0
	BX  LR								//return


	.end
