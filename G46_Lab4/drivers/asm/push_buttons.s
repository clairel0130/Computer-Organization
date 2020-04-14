			.text
			.equ PB_BASE, 0xFF200050
			.equ PB_INT, 0xFF200058
			.equ PB_EDGE, 0xFF20005C
			.global read_PB_data_ASM
			.global PB_data_is_pressed_ASM
			.global read_PB_edgecap_ASM
			.global PB_edgecap_is_pressed_ASM
			.global PB_clear_edgecap_ASM
			.global enable_PB_INT_ASM
			.global disable_PB_INT_ASM


/* These subroutine only access the pushbutton data register*/
read_PB_data_ASM:
			LDR R1, =PB_BASE
			LDR R0,[R1]
			BX LR
			
PB_data_is_pressed_ASM:
			/*PUSH {R1-R2}
			MOV R2,R0 // copy PB identifier from R0 into R2
			MOV R0,#0
			LDR R1, =PB_BASE
			LDRB R3, [R1]
			AND R3,R3,R2
			TEQ R2,R3
			MOVEQ R0,#1 //return 1 if data register bit is on
			POP {R1-R2}
			BX LR */
			LDR R1, =PB_BASE
  			LDR R1, [R1]
  			AND R3, R1, R0
  			CMP R3, R0
  			MOVEQ R0, #1
  			MOVNE R0, #0
  			BX LR      

/* These subroutines only access the pushbutton edgecapture register */
read_PB_edgecap_ASM:
			LDR R1, =PB_EDGE
			LDRB R0, [R1]
			BX LR
	
PB_edgecap_is_pressed_ASM:
			/*PUSH {R1-R2}
			MOV R2,R0 // copy PB identifier from R0 into R2
			MOV R0,#0
			LDR R1, =PB_EDGE
			LDRB R3, [R1]
			AND R3,R3,R2
			TEQ R2,R3
			MOVEQ R0,#1 //return 1 if edge capture bit is on
			POP {R1-R2}
			BX LR */
			LDR R1, =PB_EDGE
  			LDR R1, [R1]
  			AND R3, R1, R0
  			CMP R3, R0
  			MOVEQ R0, #1
  			MOVEQ R0, #0
  			BX LR      

PB_clear_edgecap_ASM:
			PUSH {R0-R1}
			LDR R0, =PB_EDGE
			MOV R1,#0xF
			STR R1,[R0]
			POP {R0-R1}
			BX LR
			//PUSH {R1-R2}
			//LDR R1, =PB_EDGE
			//LDR R2, [R1]
			//BIC R2, R2, R0 
			//STR R2, [R1]
			//LDR R2, [R1]
			//POP {R1-R2}
			//BX LR

/* These subroutines only access the pushbutton interrupt mask register */
enable_PB_INT_ASM:
			PUSH {R1-R2}
			LDR R1, =PB_INT
			LDRB R2, [R1]
			ORR R2, R2, R0 
			STRB R2, [R1]
			POP {R1-R2}
			BX LR

disable_PB_INT_ASM:
			PUSH {R1-R2}
			LDR R1, =PB_INT
			LDRB R2, [R1]
			BIC R2, R2, R0 
			STRB R2, [R1]
			POP {R1-R2}
			BX LR


			.end
