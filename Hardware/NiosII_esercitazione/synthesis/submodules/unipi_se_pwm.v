/*
*  unipi_se_pwm.v
*  pwm module with enable, PERIOD register and double buffered COMPARE register
*  Avalon MM slave interface:
*                   0  CONTROL (R/W)
*                   1  PERIOD  (R/W))
*                   2  COMPARE (R/W))
*/

module unipi_se_pwm (
                        // inputs:
                         address,
                         clk,
                         reset_n,
						 read,
                         write,
                         writedata,

                        // outputs:
                        readdata,
						pwm_out
                     );
    
	  // parameters
	  parameter			RESET_PERIOD	= 0; 
	  parameter			RESET_COMPARE = 0;
	  parameter			RESET_PWM_ENABLE = 0;
	
	  //output
	  output           pwm_out;
	  output    [31:0] readdata;
	  //input
	  input     [1:0]  address;
	  input            clk;
	  input            reset_n;
	  input				read;
	  input            write;
	  input		[31:0] writedata;
	  
	  reg		[31:0] 	readdata;
	  reg		[31:0] 	internal_counter;
	  reg		       	pwm_out_reg;
	  reg		[31:0] 	period_register;
	  wire            period_wr_strobe;
	  reg		[31:0] 	compare_register;
	  reg		[31:0] 	compare_register_loaded;
	  wire            	compare_wr_strobe;
	  reg	   		  	control_register;
	  wire			   	control_wr_strobe;
	  wire			   	pwm_enabled;
	  wire			   	internal_counter_is_zero;
	  wire			   	internal_counter_is_max;
	  wire			   	force_clear;
	  
	  
	  // compare register buffered
	  always @(posedge clk or negedge reset_n)
		 begin
			if (reset_n == 0)
				 compare_register_loaded <= RESET_COMPARE;
			else if (internal_counter_is_max)							//il valore di compare può essere aggiornato solo quando il timer va a zero se si vuole evitare di avere un ciclo pwm a duty cycle 100% (dannoso per i mos)
						compare_register_loaded <= compare_register;
		 end
	
	  // up counter
	  always @(posedge clk or negedge reset_n)
		 begin
			if (reset_n == 0)
				 internal_counter <= 32'b0;
			else if (pwm_enabled || force_clear)
					 if (internal_counter_is_max || force_clear)
						internal_counter <= 0;
					else 
					  internal_counter <= internal_counter + 1;		//contatore che funge da onda a denti di sega da confrontare con la soglia "compare"
		 end
		 
		// pwm out
	  always @(posedge clk or negedge reset_n)
		 begin
			if (reset_n == 0)
				 pwm_out_reg <= 1'b0;
			else if (internal_counter_is_max)							//l'uscita del pwm è alta fintanto che counter < compare
					  pwm_out_reg <= 1;
					else if(internal_counter == compare_register_loaded)
					  pwm_out_reg <= 0;			  
		 end
		 
	  assign pwm_out = pwm_out_reg & pwm_enabled;
	 
	  assign internal_counter_is_zero = (internal_counter == 0);
	  assign internal_counter_is_max = (internal_counter == period_register);
	  assign force_clear = period_wr_strobe;
		 
	  // write period and compare registers
	  assign control_wr_strobe = write && (address == 0);
	  assign period_wr_strobe  = write && (address == 1);
	  assign compare_wr_strobe = write && (address == 2);
	  
	  always @(posedge clk or negedge reset_n)
		 begin
			if (reset_n == 0)
				 control_register <= RESET_PWM_ENABLE;
			else if (control_wr_strobe)
				 control_register <= writedata;
		 end
	
	  always @(posedge clk or negedge reset_n)
		 begin
			if (reset_n == 0)
				 period_register <= RESET_PERIOD;
			else if (period_wr_strobe)
				 period_register <= writedata;
		 end
	
	always @(posedge clk or negedge reset_n)
		 begin
			if (reset_n == 0)
				  compare_register <= RESET_COMPARE;
			else if (compare_wr_strobe)
				 compare_register <= writedata;
		 end
		 
	assign pwm_enabled = control_register;
	
	// read data
	always @(posedge clk or negedge reset_n)
		begin
			  if (reset_n == 0)
					readdata <= 32'h00000000;
			  else
					if (address == 2'h0)
						 readdata <= {{31{1'b0}}, pwm_enabled};
					else if (address == 2'h1)
						 readdata <= period_register;
					else if (address == 2'h2)
						 readdata <= compare_register;
					else
						 readdata <= 32'h00000000;
		end
		 
endmodule
		 