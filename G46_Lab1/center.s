		.text
		.global _start

_start: 
		LDR R4, =SUM		//R4 points to the result location, used to store the address of the final answer
		LDR R2, [R4, #4]	//R2 holds the number of elements in the list   
		ADD R6, R2, #1		//R6 hold the number of elements in the list (for LOOP1)
		ADD R3, R4, #8		//R3 points to the first number 
		LDR R0, [R3]		//R0 holds the first number in the list, and stores current sum

LOOP:   SUBS R2, R2, #1		//decrement the loop counter
		BEQ DONE 			//end loop if the counter has reached 0
 		ADD R3, R3, #4		//R3 points to the next number in the list
		LDR R1, [R3]        //R1 stores the next number
		ADD R0, R1, R0		//update the current sum
		B LOOP				//branch back to the loop

DONE:   STR R0, [R4]		//store the sum in memory location
		ASR R5, R0, #3      //divide total sum by 8 to compute average
		ADD R3, R3, #4		//add offset of 4 to R3 to correct the counter for LOOP1

LOOP1:  SUBS R6, R6, #1		//decrement LOOP1 counter
		BEQ END				//end loop if the counter has reached 0
		SUBS R3, R3, #4		//R3 points to the last/next number in the list
		LDR R7, [R3]		//R7 stores the next number
		SUBS R8, R7, R5     //R8 stores the difference between current number and average
		STR R8, [R3]        //store centered value to location of corresponding number
		B LOOP1				//branch back to LOOP1
	
END:    B END

SUM: .word 0
N: 		.word 8				//number of entries in the list
NUMBERS:.word 4,5,3,6 		// the list data 
		.word 1,9,2,10
