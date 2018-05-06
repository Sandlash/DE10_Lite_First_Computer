/**
 * @file main.c
 *
 * @mainpage MNIST 1-Layer Neural Network
 *
 * @brief Main characteristics: Only 1 layer (= input layer), no hidden layer.  Feed-forward only.
 * No Sigmoid activation function. No back propagation.\n
 *
 * @details Learning is achieved simply by incrementally updating the connection weights based on the comparison
 * with the desired target output (supervised learning).\n
 *
 * Its performance (success rate) of 85% is far off the state-of-the-art techniques (surprise, surprise) 
 * but close the Yann Lecun's 88% when using only a linear classifier.
 *
 * @see [Simple 1-Layer Neural Network for MNIST Handwriting Recognition](http://mmlind.github.io/Simple_1-Layer_Neural_Network_for_MNIST_Handwriting_Recognition/)
 * @see http://yann.lecun.com/exdb/mnist/
 * @version [Github Project Page](http://github.com/mmlind/mnist-1lnn/)
 * @author [Matt Lind](http://mmlind.github.io)
 * @date July 2015
 *
 */
 
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

#include "inc/mnist-utils.h"
#include "inc/1lnn.h"

#include "touch/terasic_includes.h"
#include "touch/LCD.h"
#include "touch/gui.h"
#include "touch/touch_spi.h"
#include "system.h"

void GUI_VPG(alt_video_display *pDisplay, TOUCH_HANDLE *pTouch);


int main() {
	uint8_t img_ready=0;
	uint8_t result;
	MNIST_Image img;

    Layer outputLayer;

    initLayer(&outputLayer);

    TOUCH_HANDLE *pTouch;
    alt_video_display Display;
    int delay , count ;
    while (count<10) {				//aspetta 2000000 cicli = 40 ms
        delay=0;
        while (delay <200000)
        	delay++;
        count++;
    }

   const bool bVPG = ((IORD(PUSH_BUTTON_BASE, 0x00) & 0x01) == 0x00)?TRUE:FALSE;

   // init touch
   pTouch = Touch_Init(TOUCH_PANEL_SPI_BASE, TOUCH_PANEL_PEN_IRQ_N_BASE, TOUCH_PANEL_PEN_IRQ_N_IRQ);
   if (!pTouch)
	   printf("Failed to init touch\r\n");
   else
	   printf("Init touch successfully\r\n");


   // init LCD
   LCD_Init();
   LCD_Clear(0X0000);

   Display.interlace = 0;
   Display.bytes_per_pixel = 2;
   Display.color_depth = 16;
   Display.height = SCREEN_HEIGHT;
   Display.width = SCREEN_WIDTH;

   // run demo
   if (bVPG)
	   GUI_VPG(&Display, pTouch); // enter vpg mode when users press KEY0
   else
	   GUI(&Display, pTouch);

   while(1){
		if(img_ready)
			 result=testLayer(&outputLayer, &img);
   }

    return 0;
}


