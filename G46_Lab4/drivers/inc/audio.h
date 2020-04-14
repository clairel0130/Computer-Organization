#ifndef __audio
#define __audio
	/* 1. Take one int argument and write it to both the left and right FIFO only if there's space
	   2. Returns 1 if the data was written to the FIFOs, and returns 0 otherwise
	*/
	int audio_ASM(int x);

#endif
