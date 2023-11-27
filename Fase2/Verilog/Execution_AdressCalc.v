module Execution_AdressCalc(
    input clk,
    input [31:0]pcAdder,//Me lo da el buffer anterior el ID
    input zeroflag,//Bandera de la ALU
    input [31:0]Alu_result,//Resultado de la ALU
    input [31:0]DataWrite,//Viene del banco de registros
    input [4:0]muxRegFileD,
    /*Todo esto lo agarramos de la Unidad de Control*/
    input branch,
    input memtoWrite,
    input memtoRead,
    input regWrite,
    input memtoReg,
    /*Salidas*/
    output reg [31:0]outpcAdder,
    output reg outzeroflag,
    output reg [31:0]outAlu_Result,
    output reg [31:0]outDataWrite,
    output reg [4:0]outmuxRegFileD,
    /*Unidad de control*/
    output reg outBranch,
    output reg outmemtoWrite,
    output reg outmemtoRead,
    output reg outregWrite,
    output reg outmemtoReg
);

initial begin
    outpcAdder=0;
    outzeroflag=0;
    outAlu_Result=0;
    outDataWrite=0;
    outmuxRegFileD=0;
    outBranch=0;
    outmemtoWrite=0;
    outmemtoRead=0;
    outregWrite=0;
    outmemtoReg=0;
end

always @(posedge clk)begin
    outpcAdder<=pcAdder;
    outzeroflag<=zeroflag;
    outAlu_Result<=Alu_result;
    outDataWrite<=DataWrite;
    outmuxRegFileD<=muxRegFileD;
    outBranch<=branch;
    outmemtoWrite<=memtoWrite;
    outmemtoRead<=memtoRead;
    outregWrite<=regWrite;
    outmemtoReg<=memtoReg;
end

endmodule