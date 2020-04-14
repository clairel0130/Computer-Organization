		.text		
		.global MAX_2

//Compare two numbers and returns the larger number
MAX_2:
		CMP R0, R1
		BXGE LR
		MOV R0, R1
		BX LR
		.end
		
