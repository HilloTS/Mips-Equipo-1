`timescale 1ns/1ns

module proyecto_tb();
reg clk_tb = 1'b0;
wire [31:0]prueba1_tb;
wire [31:0]prueba2_tb;
wire [31:0]prueba3_tb;


always #50 clk_tb = ~clk_tb;

proyect uno(
    .reloj(clk_tb),
    .prueba1(prueba1_tb),
    .prueba2(prueba2_tb),
    .prueba3(prueba3_tb)
);

endmodule

