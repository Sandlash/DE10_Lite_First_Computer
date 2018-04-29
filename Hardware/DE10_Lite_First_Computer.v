module DE10_Lite_First_Computer(

	//////////// CLOCK //////////
	input 		          		MAX10_CLK1_50,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================


//=======================================================
//  Structural coding
//=======================================================

    
    NiosII_esercitazione u0 (
        .clk_clk          (MAX10_CLK1_50),          //clk.clk
        .reset_reset_n    (KEY[0]),   					 //reset.reset_n
        .leds_export      (LEDR[9:0]),      			//leds.export
        .sliders_export   (SW[9:0]),   				//sliders.export
        .hex3_hex0_export ({HEX3[7:0],HEX2[7:0],HEX1[7:0],HEX0[7:0]}), // hex3_hex0.export
        .hex5_hex4_export ({16'b0,HEX5[7:0],HEX4[7:0]}),  				// hex5_hex4.export
		  .push_button_export (KEY[1]),  // push_button.export
    );




endmodule
