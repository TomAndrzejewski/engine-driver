module test_zmienne_fazy_rozrzadu;

	// Inputs
	reg clk;
	reg [6:0] rpm;
	real i = 0;

	// Outputs
	wire [9:0] stopnie_zaswiecenie_ssacy;
	wire [9:0] stopnie_zgaszenie_ssacy;
	wire [9:0] stopnie_zaswiecenie_wydechowy;
	wire [9:0] stopnie_zgaszenie_wydechowy;
	wire [9:0] stopnie_zaswiecenie_wtrysk;
	wire [9:0] stopnie_zgaszenie_wtrysk;
	wire [9:0] stopnie_zaswiecenie_iskra;
	wire [9:0] stopnie_zgaszenie_iskra;

	// Instantiate the Unit Under Test (UUT)
	zmienne_fazy_rozrzadu uut (
		.clk(clk), 
		.rpm(rpm), 
		.stopnie_zaswiecenie_ssacy(stopnie_zaswiecenie_ssacy), 
		.stopnie_zgaszenie_ssacy(stopnie_zgaszenie_ssacy), 
		.stopnie_zaswiecenie_wydechowy(stopnie_zaswiecenie_wydechowy), 
		.stopnie_zgaszenie_wydechowy(stopnie_zgaszenie_wydechowy), 
		.stopnie_zaswiecenie_wtrysk(stopnie_zaswiecenie_wtrysk), 
		.stopnie_zgaszenie_wtrysk(stopnie_zgaszenie_wtrysk), 
		.stopnie_zaswiecenie_iskra(stopnie_zaswiecenie_iskra), 
		.stopnie_zgaszenie_iskra(stopnie_zgaszenie_iskra)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		rpm = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while (i < 100000) begin
			if (i == 10000)
				rpm = 45;
			if (i == 20000)
				rpm = 50;
			if (i == 30000)
				rpm = 45;
			#1;
			i = i + 0.5;
			clk = ~clk;
		end
	end
endmodule

