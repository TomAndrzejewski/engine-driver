module test_glowny_sterownik_silnika;

	//ABY ZASYMULOWAC TEN MODUL, NALEZY ZMNIEJSZYC WARTOSCI W MODULE OBLICZANIE_TAKTOWANIA_NA_STOPIEN DLA RPM = 5:20 DO JEDNOCYFROWYCH.
	//MOZNA SYMULOWAC BEZ, ALE WTEDY CZAS SYMULACJI MUSI BYC OGROMNY.
	// Inputs
	reg clk;
	reg switch_2;
	reg switch_6;
	reg switch_5;
	real i = 0;

	// Outputs
	wire [8:1] LED;
	wire [7:0] seven_segmented_display;
	wire [2:0] zalaczony_wyswietlacz;
	wire sygnal_zmiany_rpm;
	wire rozruch;

	// Instantiate the Unit Under Test (UUT)
	glowny_sterownik_silnika uut (
		.clk(clk), 
		.switch_2(switch_2), 
		.switch_6(switch_6), 
		.switch_5(switch_5), 
		.LED(LED), 
		.seven_segmented_display(seven_segmented_display), 
		.zalaczony_wyswietlacz(zalaczony_wyswietlacz),
		.sygnal_zmiany_rpm(sygnal_zmiany_rpm),
		.rozruch(rozruch)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		switch_2 = 1;
		switch_6 = 1;
		switch_5 = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while (i < 100000000) begin
			if (i == 1000000)
				switch_2 = 0;
			if (i == 1000010)
				switch_6 = 0;
			if (i == 1001010) begin
				switch_2 = 1;
				switch_6 = 1;
			end
			/*if (i == 2000000)
				switch_6 = 0;
			if (i == 2001000)
				switch_6 = 1;
			if (i == 2003000)
				switch_6 = 0;
			if (i == 2003500)
				switch_6 = 1;
			if (i == 4000000)
				switch_6 = 0;
			if (i == 4000999)
				switch_6 = 1;*/
			#1;
			clk = ~clk;
			i = i + 0.5;
		end
	end
      
endmodule

