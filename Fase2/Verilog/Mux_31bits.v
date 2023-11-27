module Mux31bits(
    input [31:0]valor1,
    input [31:0]valor0,
    input select,
    output reg [31:0]ValOut31
);

always @*
    begin
        case(select)
        1'b1:
            ValOut31=valor1;
        1'b0:
            ValOut31=valor0;
        endcase
    end
endmodule
