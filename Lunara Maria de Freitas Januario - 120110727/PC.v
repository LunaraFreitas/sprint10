module PC(
  input wire clk,rst,
  input wire [7:0] PCin, // Entrada para carregamento paralelo
  output reg [7:0] PC  // Saída paralela
);

	reg [7:0] i, ii;
	
	initial
		PC = 8'b00000000;
  

	always @(posedge clk or negedge rst) begin
    
		if (~rst) begin
			for (i = 0; i < 8; i = i + 1)  //como em verilog não permite fazermos diretamente  "registers <= 8'b0;" então fiz um laço para atribuir 0 a cada elemento do vetor.
				PC[i] <= 8'b0000_0000;
		end 
	 
		else begin
			for (ii = 0; ii < 8; ii = ii + 1)
				PC[ii] <= PCin[ii];
		end
  
  end


endmodule