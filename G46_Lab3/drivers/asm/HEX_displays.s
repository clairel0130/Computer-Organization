.text

.equ  HEX03_BASE, 0xFF200020
.equ  HEX45_BASE, 0xFF200030

.global HEX_clear_ASM
.global HEX_flood_ASM
.global HEX_write_ASM

HEX_clear_ASM:
  LDR R3, =HEX45_BASE
  LDR R1, =HEX03_BASE
  MOV R2, #0x00000000
  MOV R4, #5
  MOV R8, #1
  MOV R6, #0
  B FINDER
FINDER:
  SUBS R4, R4, #1			// DECREMENT counter, 6 COMPARISONS
  BEQ UPDATE
  TST R0, R8
  BEQ NOEND_CLEAR
  ADD R6, R5, R6
  LSL R8, R8, #1
  LSL R5, R5, #8
  B FINDER
NOEND_CLEAR:
  LSL R8, R8, #1
  LSL R5, R5, #8
  B FINDER

UPDATE:
  MOV R5, #0x00000000
  STR R5, [R3]
  LSL R5, R5, #8
  STR R5, [R3]
  STR R6, [R1]
  BX LR
  

  
HEX_flood_ASM:
  LDR R3, =HEX03_BASE
  LDR R1, =HEX45_BASE
  MOV R7, #5
  MOV R9, #3
  MOV R5, #0x7F
  MOV R8, #1
  MOV R6, #0
  MOV R10, #0
  B FINDER_FLOOD
FINDER_FLOOD:
  SUBS R7, R7, #1
  BEQ END_FLOOD
  TST R0, R8
  BEQ SOME
  ADD R6, R5, R6
  LSL R8, R8, #1
  LSL R5, R5, #8
  B FINDER_FLOOD 
END_FLOOD:
  LSL R8, R8, #1
  LSL R5, R5, #8
  B FINDER_FLOOD


UPDATE_A: 
  STR R6, [R3]
  STR R10, [R1]
  BX LR





HEX_write_ASM:
  PUSH {R4-R12}
  LDR R2, =HEX03_BASE
  LDR R4, =HEX45_BASE
  // compare the input char with the 0-15 inorder to determine what to display (Store in R3)
  CMP R1, #0						
  MOVEQ R3, #0x00111111
  CMP R1, #1
  MOVEQ R3, #0x00000110
  CMP R1, #2
  MOVEQ R3, #0x01011011
  CMP R1, #3
  MOVEQ R3, #0x01001111
  CMP R1, #4
  MOVEQ R3, #0x01100110
  CMP R1, #5
  MOVEQ R3, #0x01101101
  CMP R1, #6
  MOVEQ R3, #0x01111101
  CMP R1, #7
  MOVEQ R3, #0x00000111
  CMP R1, #8
  MOVEQ R3, #0x01111111
  CMP R1, #9
  MOVEQ R3, #0x01100111
  CMP R1, #10
  MOVEQ R3, #0x01110111
  CMP R1, #11
  MOVEQ R3, #0x01111100
  CMP R1, #12
  MOVEQ R3, #0x00111001
  CMP R1, #13
  MOVEQ R3, #0x01011110
  CMP R1, #14
  MOVEQ R3, #0x01111001
  CMP R1, #15
  MOVEQ R3, #0x01110001
  MOV R7, #5						 // R7 is a counter that counts the number of comparison
  MOV R8, #1				   		 // initial 0x00000001



FINDER_B:
  SUBS R7, R7, #1					// counter decrement 
  BEQ UPDATE						// counter = 0, branch to UPDATE
  TST R0, R8						// If the input HEX is equal to R8
  BEQ NOEND							
  STRB R3, [R2]						// store the display content to the address
  LSL R8, R8, #1					// logical shift by 1 
  ADD R2, R2, #1					// move to next HEX display (address) accordingly 
  B FINDER_B						// just in case that the input is not just one
NOEND:
  LSL R8, R8, #1
  ADD R2, R2, #1
  B FINDER_B


UPDATE:
  POP {R4-R12}
  BX LR

.end  






