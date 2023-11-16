`timescale 1ns/1ns
module Adder(
    input [31:0] suma,
    input [31:0] numprimero,
    output reg [31:0] fuera
);

assign fuera = numprimero + suma;

endmodule