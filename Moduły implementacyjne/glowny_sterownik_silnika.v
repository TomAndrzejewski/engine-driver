module glowny_sterownik_silnika(
	input clk,
	input wire switch_2,
	input wire switch_6,
	input wire switch_5,
	output wire [8:1] LED,
	output wire [7:0] seven_segmented_display,
	output wire [2:0] zalaczony_wyswietlacz,
	output wire sygnal_zmiany_rpm,
	output wire rozruch
    );
	
	parameter taktowanie = 12000000;
	
	wire [6:0] wy_rpm;
	wire [8:0] taktowanie_na_stopien;
	
	reg [6:0] rpm;
	reg [6:0] we_rpm;
	reg start = 0;
	

	
	rozrusznik rozrusznik(
		.clk(clk), 
		.switch_6(switch_6),
		.taktowanie(taktowanie),
		.switch_2(switch_2),
		.rozruch(rozruch)
	);
	
	zmiana_rpm zmiana_rpm(
		.switch_5(switch_5),
		.switch_6(switch_6),
		.clk(clk), 
		.we_rpm(we_rpm), 
		.rpm(wy_rpm), 
		.sygnal_zmiany_rpm(sygnal_zmiany_rpm)
	);

	obliczanie_taktowania_na_stopien oblicz_taktowanie_na_stopien(
		.clk(clk), 
		.rpm(rpm), 
		.taktowanie_na_stopien(taktowanie_na_stopien)
	);
	
	wyswietlanie_rpm_na_wyswietlaczach wyswietlanie_rpm(
		.clk(clk), 
		.rpm(rpm), 
		.seven_segmented_display(seven_segmented_display), 
		.zalaczony_wyswietlacz(zalaczony_wyswietlacz)
	);
	
	sterownik_Ledow sterownik_Ledow(
		.clk(clk), 
		.rpm(rpm), 
		.sygnal_zmiany_rpm(sygnal_zmiany_rpm), 
		.rozruch(rozruch), 
		.taktowanie_na_stopien(taktowanie_na_stopien), 
		.LED(LED)
	);
	
	always @(posedge clk) begin
	
		if (sygnal_zmiany_rpm == 1) begin
			rpm = wy_rpm;
		end
		
		if (sygnal_zmiany_rpm == 0 && start == 1) begin
			we_rpm = rpm;
		end
		
		if (rozruch == 1)
			start = 1;
		
		if (start == 0) begin
			rpm = 0;
			we_rpm = 0;
		end
	end
endmodule
