module test_sterownik_Ledow;

	// Inputs
	reg clk;
	reg [6:0] rpm;
	reg sygnal_zmiany_rpm;
	reg rozruch;
	reg [8:0] taktowanie_na_stopien;
	real i = 0;
	
	// Outputs
	wire [8:1] LED;

	// Instantiate the Unit Under Test (UUT)
	sterownik_Ledow uut (
		.clk(clk), 
		.rpm(rpm), 
		.sygnal_zmiany_rpm(sygnal_zmiany_rpm), 
		.rozruch(rozruch), 
		.taktowanie_na_stopien(taktowanie_na_stopien), 
		.LED(LED)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		rpm = 5;
		sygnal_zmiany_rpm = 0;
		rozruch = 0;
		taktowanie_na_stopien = 4;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while (i < 100000000) begin
			if (i == 1)
				rozruch = 1;
			#1;
			i = i + 0.5;
			clk = ~clk;
		end
	end
      
endmodule

