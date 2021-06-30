module test_wyswietlanie_rpm_na_wyswietlaczach;

	// Inputs
	reg clk = 1;
	reg [6:0] rpm;
	real i = 0;

	// Outputs
	wire [7:0] seven_segmented_display;
	wire [1:0] zalaczony_wyswietlacz;

	// Instantiate the Unit Under Test (UUT)
	wyswietlanie_rpm_na_wyswietlaczach uut (
		.clk(clk), 
		.rpm(rpm), 
		.seven_segmented_display(seven_segmented_display),
		.zalaczony_wyswietlacz(zalaczony_wyswietlacz)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rpm = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while (i < 1000000) begin
		#1;
		if (i == 20000)
			rpm = 65;
			clk = ~clk;
			i = i + 0.5;
		end

	end
      
endmodule

