module zwracanie_digitow(
	input clk,
	input [6:0] rpm,
	output reg [7:0] rpm_w_BCD
    );
	 
	reg [6:0] wejsciowe_rpm;
	reg [6:0] dziesiatki = 0;
	reg [3:0] wynik_dla_jednosci;
	reg [3:0] wynik_dla_dziesiatek;
	reg [24:0] clock = 0;
	
	integer i = 10;
	
	
	always @(posedge clk) begin
		if(clock == 10000) begin
			rpm_w_BCD[7:4] <= wynik_dla_dziesiatek;
			rpm_w_BCD[3:0] <= wynik_dla_jednosci;
			clock <= 0;
		end
		else if (clock != 10000) begin
			clock <= clock + 1;
		end
		wejsciowe_rpm = rpm;
		if (rpm < i && clock >= 5000) begin
			wynik_dla_jednosci <= rpm + 10 - i;
			wynik_dla_dziesiatek <= dziesiatki;
			dziesiatki <= 0;
			i <= 10;
		end
		else if (rpm == i && clock >= 5000) begin
			wynik_dla_jednosci <= rpm - i;
			wynik_dla_dziesiatek <= dziesiatki + 1;
			dziesiatki <= 0;
			i <= 10;
		end
		else if (rpm > i && clock >= 5000) begin
			dziesiatki <= dziesiatki + 1;
			i <= i + 10;
		end
	end
endmodule
