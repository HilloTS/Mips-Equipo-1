module Write_Back(
    input clk,
    input [31:0]readData,//Sale de la memoria
    input [31:0]AluResult,
    input [4:0]muxRegFileD,
    input regWrite,//WB
    input memtoReg,//WB
    /*Salidas*/
    output reg [31:0]outreadData,
    output reg [31:0]outAluResult,
    output reg [4:0]outmuxRegFileD,
    output reg outregWrite,
    output reg outmemtoReg
);

initial begin
    outreadData=0;
    outAluResult=0;
    outmuxRegFileD=0;
    outregWrite=0;
    outmemtoReg=0;
end

always @(posedge clk)begin
    outreadData<=readData;
    outAluResult<=AluResult;
    outmuxRegFileD<=muxRegFileD;
    outregWrite<=regWrite;
    outmemtoReg<=memtoReg;
end

endmodule
