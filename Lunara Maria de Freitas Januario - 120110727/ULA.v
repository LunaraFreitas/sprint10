module ULA (
	 input wire [7:0] SrcA, SrcB,
	 input wire [2:0] ULAControl,
	 output reg [7:0] ULAResult,
	 output reg FlagZ
);

/*
• SrcA (8bits): Entrada de dados do operando A;
• SrcB (8bits): Entrada de dados do operando B;
• ULAControl (3bits): Entrada para seleção da operação realizada (ver Tabela 1).
Saídas:
• ULAResult (8bits): Saída do resultado da operação realizada;
• Flag Z (1bit): Bit de status que indica se a saída da operação realizada é zero (resultado igual a zero: Z=1;
resultado diferente de zero: Z=0).
*/

//Add 3’b000 = SrcA + SrcB
//Subtract 3’b001 = SrcA + SrcB + 1
//And 3’b010 = SrcA & SrcB
//Or 3’b011 = SrcA | SrcB
//Set less than (SLT) 3’b101 1, se SrcA < SrcB ; 0, caso contrario.

always @(*) begin
    case (ULAControl)
        3'b000: ULAResult = SrcA + SrcB;
        3'b001: ULAResult = (SrcA + (~SrcB + 1));
        3'b010: ULAResult = SrcA & SrcB;
        3'b011: ULAResult = SrcA | SrcB;
        3'b101: ULAResult = (SrcA < SrcB) ? 8'b00000001 : 8'b00000000;
		  3'b111: ULAResult = (SrcA ^ SrcB);
		  
        default: ULAResult = 8'b00000000;
    endcase

    FlagZ = (ULAResult == 8'b00000000) ? 1'b1 : 1'b0;
end

endmodule
