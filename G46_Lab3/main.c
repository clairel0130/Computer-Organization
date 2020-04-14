#include <stdio.h>

#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/push_buttons.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/ISRs.h"

int main(){

/*
//basic I/O 
	
	// disable all interrupt bits 
	disable_PB_INT_ASM(PB0);
	disable_PB_INT_ASM(PB1);
	disable_PB_INT_ASM(PB2);
	disable_PB_INT_ASM(PB3);

	// turn on all segments for HEX4 and HEX5 
	HEX_write_ASM(HEX4,8);
	HEX_write_ASM(HEX5,8);

	// initialize HEX displays
	HEX_t HEX = HEX0;
	
    while(1){
        write_LEDs_ASM(read_slider_switches_ASM());
		HEX_write_ASM(HEX, read_slider_switches_4_bits_ASM());
		
		if (PB_edgecap_is_pressed_ASM(PB0)){
			HEX = HEX0;
			PB_clear_edgecap_ASM(PB0);
		}
		if (PB_edgecap_is_pressed_ASM(PB1)){
			HEX = HEX1;
			PB_clear_edgecap_ASM(PB1);
		}
		if (PB_edgecap_is_pressed_ASM(PB2)){
			HEX = HEX2;
			PB_clear_edgecap_ASM(PB2);
		}
		if (PB_edgecap_is_pressed_ASM(PB3)){
			HEX = HEX3;
			PB_clear_edgecap_ASM(PB3);
		}
		if(read_slider_switch_ASM()== 512){
			HEX_clear_ASM(HEX0 | HEX1 | HEX2 | HEX3 | HEX4 | HEX5);
		}	
    }


*/

/*
//polling stopwatch
 
	disable_PB_INT_ASM(PB0);
	disable_PB_INT_ASM(PB1);
	disable_PB_INT_ASM(PB2);
	disable_PB_INT_ASM(PB3);

	int count = 0, active = 0; 				
	
	HPS_TIM_config_t hps_tim;
	HPS_TIM_config_t hps_tim1;
	
	hps_tim.tim = TIM0; 					// use timer 0
	hps_tim.timeout = 10000; 				//10 ms increment
	hps_tim.LD_en =1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;
	
	hps_tim1.tim = TIM1; 					// use timer 1
	hps_tim1.timeout = 2000; 				//2 ms increment
	hps_tim1.LD_en =1;
	hps_tim1.INT_en = 1;
	hps_tim1.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);
	HPS_TIM_config_ASM(&hps_tim1);

while(1){
	

	if (HPS_TIM_read_INT_ASM(TIM1)){
		HPS_TIM_clear_INT_ASM(TIM1);
		if (PB_edgecap_is_pressed_ASM(PB0)){
				active = 1;
				PB_clear_edgecap_ASM(PB0);
		}
		if (PB_edgecap_is_pressed_ASM(PB1)){
				active = 0;
				PB_clear_edgecap_ASM(PB1);
		}
		if (PB_edgecap_is_pressed_ASM(PB2)){
				count = 0;
				PB_clear_edgecap_ASM(PB2);
				HEX_write_ASM(HEX0, count % 100 / 10); 			// 10 ms
				HEX_write_ASM(HEX1, count % 1000 / 100);		// 100 ms
				HEX_write_ASM(HEX2, count / 1000 % 60 % 10); 	// second 
				HEX_write_ASM(HEX3, count / 1000 % 60 / 10);	// 10 second
				HEX_write_ASM(HEX4, count / 60000 % 10);		// minute
				HEX_write_ASM(HEX5, count / 600000);			// 10 minute
				
		}

		//this deals with display
		 if (active == 1){
			if (HPS_TIM_read_INT_ASM(TIM0)){
				HPS_TIM_clear_INT_ASM(TIM0);
				count += 10;
				if (count >= 995999)
					count = 0;
				HEX_write_ASM(HEX0, count % 100 / 10); 			// 10 millisecond
				HEX_write_ASM(HEX1, count % 1000 / 100);		// 100 millisecond
				HEX_write_ASM(HEX2, count / 1000 % 60 % 10); 	// second 
				HEX_write_ASM(HEX3, count / 1000 % 60 / 10);	// 10 second
				HEX_write_ASM(HEX4, count / 60000 % 10);		// minute
				HEX_write_ASM(HEX5, count / 600000);			// 10 minute

			}
		}
	}
}
*/  	

// interrupt stopwatch

	int count = 0, active = 0; 
	int_setup(2, (int []){73,199});				// configure & enable interrupts
	
	enable_PB_INT_ASM(PB0);
	enable_PB_INT_ASM(PB1);
	enable_PB_INT_ASM(PB2);
	enable_PB_INT_ASM(PB3);

	HPS_TIM_config_t hps_tim;

	hps_tim.tim = TIM0; 						// use timer 0
	hps_tim.timeout = 10000; 					//10 ms increment
	hps_tim.LD_en =1;
	hps_tim.INT_en = 1;
	hps_tim.enable = 1;

	HPS_TIM_config_ASM(&hps_tim);

	while(1){
		if (hps_tim0_int_flag){
			hps_tim0_int_flag = 0;

			//only starts counting if the start PB is pressed
			if (fpga_pb_keys_int_flag == 1){
				active = 1;
				fpga_pb_keys_int_flag = 0;
			}

			if (fpga_pb_keys_int_flag == 2){
				active = 0;
				fpga_pb_keys_int_flag = 0;
			}

			if (fpga_pb_keys_int_flag == 4){
				count = 0;
				fpga_pb_keys_int_flag = 0;
			}

			if(active){
				count += 10;
				if (count >= 995999)
					count = 0;
				HEX_write_ASM(HEX0, count % 100 / 10); 			// 10 ms
				HEX_write_ASM(HEX1, count % 1000 / 100);		// 100 ms
				HEX_write_ASM(HEX2, count / 1000 % 60 % 10); 	// second 
				HEX_write_ASM(HEX3, count / 1000 % 60 / 10);	// 10 second
				HEX_write_ASM(HEX4, count / 60000 % 10);		// minute
				HEX_write_ASM(HEX5, count / 600000);			// 10 minute

			}
		}
	}

	return 0;
}
