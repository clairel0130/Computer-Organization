		.text
		.global _start

_start: 
		LDR R4, =N			//R4 points to the N location, used to store the address of the final answer
		LDR R2, [R4]	    //R2 holds the number of elements in the list
		MOV R9, R2			//R9 is a counter for INNER loop
		MOV R6, R2			//R6 hold the number of elements in the list (for OUTER loop)
		MOV R3, R4			//R3 points to N (whose value is 8 here)
		ADD R7, R3, #4      //R7 points to the first number


INNER:  SUBS R9, R9, #1		// decrement the INNER loop counter 
		BEQ OUTER 			// branch to outer loop if counter reaches 0
		ADD R3, R3, #4		// R3 points to the next number in the list 
		ADD R7, R7, #4		// R7 points to the next next number in the list
		LDR R0, [R3]		// R0 holds the first number in the list
		LDR R1, [R7]		// R1 holds the second number in the list 
		CMP R0, R1			// check if R1 (second number) is smaller
		BLE INNER			// if no, branch back to the loop
		MOV R8, R1			// if yes, use R8 as a temp storage for R1
		MOV R1, R0			// swap the value of R0 and R1
		MOV R0, R8			// continuation of swapping between R0 and R1
		STR R0, [R3]		// store the smaller number to corresponding address
		STR R1, [R7]		// store the larger number to corresponding address
		B INNER				// branch back to the loop

OUTER:  SUBS R6, R6, #1		// decrement the OUTER loop counter
		BEQ END 			// branch to END if counter reaches 0
		MOV R9,R2 			// reset the counter for INNER loop to number of elements
		MOV R3, R4			// reset the pointer for first number we are comparing
		ADD R7, R3, #4		// reset the pointer for second number we are comparing
		B INNER				// branch back to INNER loop

END:    B END

N: 		.word 8				// number of entries in the list
NUMBERS:.word 9,7,8,4 		// the list data 
		.word 6,10,2,3
