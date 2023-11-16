`timescale 1ns/1ns

module proyect(
    input reloj
);


wire [31:0]C1;
wire [31:0]C2;
wire [31:0]C3;
wire [3:0]C4;
wire [31:0]C5;
wire [1:0]Alupocion;
wire selmemWrt;
wire selmemRed;
wire selMux;
wire bankwrite;
wire [31:0]respMux;
wire Flag;
wire RegDstValue;
wire BranchValue;
wire AlusrcValue;
wire [31:0]Mux31Alu;
wire [31:0]PcOutValue;
wire [31:0]fueraValue;
wire [31:0]resultMuxValue;
wire [31:0]instruccionTR;
wire [31:0]Muxmembankvalue;
wire [4:0]Mux5result;


ControlUnit unidad_uno(
    .instruction(instruccionTR[31:26]),
    .RegDst(RegDstValue),
    .Branch(BranchValue),
    .MemtoRead(selmemRed),
    .MemtoWrite(selmemWrt),
    .ALUop(Alupocion),
    .ALUSrc(AlusrcValue),
    .RegWrite(bankwrite),
    .MemToReg(selMux)
);

bank banco_uno(
    .AR1(instruccionTR[25:21]),
    .AR2(instruccionTR[20:16]),
    .AW(Mux5result),
    .Wen(bankwrite),
    .Datow(Muxmembankvalue),
    .Dato1(C2),
    .Dato2(C1)
);

ALU_Control alucontrol_uno(
    .functionfield(instruccionTR[5:0]),
    .Alu_op(Alupocion),
    .operacion(C4)
);

Mux31bits muxbancoAlu(
    .valor0(C1),
    .select(AlusrcValue),
    .ValOut31(Mux31Alu)
);

Adder adderuno(
    .suma(4),
    .numprimero(PcOutValue),
    .fuera(fueraValue)
);

MuxAdder muxadd1(
    .val0(fueraValue),
    .selector(Flag&BranchValue),
    .resultMUx(resultMuxValue)
);

Pc pc1(
    .PcSrc(resultMuxValue),
    .clk(reloj),
    .PcOut(PcOutValue)
);

Memoriainstrucciones mem1(
    .RedAddress(PcOutValue),
    .instruction_mem(instruccionTR)
);

Mux5bits muxinstrucbanco(
    .Valoren0(instruccionTR[20:16]),
    .Valoren1(instruccionTR[15:11]),
    .selector(RegDstValue),
    .WriteReg(Mux5result)
);


alu alu_uno(
    .op1(C2),
    .op2(Mux31Alu),
    .sel(C4),
    .Resultado(C3),
    .zeroflag(Flag)
);

Memoria memoria_uno(
    .Wen(selmemWrt),
    .Ren(selmemRed),
    .Adress(C3),
    .DataW(C1),
    .DataR(C5)
);

Mux31bits muxmembank(
    .valor0(C3),
    .valor1(C5),
    .select(selMux),
    .ValOut31(Muxmembankvalue)
);

endmodule
