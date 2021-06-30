module test_zmiana_rpm;

	//TEN MODUL DZIALA TYLKO GDY JEST ON PODMODULEM MODULU GLOWNY_STEROWNIK_SILNIKA. BEZ NIEGO WARTOSC RPM PO KILKU TAKTACH WRACA ZAWSZE DO 0, A MODUL STEROWNIKA ZAPOBIEGA TEMU.
	// Inputs
	reg switch_5;
	reg switch_6;
	reg clk;
	reg [6:0] we_rpm;
	real i = 0;

	// Outputs
	wire [6:0] rpm;
	wire sygnal_zmiany_rpm;

	// Instantiate the Unit Under Test (UUT)
	zmiana_rpm uut (
		.switch_5(switch_5), 
		.switch_6(switch_6), 
		.clk(clk), 
		.we_rpm(we_rpm), 
		.rpm(rpm), 
		.sygnal_zmiany_rpm(sygnal_zmiany_rpm)
	);

	initial begin
		// Initialize Inputs
		switch_5 = 1;
		switch_6 = 1;
		clk = 1;
		we_rpm = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		while (i < 100000000) begin
			#1;
			if (i == 10000000)
				switch_6 = 0;
			if (i == 10000005)
				switch_6 = 1;
			/*if (i == 20000000)
				switch_6 = 0;
			if (i == 20000005)
				switch_6 = 1;
			if (i == 30000000)
				switch_5 = 0;
			if (i == 30000005)
				switch_5 = 1;*/
			i = i + 0.5;
			clk = ~clk;
		end

	end
      
endmodule

