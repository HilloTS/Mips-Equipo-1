module InstructionDecode(
    input clk,//Reloj
    input [31:0]pcAdder,//Recibe lo que vale la instruccion del Pc ya sumado los 4
    input [31:0]BankRD1,//Dato 1 del banco de Registros
    input [31:0]BankRD2,//Dato 2 del banco de Registros
    input [31:0]valueSign_Extend,
    input [4:0]bits20_16,
    input [4:0]bits15_11,
    /*Apartir de aqui son las entradas de la Unidad de control*/
    input RegDst, //EX
    input Branch, //EX MEM
    input MemtoRead, //EX
    input MemToReg,//WB
    input [2:0]ALUop,//EX
    input MemtoWrite,//EX MEM
    input ALUSrc,//EX
    input RegWrite,//WB
    /*Salidas del banco de registros, del sign extend, del pc y de la instruccion*/
    output reg [31:0]valuepcAdder,
    output reg [31:0]valueBankRD1,
    output reg [31:0]valueBankRD2,
    output reg [31:0]outvalueSign_Extend,
    output reg [4:0]valuebits20_16,
    output reg [4:0]valuebits15_11,
    /*Salidas de la Unidad de Control*/
    output reg valueRegDst,
    output reg valueBranch,
    output reg valueMemtoRead,
    output reg valueMemtoReg,
    output reg [2:0]valueALUop,
    output reg valueMemtoWrite,
    output reg valueALUsrc,
    output reg valueRegWrite
);

initial begin
    valuepcAdder=0;
    valueBankRD1=0;
    valueBankRD2=0;
    outvalueSign_Extend=0;
    valuebits20_16=0;
    valuebits15_11=0;
    valueRegDst=0;
    valueBranch=0;
    valueMemtoRead=0;
    valueMemtoReg=0;
    valueALUop=0;
    valueMemtoWrite=0;
    valueALUsrc=0;
    valueRegWrite=0;
end

always @(posedge clk)begin
    valuepcAdder<=pcAdder;
    valueBankRD1<=BankRD1;
    valueBankRD2<=BankRD2;
    outvalueSign_Extend<=valueSign_Extend;
    valuebits20_16<=bits20_16;
    valuebits15_11<=bits15_11;
    valueRegDst<=RegDst;
    valueBranch<=Branch;
    valueMemtoRead<=MemtoRead;
    valueMemtoReg<=MemToReg;
    valueALUop<=ALUop;
    valueMemtoWrite<=MemtoWrite;
    valueALUsrc<=ALUSrc;
    valueRegWrite<=RegWrite;
end

endmodule