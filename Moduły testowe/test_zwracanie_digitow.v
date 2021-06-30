module test_zwracanie_digitow;

	// Inputs
	reg clk = 1;
	reg [6:0] rpm;

	// Outputs
	wire [7:0] rpm_w_BCD;
	
	real i = 0;
	;
	// Instantiate the Unit Under Test (UUT)
	zwracanie_digitow uut (
		.clk(clk),
		.rpm(rpm), 
		.rpm_w_BCD(rpm_w_BCD)
	);

	initial begin
		// Initialize Inputs
		rpm = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while (i < 100000) begin
			#1;
			if (i == 1)
				rpm = 22;
			if (i == 10000)
				rpm = 95;
			clk = ~clk;
			i = i + 0.5;
		end

	end
      
endmodule

