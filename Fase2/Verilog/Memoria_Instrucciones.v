`timescale 1ns/1ns
module Memoriainstrucciones(
    input [31:0]RedAddress,
    output reg [31:0]instruction_mem
);

reg [7:0] ROM[0:255];
initial begin 

    $readmemb("instrucciones_bien.txt",ROM); //Vamos a leer los datos desde un archivo llamado ram.txt y los carga en la memoria ROM
end

always @*begin
    //Aqui concatenamos cuatro bytes = 32 bits consecutivos de la memoria ROM apartir de la direccion especificada por nuestra entrada RedAdress
    instruction_mem <={ROM[RedAddress],ROM[RedAddress+1],ROM[RedAddress+2],ROM[RedAddress+3]};

end
endmodule
