`timescale 1ns/1ns
module ControlUnit (
    input [5:0] instruction,
    output reg RegDst,
    output reg Branch,
    output reg MemtoRead,
    output reg MemToReg,
    output reg [1:0]ALUop,
    output reg MemtoWrite,
    output reg ALUSrc,
    output reg RegWrite
 
);
always @(instruction) begin
    if (instruction == 6'b000_000) 
    begin
        //instruccion tipo R, debemos de darles estos valores a estas variables si la instruccion es de tipo R
        RegDst <=1;
        Branch <=0;
        MemtoRead <= 0;
        MemToReg <= 0;
        ALUop <= 10;
        MemtoWrite <= 0;
        ALUSrc <=0;
        RegWrite <= 1;
    end
end
endmodule //ControlUnit

