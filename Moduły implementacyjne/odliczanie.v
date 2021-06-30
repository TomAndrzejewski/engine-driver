module odliczanie(
	input clk,
	input sygnal_zmiany_rpm,
	input rozruch,
	input [8:0] taktowanie_na_stopien,
	output reg [28:0] licznik_co_tysiac_taktow,
	output reg [28:0] licznik_co_tysiac_taktow_cylinder_2,
	output reg [3:0] zliczanie_obrotow,
	output reg [3:0] zliczanie_obrotow_cylinder_2
    );
	
	reg [31:0] taktowanie_na_720_stopni;
	reg [9:0] licznik_do_tysiaca = 0;
	reg [9:0] licznik_do_tysiaca_cylinder_2 = 0;

	reg start_cylindra_2 = 0;
	reg start = 0;
	

	always @(posedge clk) begin
	
		taktowanie_na_720_stopni <= taktowanie_na_stopien * 720;
		
		if (zliczanie_obrotow == 2)
			zliczanie_obrotow <= 1;
			
		if (zliczanie_obrotow_cylinder_2 == 2)
			zliczanie_obrotow_cylinder_2 <= 1;
			
		if (sygnal_zmiany_rpm == 1) begin
			licznik_do_tysiaca <= 0;
			licznik_co_tysiac_taktow <= 0;
			licznik_do_tysiaca_cylinder_2 <= 0;
			licznik_co_tysiac_taktow_cylinder_2 <= 0;
			zliczanie_obrotow <= 0;
			zliczanie_obrotow_cylinder_2 <= 0;
			start_cylindra_2 <= 0;
		end
	
		if (licznik_co_tysiac_taktow == taktowanie_na_720_stopni/2)
			start_cylindra_2 <= 1;	
		
		if (rozruch == 1)
			start <= 1;
			
		if (start == 0) begin
			zliczanie_obrotow <= 0;
			zliczanie_obrotow_cylinder_2 <= 0;
			licznik_co_tysiac_taktow <= 0;
			licznik_co_tysiac_taktow_cylinder_2 <= 0;
		end
		
		if (licznik_co_tysiac_taktow != taktowanie_na_720_stopni && start == 1 && licznik_do_tysiaca != 1000) begin
			licznik_do_tysiaca <= licznik_do_tysiaca + 1;
		end 
		if (licznik_co_tysiac_taktow != taktowanie_na_720_stopni && start == 1 && licznik_do_tysiaca == 1000) begin
			licznik_do_tysiaca <= 0;
			licznik_co_tysiac_taktow <= licznik_co_tysiac_taktow + 1;
		end
		if (licznik_co_tysiac_taktow == taktowanie_na_720_stopni) begin
			licznik_do_tysiaca <= 0;
			licznik_co_tysiac_taktow <= 0;
			zliczanie_obrotow <= zliczanie_obrotow + 1;
		end
		
		if (licznik_co_tysiac_taktow_cylinder_2 != taktowanie_na_720_stopni && start == 1 && licznik_do_tysiaca_cylinder_2 != 1000 && start_cylindra_2 == 1) begin
			licznik_do_tysiaca_cylinder_2 <= licznik_do_tysiaca_cylinder_2 + 1;
		end 
		
		if (licznik_co_tysiac_taktow_cylinder_2 != taktowanie_na_720_stopni && start == 1 && licznik_do_tysiaca_cylinder_2 == 1000 && start_cylindra_2 == 1) begin
			licznik_do_tysiaca_cylinder_2 <= 0;
			licznik_co_tysiac_taktow_cylinder_2 <= licznik_co_tysiac_taktow_cylinder_2 + 1;
		end
		
		if (licznik_co_tysiac_taktow_cylinder_2 == taktowanie_na_720_stopni && start_cylindra_2 == 1) begin
			licznik_do_tysiaca_cylinder_2 <= 0;
			licznik_co_tysiac_taktow_cylinder_2 <= 0;
			zliczanie_obrotow_cylinder_2 <= zliczanie_obrotow_cylinder_2 + 1;
		end
	end
endmodule
