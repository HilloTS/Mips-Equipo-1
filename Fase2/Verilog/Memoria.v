module Memoria(
	input Wen,//Senial para escribir
	input [31:0]Adress,//La direccion de la memoria
	input [31:0]DataW,//Escribir un valor nuevo en la memoria 
	input Ren,//Senial para leer
	output reg [31:0]DataR,//Valor para leer
	output reg [31:0]Adresvalor
);

reg [31:0] RAM[0:255];
initial
begin
	RAM[1]=32'd20;
	RAM[2]=32'd45;
	RAM[3]=32'd0;
	RAM[4]=32'd7;
	RAM[5]=32'd4;
	RAM[6]=32'd3;
	RAM[7]=32'd2;
	RAM[8]=32'd0;
	RAM[9]=32'd0;
	RAM[10]=32'd0;
	RAM[11]=32'd0;
	RAM[12]=32'd0;
	RAM[13]=32'd0;
	RAM[14]=32'd0;
	RAM[15]=32'd0;
	RAM[16]=32'd123;
	RAM[17]=32'd0;
	RAM[18]=32'd0;
	//$readmemb("Mem_Datosreg.txt",RAM);
end
always@*
begin
	if(Wen)
	begin
		RAM[Adress]<=DataW;
	end
	else if(Ren)
	begin
		DataR<=RAM[Adress];
	end
	else if(Wen&Ren)
	begin
		DataR<=32'b0;
	end
end
assign Adresvalor = Adress;
endmodule

