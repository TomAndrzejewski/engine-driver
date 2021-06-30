module test_obliczanie_taktowania_na_stopien;

	// Inputs
	reg clk = 1;
	reg [6:0] rpm;
	real i = 0;

	// Outputs
	wire [8:0] taktowanie_na_stopien;

	// Instantiate the Unit Under Test (UUT)
	obliczanie_taktowania_na_stopien uut (
		.clk(clk), 
		.rpm(rpm), 
		.taktowanie_na_stopien(taktowanie_na_stopien)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rpm = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		while (i < 100000) begin
			#1;
			if (i == 1000)
				rpm = 5;
			clk = ~clk;
			i = i + 0.5;
		end
	end
      
endmodule

