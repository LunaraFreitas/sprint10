module RegisterFile (
    input wire clk, rst, we3,
    input wire [2:0] wa3, ra1, ra2,
    input wire [7:0] wd3, 
	 output wire [7:0] rd1, rd2, x0, x1, x2, x3, x4, x5, x6, x7
);

wire [7:0] decoder_out;
reg [7:0] registers [0:7];
reg[7:0] i, ii, iii, load;

decoder m1(wa3[2], wa3[1], wa3[0], decoder_out); //converte o binario inserido em seleção para as portas and trabalhar junto com o bit we3;

always @(*) 
	begin
		for (ii=1; ii < 8; ii=ii+1)
			load[ii] = we3 & decoder_out[ii];  //load é a saida das portas and
	end
  

//iniciando o registrador

always @(posedge clk or negedge rst) //reset esta de forma assincrona
begin
    if (~rst)
       for (i = 0; i < 8; i = i + 1)  //como em verilog não permite fazermos diretamente  "registers <= 8'b0;" então fiz um laço para atribuir 0 a cada elemento do vetor.
             registers[i] <= 8'b0000_0000;
    else if (load != 8'b0000_0000) // somente salva se as portas and tiverem nivel alto
				registers[wa3] <= wd3;
end

//agora vamos passar as saidas para os multiplexadores

assign rd1 = registers[ra1];
assign rd2 = registers[ra2];
assign x0 = registers[0];
assign x1 = registers[1];
assign x2 = registers[2];
assign x3 = registers[3];
assign x4 = registers[4];
assign x5 = registers[5];
assign x6 = registers[6];
assign x7 = registers[7];

endmodule
						  
/*o codigo do multiplexador acima é a mesma coisa de fazer:
assign rd1 = (ra1 == 3'b000) ? registers[0] :
            (ra1 == 3'b001) ? registers[1] :
            (ra1 == 3'b010) ? registers[2] :
            (ra1 == 3'b011) ? registers[3] :
            (ra1 == 3'b100) ? registers[4] :
            (ra1 == 3'b101) ? registers[5] :
            (ra1 == 3'b110) ? registers[6] :
            (ra1 == 3'b111) ? registers[7] :
					
				ou
				
			if(ra1 == 3'b000)
				rd1=registers[0]
				
			else if(ra1 == 3'b001)
				rd1 = registers[1]
				...
				...	
*/




/*No contexto geral desse registrador devemos levar em conta que em designs reais, podem ser necessárias mais funcionalidades 
e considerações, como controle de escrita concorrente*, lógica de detecção de conflitos*, tratamento de sinais de controle*, etc.

*Na escrita concorrente, várias atribuições são realizadas simultaneamente, modelando o comportamento paralelo 
dos componentes em um sistema digital. Isso é especialmente relevante em design de hardware, onde vários sinais 
e componentes podem mudar de estado simultaneamente em resposta a diferentes eventos ou condições.

*A detecção de conflitos refere-se principalmente a situações em que várias escritas concorrentes tentam atualizar 
o mesmo sinal ou registrador simultaneamente. Isso pode levar a comportamentos indefinidos, como lógica inconsistente
 ou resultados imprevisíveis.
 
*O tratamento de sinais de controle é uma parte fundamental do design de hardware digital, que envolve a coordenação 
de sinais que controlam a operação de diversos componentes no circuito. Os sinais de controle são usados para garantir
 que os componentes realizem as operações corretas no momento certo e em conjunto com outras partes do sistema. 

*/
