module ALU_Control(

	input [5:0]functionfield,
	input [2:0]Alu_op,
	output reg [3:0]operacion
);

always@*
begin
	case(Alu_op)
	3'b100://Tipo R
    begin
		case(functionfield)
		6'b100000:
            operacion=4'b0010;//SUMA
        6'b100010:
            operacion=4'b0110;//RESTA
        6'b100101:
            operacion=4'b0001;//OR
        6'b100100:
            operacion=4'b0000;//AND
        6'b101010:
            operacion=4'b0111;//SLT
        endcase
    end
    3'b001://ADDI
    begin
        operacion=4'b0010;
    end
    3'b000://LW, SW
    begin
        operacion=4'b0010;
    end
    3'b010://ANDI
    begin
        operacion=4'b0000;
    end
    3'b011://SLTI
    begin
        operacion=4'b0111;
    end
    3'b111://ORI
    begin
        operacion=4'b0001;
    end
    3'b101://BEQ
    begin
        operacion=4'b0110;
    end
    endcase
end
	
endmodule

