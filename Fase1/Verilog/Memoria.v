`timescale 1ns/1ns
module Memoria(
	input Wen,//Senial para escribir
	input [31:0]Adress,//La direccion de la memoria
	input [31:0]DataW,//Escribir un valor nuevo en la memoria 
	input Ren,//Senial para leer
	output reg [31:0]DataR//Valor para leer
);

reg [31:0] ROM[0:255];

always@*
begin
	if(Wen)
		ROM[Adress]=DataW;
	if(Ren)
		DataR=ROM[Adress];
	if(Wen&Ren)
		DataR=0;
end
endmodule

