module wyswietlanie_rpm_na_wyswietlaczach(
	input clk,
	input [6:0] rpm,
	output reg [7:0] seven_segmented_display,
	output reg [2:0] zalaczony_wyswietlacz
    );
	
	wire [7:0] rpm_w_BCD;
	
	reg [2:0] aktywny_wyswietlacz = 'b111;
	
	integer licznik = 0;
	
	zwracanie_digitow zwracanie_digitow(
		.clk(clk), 
		.rpm(rpm), 
		.rpm_w_BCD(rpm_w_BCD)
	);
	
	always @(posedge clk) begin
		if (licznik == 100000 && aktywny_wyswietlacz == 'b110) begin
			aktywny_wyswietlacz <= 'b101;
			licznik <= 0;
		end
		else if (licznik == 100000 && aktywny_wyswietlacz == 'b101) begin
			aktywny_wyswietlacz <= 'b110;
			licznik <= 0;
		end
		else if (licznik == 100000 && aktywny_wyswietlacz == 'b111) begin
			aktywny_wyswietlacz <= 'b110;
			licznik <= 0;
		end
		else if (licznik != 100000) begin
			licznik <= licznik + 1;
		end
		if (aktywny_wyswietlacz == 'b110) begin
			case (rpm_w_BCD[3:0])
				'b0000 : seven_segmented_display[7:0] <= 'b00000011;
				'b0001 : seven_segmented_display[7:0] <= 'b10011111;
				'b0010 : seven_segmented_display[7:0] <= 'b00100101;
				'b0011 : seven_segmented_display[7:0] <= 'b00001101;
				'b0100 : seven_segmented_display[7:0] <= 'b10011001;
				'b0101 : seven_segmented_display[7:0] <= 'b01001001;
				'b0110 : seven_segmented_display[7:0] <= 'b01000001;
				'b0111 : seven_segmented_display[7:0] <= 'b00011111;
				'b1000 : seven_segmented_display[7:0] <= 'b00000001;
				'b1001 : seven_segmented_display[7:0] <= 'b00001001;
				default : seven_segmented_display[7:0] <= 'b11111111;
			endcase
		end
		else if (aktywny_wyswietlacz == 'b101) begin
			case (rpm_w_BCD[7:4])
				'b0000 : seven_segmented_display[7:0] <= 'b00000011;
				'b0001 : seven_segmented_display[7:0] <= 'b10011111;
				'b0010 : seven_segmented_display[7:0] <= 'b00100101;
				'b0011 : seven_segmented_display[7:0] <= 'b00001101;
				'b0100 : seven_segmented_display[7:0] <= 'b10011001;
				'b0101 : seven_segmented_display[7:0] <= 'b01001001;
				'b0110 : seven_segmented_display[7:0] <= 'b01000001;
				'b0111 : seven_segmented_display[7:0] <= 'b00011111;
				'b1000 : seven_segmented_display[7:0] <= 'b00000001;
				'b1001 : seven_segmented_display[7:0] <= 'b00001001;
				default : seven_segmented_display[7:0] <= 'b11111111;
			endcase
		end
		zalaczony_wyswietlacz <= aktywny_wyswietlacz;
	end
endmodule
