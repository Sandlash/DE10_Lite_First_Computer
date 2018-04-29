
module NiosII_esercitazione (
	clk_clk,
	hex3_hex0_export,
	hex5_hex4_export,
	leds_export,
	push_button_export,
	reset_reset_n,
	sliders_export);	

	input		clk_clk;
	output	[7:0]	hex3_hex0_export;
	output	[31:0]	hex5_hex4_export;
	output	[9:0]	leds_export;
	input	[1:0]	push_button_export;
	input		reset_reset_n;
	input	[9:0]	sliders_export;
endmodule
