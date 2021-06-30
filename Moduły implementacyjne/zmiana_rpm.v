module zmiana_rpm(
	input switch_5,
	input switch_6,
	input clk,
	input [6:0] we_rpm,
	output reg [6:0] rpm,
	output wire sygnal_zmiany_rpm
    );
	
	wire sygnal_dodania_5_rpm;
	

	reg [16:0] licznik = 0;
	reg [6:0] wyjsciowe_rpm;
	reg sygnal_wyzerowania_licznika;
	reg czy_nastapila_zmiana_rpm = 0;
	
	
	assign sygnal_odjecia_5_rpm = switch_5;
	assign sygnal_dodania_5_rpm = switch_6;
	assign sygnal_zmiany_rpm = sygnal_wyzerowania_licznika;
	
	
	always @(posedge clk) begin
		if (sygnal_dodania_5_rpm == 1 && sygnal_odjecia_5_rpm == 1 && czy_nastapila_zmiana_rpm == 0) begin
			sygnal_wyzerowania_licznika <= 0;
			wyjsciowe_rpm = we_rpm;
			if (licznik != 100000)
				licznik <= licznik + 1;
		end
		if ((sygnal_dodania_5_rpm == 0 && czy_nastapila_zmiana_rpm == 1) || (sygnal_odjecia_5_rpm == 0 && czy_nastapila_zmiana_rpm == 1)) begin
			sygnal_wyzerowania_licznika <= 0;
		end
		else if ((sygnal_dodania_5_rpm == 1 && czy_nastapila_zmiana_rpm == 1) || (sygnal_odjecia_5_rpm == 1 && czy_nastapila_zmiana_rpm == 1)) begin
			sygnal_wyzerowania_licznika <= 0;
			czy_nastapila_zmiana_rpm <= 0;
		end
		else if (sygnal_dodania_5_rpm == 0 && czy_nastapila_zmiana_rpm == 0 && licznik == 100000 && we_rpm <= 90) begin
			wyjsciowe_rpm = we_rpm + 5;
			czy_nastapila_zmiana_rpm <= 1;
			sygnal_wyzerowania_licznika <= 1;
			licznik <= 0;
		end
		else if (sygnal_odjecia_5_rpm == 0 && czy_nastapila_zmiana_rpm == 0 && licznik == 100000 && we_rpm >= 10) begin
			wyjsciowe_rpm = we_rpm - 5;
			czy_nastapila_zmiana_rpm <= 1;
			sygnal_wyzerowania_licznika <= 1;
			licznik <= 0;
		end
		rpm = wyjsciowe_rpm;
	end
endmodule
