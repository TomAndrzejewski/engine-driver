module obliczanie_taktowania_na_stopien(
	input clk,
	input [6:0] rpm,
	output reg [8:0] taktowanie_na_stopien
    );
	 
	always @(posedge clk) begin
			case (rpm)
				5 : taktowanie_na_stopien <= 400;
				10 : taktowanie_na_stopien <= 200;
				15 : taktowanie_na_stopien <= 133;
				20 : taktowanie_na_stopien <= 100;
				25 : taktowanie_na_stopien <= 80;
				30 : taktowanie_na_stopien <= 66;
				35 : taktowanie_na_stopien <= 57;
				40 : taktowanie_na_stopien <= 50;
				45 : taktowanie_na_stopien <= 44;
				50 : taktowanie_na_stopien <= 40;
				55 : taktowanie_na_stopien <= 36;
				60 : taktowanie_na_stopien <= 33;
				65 : taktowanie_na_stopien <= 30;
				70 : taktowanie_na_stopien <= 28;
				75 : taktowanie_na_stopien <= 26;
				80 : taktowanie_na_stopien <= 25;
				85 : taktowanie_na_stopien <= 23;
				90 : taktowanie_na_stopien <= 22;
				95 : taktowanie_na_stopien <= 21;
				default: taktowanie_na_stopien <= 'b111111111;
			endcase
		end
endmodule

