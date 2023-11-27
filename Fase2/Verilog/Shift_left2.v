module Shift_left(
    input [31:0]Signextend_src,
    output reg [31:0]result_shift
);

reg [31:0]resultcambiado;

always @(Signextend_src)begin
    resultcambiado<=Signextend_src<<2;//RECORRE DOS BITS A LA IZQUIERDA 
    result_shift<=resultcambiado[31:0];
end
endmodule
