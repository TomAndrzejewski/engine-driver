module test_rozrusznik;

	// Inputs
	reg switch_2;
	reg switch_6;
	reg [31:0] taktowanie;
	reg clk;
	real i = 0;

	// Outputs
	wire rozruch;

	// Instantiate the Unit Under Test (UUT)
	rozrusznik uut (
		.switch_2(switch_2), 
		.switch_6(switch_6), 
		.taktowanie(taktowanie), 
		.clk(clk), 
		.rozruch(rozruch)
	);

	initial begin
		// Initialize Inputs
		switch_2 = 1;
		switch_6 = 1;
		taktowanie = 12000;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while (i < 1000000) begin
			#1;
			switch_2 = 0;
			if (i == 10000) begin
				switch_6 = 0;
			end
			clk = ~clk;
			i = i + 0.5;
		end
	end
      
endmodule

