module Mux5bits(
    input [4:0]Valoren1,
    input [4:0]Valoren0,
    input selector,
    output reg [4:0]WriteReg
);

always @*
    begin
        case(selector)
        1'b1:
            WriteReg=Valoren1;
        1'b0:
            WriteReg=Valoren0;
        endcase
    end
endmodule