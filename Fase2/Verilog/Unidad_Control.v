module ControlUnit (
    input [5:0] instruction,
    output reg RegDst,
    output reg Branch,
    output reg MemtoRead,
    output reg MemToReg,
    output reg [2:0]ALUop,
    output reg MemtoWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg jump
);
always @* 
begin
    case(instruction) 
    6'b000000:
        begin
            //instruccion tipo R, debemos de darles estos valores a estas variables si la instruccion es de tipo R
            RegDst <=1;
            Branch <=0;
            MemtoRead <= 0;
            MemToReg <= 0;
            ALUop <= 100;
            MemtoWrite <= 0;
            ALUSrc <=0;
            RegWrite <= 1;
        end
         //Instrucciones tipo i
    6'b001000:
        begin //ADDI
            RegDst<=0;
            Branch<=0;
            MemtoRead <= 0;
            MemToReg <= 0;
            ALUop <= 001;
            MemtoWrite <= 0;
            ALUSrc <=1;
            RegWrite <= 1;
        end
    6'b100011:
        begin //LW
            RegDst<=0;
            Branch<=0;
            MemtoRead <= 1;
            MemToReg <= 1;
            ALUop <= 000;
            MemtoWrite <= 0;
            ALUSrc <=1;
            RegWrite <= 1;
        end
    6'b101011:
        begin //SW
            RegDst<=0;
            Branch<=0;
            MemtoRead<=0;
            MemToReg<=0;
            ALUop<=000;
            MemtoWrite<=1;
            ALUSrc<=1;
            RegWrite<=0;
        end
    6'b001100:
        begin  //ANDI
            RegDst<=0;
            Branch<=0;
            MemtoRead<=0;
            MemToReg<=0;
            ALUop<=010;
            MemtoWrite<=0;
            ALUSrc<=1;
            RegWrite<=1;
        end
    6'b001010:
        begin //SLTI
            RegDst<=0;
            Branch<=0;
            MemtoRead<=0;
            MemToReg<=0;
            ALUop<=011;
            MemtoWrite<=0;
            ALUSrc<=1;
            RegWrite<=1;
        end
    6'b001101:
        begin //ORI
            RegDst<=0;
            Branch<=0;
            MemtoRead<=0;
            MemToReg<=0;
            ALUop<=111;
            MemtoWrite<=0;
            ALUSrc<=1;
            RegWrite<=1;
        end
    6'b000100:
        begin//BEQ
            RegDst<=0;
            Branch<=1;
            MemtoRead<=0;
            MemToReg<=0;
            ALUop<=101;
            MemtoWrite<=0;
            ALUSrc<=1;
            RegWrite<=0;
        end
	6'b000010: begin
		ALUSrc <= 0;
		jump <= 1;	//J
	end
    endcase
end

endmodule //ControlUnit


