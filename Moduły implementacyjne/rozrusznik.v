module rozrusznik(
	input clk,
	input switch_2,
	input switch_6,
	input [31:0] taktowanie,
	output reg rozruch
    );
	
	wire sygnal_switcha_rozruchu;
	wire sygnal_switcha_obrotow;
	
	reg [31:0] licznik = 0;
	reg [31:0] licznik_startu = 0;
	reg sygnal_rozruchu = 0;
	reg automatyczne_zatrzymanie_rozruchu = 0;
	
	
	assign sygnal_switcha_rozruchu = switch_2;
	assign sygnal_switcha_obrotow = switch_6;
	

	always @(posedge clk) begin
		licznik_startu = licznik_startu + 1;
		if (licznik_startu == taktowanie) begin
			licznik_startu = 0;
		end
		if (licznik_startu >= 100) begin
			if (automatyczne_zatrzymanie_rozruchu == 0) begin
				if (sygnal_switcha_rozruchu == 0) begin
					if (licznik != taktowanie && sygnal_switcha_obrotow == 1) begin
						licznik <= licznik + 1;
					end
					else if (licznik == taktowanie && sygnal_switcha_obrotow == 1) begin
						licznik <= 0;
						automatyczne_zatrzymanie_rozruchu <= 1;
					end
					else if (sygnal_switcha_obrotow == 0) begin
						sygnal_rozruchu = 1;
						automatyczne_zatrzymanie_rozruchu <= 1;
					end
				end
				else if (sygnal_switcha_rozruchu == 1) begin
						licznik <= 0;
						sygnal_rozruchu = 0;
				end
			end
			rozruch = sygnal_rozruchu;
		end
	end
endmodule
