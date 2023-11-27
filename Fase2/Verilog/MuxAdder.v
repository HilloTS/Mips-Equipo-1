module MuxAdder(
    input [31:0]val0,
    input [31:0]val1,
    input selector,
    output reg [31:0]resultMUx
);

always @*
    begin
        case(selector)
        1'b1:
            resultMUx=val1;
        1'b0:
            resultMUx=val0;
        endcase
    end
endmodule
