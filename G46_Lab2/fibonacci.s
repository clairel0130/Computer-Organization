		.text
		.global _start

_start:	LDR R1, =RESULT		//R1 points to INPUT location
		LDR R0, [R1, #16]	//R0 holds the parameter n 
		PUSH {R0, LR}	    //push parameter and LR
		BL	fib				//enter the subroutine fib
		LDR R0, [SP, #-12]  // the result that we want has already been poped, thus we have to load it from 3 position before the sp 
		STR R0, [R1]		// store the fib(n) to the RESULT address that stores in R1
		ADD SP, SP, #8		// pop all the content on the stack 

STOP:   B STOP				// branch stop 
fib:	PUSH {R0, R2, LR}	// push R0, R2 and LR(LR at first time is the link register to the next line of BL fib) on stack
		SUB R2, R0, #1		// set R2 = R0 - 1
		CMP R0, #2			//compare R0 with 2
		BGE if				//if R0 is greater than or equal to 2, enter subroutine 'if'
		BLT else			//if R0 is less than 2, ener subroutine 'else'

if:		SUB R0, R0, #1		//compute input-1 and store result in R0 (R0 stores n-1, where R0=n initially)
		SUB R2, R2, #1		// R2, now, is n-2
		BL	fib				//branch back to fib
		ADD R0, R0, R2		// after the the loop has been to else once, start to comput the sum of fib(n-1) and fib(n-2)
		STR R0, [SP, #0]	// store the new fib(n) in R0 on the stack 
		LDR R2, [SP, #-12]	// load R2(right now fib(n-2)) with the previous value of R0(fib(n-1))
		STR R2, [SP, #4]	// store the new fib(n-1) in R2 on the stack
		B 	return			// branch to return 

else:	MOV R0, #1			// replace the value of R0 by 1( originally 1)
		MOV R2, #1			// replace the value of R0 by 1(originally 0)
		STR R2, [SP, #4]	// store the new R2 value on the stack at the position of the last R2 that we push 
		B 	return			// branch to return 

return:	POP {R0, R2, LR}	// pop the R0, R2, LR
		BX 	LR				// branch back to the position that the link register, which we just poped,  


RESULT:  .word 0			// act as a reference location to access input number
NUMBERS: .word 1,2,3,19,11   // list of potential inputs that the user can use
