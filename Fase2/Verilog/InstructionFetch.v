`timescale 1ns/1ns
module instructionFetch(
    input clk,
    input [31:0]instructionmem,
    input [31:0]pcAdder,
    output reg [31:0]instruccionfetch,
    output reg [31:0]pcAdderFetch
);

initial begin
    instruccionfetch=0;
    pcAdderFetch=0;
end

always @(posedge clk)begin
    pcAdderFetch <= pcAdder;
    instruccionfetch <= instructionmem;
end

endmodule
