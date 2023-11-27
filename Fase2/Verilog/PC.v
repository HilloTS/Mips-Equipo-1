module Pc(
    input [31:0] PcSrc,
    input clk,
    output reg [31:0] PcOut
);

initial
    begin
        PcOut=0;
    end
always @(posedge clk)
    begin
        PcOut <= PcSrc;
    end

endmodule
