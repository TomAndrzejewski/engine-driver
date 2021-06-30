module zmienne_fazy_rozrzadu(
	input clk,
	input [6:0] rpm,
	output reg [9:0] stopnie_zaswiecenie_ssacy,
	output reg [9:0] stopnie_zgaszenie_ssacy,
	output reg [9:0] stopnie_zaswiecenie_wydechowy,
	output reg [9:0] stopnie_zgaszenie_wydechowy,
	output reg [9:0] stopnie_zaswiecenie_wtrysk,
	output reg [9:0] stopnie_zgaszenie_wtrysk,
	output reg [9:0] stopnie_zaswiecenie_iskra,
	output reg [9:0] stopnie_zgaszenie_iskra
    );

	always @(posedge clk) begin
		if (rpm < 50) begin
			stopnie_zaswiecenie_ssacy <= 160;
			stopnie_zgaszenie_ssacy <= 406;
			stopnie_zaswiecenie_wydechowy <= 674;
			stopnie_zgaszenie_wydechowy <= 190;
			stopnie_zaswiecenie_wtrysk <= 170;
			stopnie_zgaszenie_wtrysk <= 250;
			stopnie_zaswiecenie_iskra <= 525;
			stopnie_zgaszenie_iskra <= 545;
		end
		if (rpm >= 50) begin
			stopnie_zaswiecenie_ssacy <= 140;
			stopnie_zgaszenie_ssacy <= 426;
			stopnie_zaswiecenie_wydechowy <= 654;
			stopnie_zgaszenie_wydechowy <= 170;
			stopnie_zaswiecenie_wtrysk <= 150;
			stopnie_zgaszenie_wtrysk <= 250;
			stopnie_zaswiecenie_iskra <= 515;
			stopnie_zgaszenie_iskra <= 555;
		end
	end
endmodule
