module Sign_Extend(
    input [15:0]Instruccion,
    output reg [31:0]Instruction_config
);

assign Instruction_config = {16'b0000000000000000, Instruccion};

endmodule

