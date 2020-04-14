#ifndef __HPS_TIM
#define __HPS_TIM

	typedef enum {
		TIM0 = 0x00000001,
		TIM1 = 0x00000002,
		TIM2 = 0x00000004,
		TIM3 = 0x00000008
	}	HPS_TIM_t;

	typedef struct {
		HPS_TIM_t tim;
		int timeout; // in usec
		// the last three elements should be set to 1 to be enabled, or 0 to be disabled
		int LD_en;
		int INT_en;
		int enable;
	}	HPS_TIM_config_t;
	
	extern void HPS_TIM_config_ASM(HPS_TIM_config_t *param); 	// the argument is a struct pointer 
	
	/* Reads the value of the S-bit (offset = 0x10)
	The nature of the return value will deoend on 
	wether this function is able to read  the 
	S-bit value of multiple timers in the same call*/
	extern int HPS_TIM_read_INT_ASM(HPS_TIM_t tim);

	/* Resets the S-bot and the F-bit 
	This function should suppoert multiple timers in 
	the argument*/
	extern void HPS_TIM_clear_INT_ASM(HPS_TIM_t tim);

#endif
