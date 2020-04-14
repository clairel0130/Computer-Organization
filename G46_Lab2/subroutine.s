		.text
		.global _start

//Calculate the greatest integer in a list
_start:
		LDR R4, =RESULT		//R4 points to the result location
		LDR R2, [R4, #4]	//R2 holds the number of elements in the list 
		ADD R3, R4, #8		//R3 points to the first number 
		LDR R0, [R3]		//R0 holds the first number in the list
		PUSH {R0-R4, LR}	//push R0-R4 and LR to stack
		BL findmax			//enter subroutine findmax
		LDR R0, [SP, #0]	//load return value from stack
		STR R0, [R4]		//store result in memory 
		POP {R0-R4, LR}		//restore stack by popping all elements
			

STOP: 	B STOP

findmax:
		PUSH {R0-R4}		//callee-save the registers that findmax will use 
		LDR R3, [SP, #12]	//load pointer to first number from stack
		LDR R0, [SP, #0]	//load first number/current max from stack
		LDR R2, [SP, #8]	//load param N from stack
LOOP:  
		SUBS R2, R2, #1		//decrement loop counter
		BEQ DONE 			//if counter is greater than or equal to 0, branch back to loop
 		ADD R3, R3, #4		//R3 points to the next number in the list 
		LDR R1, [R3]		//R1 holds the next number in the list 
		CMP R0, R1			//check if it is greater than the maximum
		BGE LOOP			//if current max is greater, branch back to the loop
		MOV R0, R1			//if not, update the current max
		B LOOP 				//branch back to LOOP

DONE:   
		STR R0, [SP, #20]	//store result on stack
		POP {R0-R4}			//restore the registers
		BX LR				//branch exit

RESULT: .word 0				//memory assigned for result location
N: 		.word 7				//number of entries in the list
NUMBERS:.word 4,5,3,6 		//the list data 
		.word 1,8,2		
