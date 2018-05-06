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

#include "../inc/mnist-utils.h"
#include "../inc/1lnn.h"


/**
 * @details Tests a layer by looping through and testing its cells
 * Exactly the same as TrainLayer() but WITHOUT LEARNING.
 * @param l A pointer to the layer that is to be training
 */

int testLayer(Layer *l){
    
    // open MNIST files
    FILE *imageFile;
    imageFile = openMNISTImageFile(MNIST_TESTING_SET_IMAGE_FILE_NAME);
    
        
	// Reading next image
	MNIST_Image img = getImage(imageFile);


	// loop through all output cells for the given image
	for (int i=0; i < NUMBER_OF_OUTPUT_CELLS; i++){
		testCell(&l->cell[i], &img);
	}

	uint8_t predictedNum = getLayerPrediction(l);
        
    
    // Close files
    fclose(imageFile);
    
    return predictedNum;

}




/**
 * @details Main function to run MNIST-1LNN
 */

int main() {
	uint8_t img_ready=0;
	uint8_t result;

    Layer outputLayer;

    initLayer(&outputLayer);
    
    while(1){
    	if(img_ready)
    		 result=testLayer(&outputLayer);
    }

    return 0;
}


