	.text
	
	.equ VGA_PIXEL_BUF_BASE, 0xC8000000
	.equ VGA_CHAR_BUF_BASE, 0xC9000000

	.global VGA_clear_charbuff_ASM
	.global VGA_clear_pixelbuff_ASM
	.global VGA_write_char_ASM
	.global VGA_write_byte_ASM
	.global VGA_draw_point_ASM

//Should clear (set to 0) all the valid memory locations in the pixel buffer
//Pixel Buffer: 320 x 240	
VGA_clear_pixelbuff_ASM:
	PUSH {R4-R5}								//push R4, R5 onto stack
	MOV R2, #0									//R2 stores 0, used later to write 0 to every memory location
	LDR R3, =VGA_PIXEL_BUF_BASE					//store pixel buffer base address in R3
	MOV R0, #0									//initialize R0, R0 = 0
PIXEL_LOOPX:
	MOV R1, #0									//initialize R1, R1 = 0
	ADD R4, R3, R0, LSL #1						//R4 stores (base addr + x)
PIXEL_LOOPY:
	ADD R5, R4, R1, LSL #10						//R5 stores (base addr + y)
	
	STRH R2, [R5]								//store the content of the pixel address into R2
	
	ADD R1, R1, #1								//R1 = y_counter + 1
	CMP R1, #240								//checks if all y_coordinates has been looped
	BLT PIXEL_LOOPY								//if y_counter < 240, loop back to PIXEL_LOOPY
	
	ADD R0, R0, #1								//R0 = x_counter + 1
	CMP R0, #320								//checks if all x_coordinates has been looped
	BLT PIXEL_LOOPX								//if x_counter < 320, loop back to PIXEL_LOOPX

	POP {R4-R5}									//restore stack 
	BX LR										



//Draws a point on the screen with the colour as indicated in the third argument, 
//by only accessing the pixel buffer memory (320 x 240)
VGA_draw_point_ASM:
	LDR R3, =319								//load 319 into R3, R3 = # of x_pixels
	CMP R0, #0									//if x_input < 0, return
	BXLT LR
	CMP R1, #0									//if y_input < 0, return
	BXLT LR
	CMP R0, R3									//if x_input > 319, return
	BXGT LR
	CMP R1, #239								//if y_input > 239, return
	BXGT LR
	
	LDR R3, =VGA_PIXEL_BUF_BASE					//load pixel buffer base address into R3
	ADD R3, R3, R0, LSL #1						//R3 = base addr + x
	ADD R3, R3, R1, LSL #10						//R3 = base addr + y
	STRH R2, [R3]								//store input colour into corresponding pixel address
	BX LR





//Should clear (set to 0) all the valid memory locations in the character buffer
VGA_clear_charbuff_ASM:
	PUSH {R4-R5}								//push R4, R5 onto stack
	MOV R2, #0									//R2 stores 0, used later to write 0 to every memory location
	LDR R3, =VGA_CHAR_BUF_BASE					//store pixel buffer base address in R3
	MOV R0, #0									//initialize R0, R0 = 0
CHAR_LOOPX:
	MOV R1, #0									//initialize R1, R1 = 0
	ADD R4, R3, R0								//R4 stores (base addr + x)
CHAR_LOOPY:
	ADD R5, R4, R1, LSL #7						//R5 stores (base addr + y)
	
	STRB R2, [R5]								//store the content of the pixel address into R2
	
	ADD R1, R1, #1								//R1 = y_counter + 1
	CMP R1, #60									//checks if all y_coordinates has been looped
	BLT CHAR_LOOPY								//if y_counter < 60, loop back to CHAR_LOOPY
	
	ADD R0, R0, #1								//R0 = x_counter + 1
	CMP R0, #80									//checks if all x_coordinates has been looped
	BLT CHAR_LOOPX								//if x_counter < 80, loop back to CHAR_LOOPX

	POP {R4-R5}									//restore stack 
	BX LR





//Should write the ASCII code passed in the third argument to the screen at the (x,y) coordinates given in the first two arguments
//Essentially, the subroutine stores the value of the third argument at the address calculated with the first two arguments
//Should also check if the given coordinate (x,y) is valid
VGA_write_char_ASM:

	//LDR R3, =319								//load 319 into R3, R3 = # of x_pixels
	CMP R0, #0									//if x_input < 0, return
	BXLT LR
	CMP R1, #0									//if y_input < 0, return
	BXLT LR
	CMP R0, #79									//if x_input > 79, return
	BXGT LR
	CMP R1, #59									//if y_input > 59, return
	BXGT LR
	
	LDR R3, =VGA_CHAR_BUF_BASE					//load character buffer base address into R3
	ADD R3, R3, R0								//R3 = base addr + x
	ADD R3, R3, R1, LSL #7						//R3 = base addr + x + y
	STRB R2, [R3]								//store input colour into corresponding char address
	BX LR





//Should write HEX representation of the value passed in the third argument to the screen
//This subroutine will print two characters to the screen
//Check validity of the input coordinate (take into account that 2 arguments will be displayed)
VGA_write_byte_ASM:
	PUSH {R3-R7}
	LDR R3, =VGA_CHAR_BUF_BASE					//load character buffer base address into R3
	LDR R4, =HEX_ASCII							//load HEX_ASCII address into R4

	//Checks if input coordinate is valid
	CMP R0, #0									//if x_input < 0, return
	BXLT LR
	CMP R1, #0									//if y_input < 0, return
	BXLT LR
	CMP R0, #78									//if x_input > 78, return
	BXGT LR
	CMP R1, #58									//if y_input > 58, return
	BXGT LR

	//Calculates the appropriate char address
	ADD R3, R3, R0								//R3 = base addr + x
	ADD R3, R3, R1, LSL #7						//R3 = base addr + x + y

	//Store first char
	//PUSH {R5-R6}
	LSR R5, R2, #4								//R5 has the first HEX
	LDRB R6, [R4,R5]							//load corresponding element in the array into R6
	STRB R6, [R3]								//store the appropriate number into the buffer address
	//POP {R5-R6}

	//Store second char	
	ADD R3, R3, #1								//R3 = previous R3 + 1
	SUB R5, R2, R5, LSL #4						//R5 has second HEX
	LDRB R7, [R4,R5]							//R7 has corresponding element in HEX_ASCII for second HEX
	STRB R7, [R3]								//store 
	POP {R3-R7}
	BX LR

HEX_ASCII:
	.byte 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
	//      0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F  // 
	.end
	
