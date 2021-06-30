module test_odliczanie;

	// Inputs
	reg clk;
	reg sygnal_zmiany_rpm;
	reg rozruch;
	reg [8:0] taktowanie_na_stopien;
	real i = 0;
	
	// Outputs
	wire [28:0] licznik_co_tysiac_taktow;
	wire [28:0] licznik_co_tysiac_taktow_cylinder_2;
	wire [3:0] zliczanie_obrotow;
	wire [3:0] zliczanie_obrotow_cylinder_2;

	// Instantiate the Unit Under Test (UUT)
	odliczanie uut (
		.clk(clk), 
		.sygnal_zmiany_rpm(sygnal_zmiany_rpm), 
		.rozruch(rozruch), 
		.taktowanie_na_stopien(taktowanie_na_stopien), 
		.licznik_co_tysiac_taktow(licznik_co_tysiac_taktow), 
		.licznik_co_tysiac_taktow_cylinder_2(licznik_co_tysiac_taktow_cylinder_2), 
		.zliczanie_obrotow(zliczanie_obrotow), 
		.zliczanie_obrotow_cylinder_2(zliczanie_obrotow_cylinder_2)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		sygnal_zmiany_rpm = 0;
		rozruch = 0;
		taktowanie_na_stopien = 4;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while (i < 10000000) begin
			if (i == 1)
				rozruch = 1;
			#1;
			clk = ~clk;
			i = i + 0.5;
		end
	end
      
endmodule

