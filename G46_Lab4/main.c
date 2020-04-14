#include <stdio.h>
#include "./drivers/inc/VGA.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/push_buttons.h"

void test_char() {
		int x,y;
		char c = 0;

		for (y=0; y<=59; y++)
			for (x=0; x<=79; x++)
				VGA_write_char_ASM(x,y,c++);
}

void test_byte() {
	int x,y;
	char c = 0;

	for(y=0; y<=59; y++)
		for(x=0; x<=79; x+=3)
			VGA_write_byte_ASM(x,y,c++);
}

void test_pixel() {
	int x,y;
	unsigned short colour = 0;

	for (y=0; y<=239; y++)
		for (x=0; x<=319; x++)
			VGA_draw_point_ASM(x,y,colour++);
}	

/*void test_keyboard(){
	int x,y;
	char data = 0;
	if (read_PS2_data_ASM(&data)){
		if(x>=79){
			x = 0;
			y++;
		}		
		VGA_write_byte_ASM(x,y,data);	
		x+=3;
	}
} */


int main() {
	int x = 0;
	int y = 0;
	char data = 0;
	int counter = 0;
	int sample1 = 0x00FFFFFF;
	int sample0 = 0x00000000;

	while(1){
		if (counter<=240) {
			if (audio_ASM(sample1))
				counter++;
		}
		else {
			if (audio_ASM(sample0))
				counter++;
		}
			
		if (counter > 480) {
			counter = 0;
		}
		


//KEYBOARD
			if (read_PS2_data_ASM(&data)){
				if (x>=79) {
					x = 0;
					y++;
				}
				VGA_write_byte_ASM(x,y,data);
				x+=3;
			}
		//}
			


// VGA
		if (read_slider_switches_ASM()> 0 && PB_data_is_pressed_ASM(PB0)){
			test_byte();
		}
		//if slide switch not on and PB0 is pressed, call test_char()
		if (read_slider_switches_ASM() == 0 && PB_data_is_pressed_ASM(PB0)){
			test_char();
		}
		//if PB1 is pressed, call test_pixel()
		if (PB_data_is_pressed_ASM(PB1)){
			test_pixel();
		}
		//if PB2 is pressed, clear char buffer
		if (PB_data_is_pressed_ASM(PB2)){
			VGA_clear_charbuff_ASM();
		}
		//if PB3 is pressed, clear pixel buffer
		if (PB_data_is_pressed_ASM(PB3)){
			VGA_clear_pixelbuff_ASM();
		} 
		
    } 
	return 0;
}

	
