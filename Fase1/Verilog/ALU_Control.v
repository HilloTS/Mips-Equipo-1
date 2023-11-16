module ALU_Control(

	input [5:0]functionfield,
	input [1:0]Alu_op,
	output reg [3:0]operacion
);

always@*
begin
	case(Alu_op)
	2'b10:
		case(functionfield)
		6'b100000:
            operacion=4'b0010;
        6'b100010:
            operacion=4'b0110;
        6'b100101:
            operacion=4'b0001;
        6'b100100:
            operacion=4'b0000;
        6'b101010:
            operacion=4'b0111;
        endcase
    endcase
end
	
endmodule
