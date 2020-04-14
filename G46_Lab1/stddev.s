		.text
		.global _start

//Calculate the standard deviation of a given list of numbers

_start:
		LDR R4, =RESULT		// R4 points to the result location, used to store the address of the current min
		LDR R2, [R4, #8]	// R2 holds the number of elements in the list 
		ADD R3, R4, #12		// R3 points to the first number 
		LDR R0, [R3]		// R0 holds the first number in the list, and stores temporary min 
		
		LDR R5, =RESULT1	// R4 points to the RESULT1 location, used to store the address of the current max
	    LDR R6, [R3]		// stores temporary max
		
LOOP:   SUBS R2, R2, #1		// decrement the loop counter
		BEQ DONE 			// end loop if the counter has reached 0
 		ADD R3, R3, #4		// R3 points to the next number in the list 
		LDR R1, [R3]		// R1 holds the next number in the list 
		CMP R0, R1			// check if it is less than the minimum
		BLE NEXT			// if current number is NOT less than temp min, branch to NEXT
		MOV R0, R1			// if currrent number is less than temp min, update the current min
		B LOOP				// branch back to the loop
NEXT:	CMP R6, R1
		BGE LOOP			// if current number is NOT greater than temp max, branch to LOOP
		MOV R6, R1			// if yes, update the current max
		B LOOP				// branch back to the loop

DONE:   STR R0, [R4]		//store the min result to the memory location
		STR R6, [R5]        //store the max result to memory location
		SUBS R7, R6, R0
		ASR R8, R7, #2
END:    B END

RESULT: .word 0				// memory assigned for result location
RESULT1:.word 0
N: 		.word 7				// number of entries in the list
NUMBERS:.word 4,5,3,6 		// the list data 
		.word 1,9,2


	
