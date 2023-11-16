`timescale 1ns/1ns

module proyecto_tb();
reg clk_tb = 1'b0;

always #50 clk_tb = ~clk_tb;

proyect uno(
    .reloj(clk_tb)
);

endmodule

