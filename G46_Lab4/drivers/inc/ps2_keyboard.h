#ifndef __ps2_keyboard
#define __ps2_keyboard
	/* 1. Checks RVALID bit in the PS/2 Data register, if it's valid
		  then the data form the same register should be stored at the address in the char pointer argument
	   2. Retuns 1 to denote valid data, if RVALID is not set, then it returns 0
	*/
	int read_PS2_data_ASM(char *pointer);

#endif
