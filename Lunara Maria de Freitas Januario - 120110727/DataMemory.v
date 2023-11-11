module DataMemory (
    input [7:0] A,        // Entrada de endereço - 8 bits
    input [7:0] WD,       // Entrada de dados (Escrita) - 8 bits
    output reg [7:0] RD,  // Saída de dados (Leitura) - 8 bits
    input WE,             // Enable de escrita - 1 bit
    input rst,            // Reset da memória - 1 bit
    input clk             // Clock de escrita - 1 bit
);
    reg [7:0] mem [0:255]; // Array bidimensional para armazenar os dados da memória (256 posições de 8 bits cada)	
	 reg [8:0] i;
	 
	 
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            // Reset da memória, apaga todo o conteúdo
            for (i = 0; i < 256; i = i + 1) begin
                mem[i] <= 8'b00000000;
            end
        end
		  else if (WE) begin
            // Escreve os dados no endereço especificado
            mem[A] <= WD;
        end
    end

    always @(A) begin
        // Leitura dos dados no endereço especificado
        RD <= mem[A];
    end

endmodule