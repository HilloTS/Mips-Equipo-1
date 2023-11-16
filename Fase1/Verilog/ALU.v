module alu(
	input [31:0]op1,
	input [31:0]op2,
	input [3:0]sel,
	output reg [31:0]Resultado,
	output reg zeroflag
);



always @*
begin
	case (sel)
		4'b0000:
			Resultado= op1&op2;
		4'b0001:
			Resultado = op1|op2;
		4'b0010:
			Resultado = op1+op2;
		4'b0110:
			Resultado = op1-op2;
		4'b0111:
			Resultado = op1<op2?1:0;
		4'b1100:
			Resultado = ~(op1 | op2);
		default:
			Resultado =0;
	endcase
	if(Resultado==0)
		zeroflag=1;
	else
		zeroflag=0;
end

endmodule

