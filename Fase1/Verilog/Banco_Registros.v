module bank(
	input [4:0]AR1,
	input [4:0]AR2,
	input [4:0]AW,
	input [31:0]Datow,
	input Wen,
	output reg [31:0]Dato1,
	output reg [31:0]Dato2
);

reg [31:0] ROM[0:31];
initial 
begin 
	ROM[5] = 32'd10;
	ROM[6] = 32'd15;
	ROM[7] = 32'd20;
	ROM[8] = 32'd25;
	ROM[9] = 32'd30;
	ROM[10] = 32'd35;
	ROM[11] = 32'd40;
	ROM[12] = 32'd45;
	ROM[13] = 32'd50;
	ROM[14] = 32'd55;
	ROM[15] = 32'd60;
	ROM[16] = 32'd65;
	ROM[17] = 32'd70;
	ROM[18] = 32'd75;
	ROM[19] = 32'd80;
	ROM[20] = 32'd85;
	ROM[21] = 32'd90;
	ROM[22] = 32'd95;
	ROM[23] = 32'd100;
	ROM[24] = 32'd105;
	ROM[25] = 32'd110;
end

always @* 
begin
	if(Wen)
		ROM[AW] = Datow;
		
Dato1 = ROM[AR1];
Dato2 = ROM[AR2];
	
end 

endmodule

