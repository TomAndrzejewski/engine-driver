module sterownik_Ledow(
	input clk,
	input [6:0] rpm,
	input sygnal_zmiany_rpm,
	input rozruch,
	input [8:0] taktowanie_na_stopien,
	output reg [8:1] LED,
	output wire [28:0] licznik_co_tysiac_taktow,
	output wire [28:0] licznik_co_tysiac_taktow_cylinder_2
    );
	
	
	wire [3:0] zliczanie_obrotow;
	wire [3:0] zliczanie_obrotow_cylinder_2;
	
	wire [9:0] stopnie_kiedy_zaswiecic_zawor_ssacy;
	wire [9:0] stopnie_kiedy_zgasic_zawor_ssacy;
	wire [9:0] stopnie_kiedy_zaswiecic_zawor_wydechowy;
	wire [9:0] stopnie_kiedy_zgasic_zawor_wydechowy;
	wire [9:0] stopnie_kiedy_zaswiecic_wtryskiwacz;
	wire [9:0] stopnie_kiedy_zgasic_wtryskiwacz;
	wire [9:0] stopnie_kiedy_zaswiecic_iskre;
	wire [9:0] stopnie_kiedy_zgasic_iskre;
	
	reg [18:0] kiedy_zaswiecic_zawor_wydechowy;
	reg [18:0] kiedy_zgasic_zawor_wydechowy;
	reg [18:0] kiedy_zaswiecic_zawor_ssacy;
	reg [18:0] kiedy_zgasic_zawor_ssacy;
	reg [18:0] kiedy_zaswiecic_wtryskiwacz;
	reg [18:0] kiedy_zgasic_wtryskiwacz;
	reg [18:0] kiedy_zaswiecic_iskre;
	reg [18:0] kiedy_zgasic_iskre;
	
	
	zmienne_fazy_rozrzadu zmienne_fazy_rozrzadu(
		.clk(clk),
		.rpm(rpm),
		.stopnie_zaswiecenie_ssacy(stopnie_kiedy_zaswiecic_zawor_ssacy),
		.stopnie_zgaszenie_ssacy(stopnie_kiedy_zgasic_zawor_ssacy),
		.stopnie_zaswiecenie_wydechowy(stopnie_kiedy_zaswiecic_zawor_wydechowy),
		.stopnie_zgaszenie_wydechowy(stopnie_kiedy_zgasic_zawor_wydechowy),
		.stopnie_zaswiecenie_wtrysk(stopnie_kiedy_zaswiecic_wtryskiwacz),
		.stopnie_zgaszenie_wtrysk(stopnie_kiedy_zgasic_wtryskiwacz),
		.stopnie_zaswiecenie_iskra(stopnie_kiedy_zaswiecic_iskre),
		.stopnie_zgaszenie_iskra(stopnie_kiedy_zgasic_iskre)
	);
	
	odliczanie odliczanie(
		.clk(clk),
		.sygnal_zmiany_rpm(sygnal_zmiany_rpm),
		.rozruch(rozruch),
		.taktowanie_na_stopien(taktowanie_na_stopien),
		.licznik_co_tysiac_taktow(licznik_co_tysiac_taktow),
		.licznik_co_tysiac_taktow_cylinder_2(licznik_co_tysiac_taktow_cylinder_2),
		.zliczanie_obrotow(zliczanie_obrotow),
		.zliczanie_obrotow_cylinder_2(zliczanie_obrotow_cylinder_2)
	);
		
	
	always @(posedge clk) begin
		
		kiedy_zaswiecic_zawor_wydechowy = stopnie_kiedy_zaswiecic_zawor_wydechowy * taktowanie_na_stopien;
		kiedy_zgasic_zawor_wydechowy = stopnie_kiedy_zgasic_zawor_wydechowy * taktowanie_na_stopien;
		kiedy_zaswiecic_zawor_ssacy = stopnie_kiedy_zaswiecic_zawor_ssacy * taktowanie_na_stopien;
		kiedy_zgasic_zawor_ssacy = stopnie_kiedy_zgasic_zawor_ssacy * taktowanie_na_stopien;
		kiedy_zaswiecic_wtryskiwacz = stopnie_kiedy_zaswiecic_wtryskiwacz * taktowanie_na_stopien;
		kiedy_zgasic_wtryskiwacz = stopnie_kiedy_zgasic_wtryskiwacz * taktowanie_na_stopien;
		kiedy_zaswiecic_iskre = stopnie_kiedy_zaswiecic_iskre * taktowanie_na_stopien;
		kiedy_zgasic_iskre = stopnie_kiedy_zgasic_iskre * taktowanie_na_stopien;
		
		if (taktowanie_na_stopien != 'b111111111) begin
		
			if (licznik_co_tysiac_taktow >= kiedy_zaswiecic_zawor_ssacy && licznik_co_tysiac_taktow <= kiedy_zgasic_zawor_ssacy) begin
				LED[8] <= 1;
			end
			else begin
				LED[8] <= 0;
			end
	
			if (licznik_co_tysiac_taktow < kiedy_zaswiecic_zawor_wydechowy && zliczanie_obrotow != 0 && licznik_co_tysiac_taktow != 0) begin
				if (licznik_co_tysiac_taktow < kiedy_zgasic_zawor_wydechowy)
					LED[7] <= 1;
				if (licznik_co_tysiac_taktow >= kiedy_zgasic_zawor_wydechowy)
					LED[7] <= 0;	
			end
			if (licznik_co_tysiac_taktow >= kiedy_zaswiecic_zawor_wydechowy + 100) begin
				LED[7] <= 1;	
			end
			if (sygnal_zmiany_rpm == 1) begin
				LED[7] <= 0;
			end

			if (licznik_co_tysiac_taktow >= kiedy_zaswiecic_wtryskiwacz && licznik_co_tysiac_taktow <= kiedy_zgasic_wtryskiwacz) begin
				LED[6] <= 1;
			end
			else begin
				LED[6] <= 0;
			end

			if (licznik_co_tysiac_taktow >= kiedy_zaswiecic_iskre && licznik_co_tysiac_taktow <= kiedy_zgasic_iskre) begin
				LED[5] <= 1;
			end
			else begin
				LED[5] <= 0;
			end

			if (licznik_co_tysiac_taktow_cylinder_2 >= kiedy_zaswiecic_zawor_ssacy && licznik_co_tysiac_taktow_cylinder_2 <= kiedy_zgasic_zawor_ssacy) begin
				LED[4] <= 1;
			end
			else begin
				LED[4] <= 0;
			end

			if (licznik_co_tysiac_taktow_cylinder_2 < kiedy_zaswiecic_zawor_wydechowy && zliczanie_obrotow != 0 && licznik_co_tysiac_taktow_cylinder_2 != 0) begin
				if (licznik_co_tysiac_taktow_cylinder_2 < kiedy_zgasic_zawor_wydechowy)
					LED[3] <= 1;
				if (licznik_co_tysiac_taktow_cylinder_2 >= kiedy_zgasic_zawor_wydechowy)
					LED[3] <= 0;	
			end
			if (licznik_co_tysiac_taktow_cylinder_2 >= kiedy_zaswiecic_zawor_wydechowy + 100) begin
				LED[3] <= 1;	
			end
			if (sygnal_zmiany_rpm == 1) begin
				LED[3] <= 0;
			end

			if (licznik_co_tysiac_taktow_cylinder_2 >= kiedy_zaswiecic_wtryskiwacz && licznik_co_tysiac_taktow_cylinder_2 <= kiedy_zgasic_wtryskiwacz) begin
				LED[2] <= 1;
			end
			else begin
				LED[2] <= 0;
			end

			if (licznik_co_tysiac_taktow_cylinder_2 >= kiedy_zaswiecic_iskre && licznik_co_tysiac_taktow_cylinder_2 <= kiedy_zgasic_iskre) begin
				LED[1] <= 1;
			end
			else begin
				LED[1] <= 0;
			end
		end
		else begin
			LED <= 0;
		end
	end
endmodule

