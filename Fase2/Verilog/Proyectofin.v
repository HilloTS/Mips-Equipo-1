`timescale 1ns/1ns
module proyect();

reg clk_tb = 1'b0;
/*Cables del Banco*/
wire [31:0]C1;//Dato2
wire [31:0]C2;//Dato1

/*Elementos de la ALU*/
wire [31:0]C3;//Resultado de la ALU
wire Flag;//Es el zeroflag

/*Operacion que se selecciona en el Alu control*/
wire [3:0]C4;

/*Data Memory*/
wire [31:0]C5;//Es lo que sale de la memoria 

wire [31:0]respMux;

/*Cables para las salidas de la Unidad de Control*/
wire RegDstValue;
wire BranchValue;
wire AlusrcValue;
wire bankwrite;
wire selmemWrt;
wire selmemRed;
wire [2:0]Alupocion;
wire selMux;

wire [31:0]Mux31Alu;//Cable del MUx que le da el segundo operador a la ALU para que haga la operacion

wire [31:0]PcOutValue;
wire [31:0]fueraValue; //El resultado del Adder del pc cuando suma 4
wire [31:0]resultMuxValue;
wire [31:0]instruccionTR; //Es la instruccion que sale de la memoria de instrucciones

/*Cables del Mux de 31 bits que le da el dato a escribir al banco de registros*/
wire [31:0]Muxmembankvalue;//El dato que vamos a escribir en el banco de registros
/*Cables de Mux 5 bits a Banco*/
wire [4:0]Mux5result;//Es donde dice donde vamos a escribir
/*Componentes del Shiftleft*/
wire [31:0]Shift_leftinput;
wire [31:0]AdderShiftsrc;
/*Cable del Adder dos de 31 bits al Mux de 31 bits*/
wire [31:0]MuxAdderdossrc;
/*Mux con la compuerta AND del branch y el zeroflag*/
reg MuxFetchsrc;


always #50 clk_tb = ~clk_tb;

/*Cables Instruction Fetch (IF)*/
wire [31:0] valuePcAdder;
wire [31:0] valueInstruction_IF;


/*Cables Instruction Decode (ID)*/
wire [31:0]outID_pcAdder;
wire [31:0]outID_RD1;
wire [31:0]outID_RD2;
wire [31:0]outID_signExtend;
wire [4:0]outID_bits20_16;
wire [4:0]outID_bits15_11;
wire outID_RegDst;
wire [2:0]outID_Aluop;
wire outID_Alusrc;
wire outID_Branch;
wire outID_MemtoWrite;
wire outID_MemtoRead;
wire outID_RegWrite;
wire outID_MemtoReg;
/*Cables de Write Back (WB)*/
wire [31:0]outWBReadData;
wire [31:0]outWBALUResult;
wire [4:0]outWBmuxRegFileD;
wire outWBBackRegWrite;
wire outWBBackmemtoReg;

/*Cables Execution /Adress Calculation (EX)*/
wire [31:0]Ex_outpcAdder;
wire Ex_outzeroflag;
wire [31:0]Ex_outAlu_Result;
wire [31:0]Ex_outDataWrite;
wire [4:0]Ex_outmuxRegFileD;
    /*Unidad de control (EX)*/
wire Ex_outBranch;
wire Ex_outmemtoWrite;
wire Ex_outmemtoRead;
wire Ex_outregWrite;
wire Ex_outmemtoReg;
wire jump;

always @* begin
    MuxFetchsrc = Flag & BranchValue;
end

Memoriainstrucciones mem1(
    .RedAddress(PcOutValue),
    .instruction_mem(instruccionTR)
);

instructionFetch buffIF(
    .clk(clk_tb),
    .pcAdder(fueraValue),
    .instructionmem(instruccionTR),
    .instruccionfetch(valueInstruction_IF),
    .pcAdderFetch(valuePcAdder)
);

ControlUnit unidad_uno(
    .instruction(valueInstruction_IF[31:26]),
    .RegDst(RegDstValue),
    .Branch(BranchValue),
    .MemtoRead(selmemRed),
    .MemtoWrite(selmemWrt),
    .ALUop(Alupocion),
    .ALUSrc(AlusrcValue),
    .RegWrite(bankwrite),
    .MemToReg(selMux),
    .jump(jump)
);

bank banco_uno(
    .AR1(valueInstruction_IF[25:21]),
    .AR2(valueInstruction_IF[20:16]),
    .AW(outWBmuxRegFileD),
    .Wen(bankwrite),
    .Datow(Muxmembankvalue),
    .Dato1(C2),
    .Dato2(C1)
);

InstructionDecode buffID(
    .clk(clk_tb),
    .pcAdder(valuePcAdder),
    .BankRD1(C2),
    .BankRD2(C1),
    .valueSign_Extend(Shift_leftinput),
    .bits20_16(valueInstruction_IF[20:16]),
    .bits15_11(valueInstruction_IF[15:11]),
    .RegDst(RegDstValue),
    .Branch(BranchValue), //EX MEM
    .MemtoRead(selmemRed), //EX
    .MemToReg(selMux),//WB
    .ALUop(Alupocion),//EX
    .MemtoWrite(selmemWrt),//EX MEM
    .ALUSrc(AlusrcValue),//EX
    .RegWrite(bankwrite),//WB
    /*Salidas*/
    .valuepcAdder(outID_pcAdder),
    .valueBankRD1(outID_RD1),
    .valueBankRD2(outID_RD2),
    .outvalueSign_Extend(outID_signExtend),
    .valuebits20_16(outID_bits20_16),
    .valuebits15_11(outID_bits15_11),
    /*Salidas de la Unidad de Control*/
    .valueRegDst(outID_RegDst),
    .valueBranch(outID_Branch),
    .valueMemtoRead(outID_MemtoRead),
    .valueMemtoReg(outID_MemtoReg),
    .valueALUop(outID_Aluop),
    .valueMemtoWrite(outID_MemtoWrite),
    .valueALUsrc(outID_Alusrc),
    .valueRegWrite(outID_RegWrite)
);

ALU_Control alucontrol_uno(
    .functionfield(outID_signExtend[5:0]),
    .Alu_op(outID_Aluop),
    .operacion(C4)
);

Mux31bits muxbancoAlu(
    .valor0(outID_RD2),
    .valor1(outID_signExtend),
    .select(outID_Alusrc),
    .ValOut31(Mux31Alu)
);


/*Mux que va al PC*/
MuxAdder muxadd1(
    .val0(MuxAdderdossrc),
    .val1(Ex_outpcAdder),
    .selector(MuxFetchsrc),
    .resultMUx(resultMuxValue),
    .selector(jump)
);

Pc pc1(
    .PcSrc(resultMuxValue),
    .clk(clk_tb),
    .PcOut(PcOutValue)
);


Mux5bits muxinstrucbanco(
    .Valoren0(valueInstruction_IF[20:16]),
    .Valoren1(valueInstruction_IF[15:11]),
    .selector(outID_RegDst),
    .WriteReg(Mux5result)
);


alu alu_uno(
    .op1(C2),
    .op2(Mux31Alu),
    .sel(C4),
    .Resultado(C3),
    .zeroflag(Flag)
);

Execution_AdressCalc bufferEX(
    .clk(clk_tb),
    .pcAdder(outID_pcAdder),
    .zeroflag(Flag),
    .Alu_result(C3),
    .DataWrite(outID_RD2),
    .muxRegFileD(Mux5result),
    .branch(outID_Branch),
    .memtoWrite(outID_MemtoWrite),
    .memtoRead(outID_MemtoRead),
    .regWrite(outID_RegWrite),
    .memtoReg(outID_MemtoReg),
    /*Salidas*/
    .outpcAdder(Ex_outpcAdder),
    .outzeroflag(Ex_outzeroflag),
    .outAlu_Result(Ex_outAlu_Result),
    .outDataWrite(Ex_outDataWrite),
    .outmuxRegFileD(Ex_outmuxRegFileD),
    /*Unidad de control (EX)*/
    .outBranch(Ex_outBranch),
    .outmemtoWrite(Ex_outmemtoWrite),
    .outmemtoRead(Ex_outmemtoRead),
    .outregWrite(Ex_outregWrite),
    .outmemtoReg(Ex_outmemtoReg)
);

Memoria memoria_uno(
    .Wen(outID_MemtoWrite),
    .Adress(Ex_outAlu_Result),
    .DataW(outID_RD2),
    .Ren(outID_MemtoRead),
    .DataR(C5)
);

Write_Back buffWB(
    .clk(clk_tb),
    .readData(C5),
    .AluResult(Ex_outAlu_Result),
    .muxRegFileD(Ex_outmuxRegFileD),
    .regWrite(Ex_outregWrite),
    .memtoReg(Ex_outmemtoReg),
    /*Salidas*/
    .outreadData(outWBReadData),
    .outAluResult(outWBALUResult),
    .outmuxRegFileD(outWBmuxRegFileD),
    .outregWrite(outWBBackRegWrite),
    .outmemtoReg(outWBBackmemtoReg)
);

/*Mux que va con WB*/
Mux31bits muxmembank(
    .valor0(outWBALUResult),
    .valor1(outWBReadData),
    .select(outWBBackmemtoReg),
    .ValOut31(Muxmembankvalue)
);

Sign_Extend signuno(
    .Instruccion(instruccionTR[15:0]),
    .Instruction_config(Shift_leftinput)
);

Shift_left shiftuno(
    .Signextend_src(outID_signExtend),
    .result_shift(AdderShiftsrc)
);

Adder adderdos(
    .suma(AdderShiftsrc),
    .numprimero(outID_pcAdder),
    .fuera(MuxAdderdossrc)
);

Adder adderuno(
    .suma(4),
    .numprimero(PcOutValue),
    .fuera(fueraValue)
);


endmodule
