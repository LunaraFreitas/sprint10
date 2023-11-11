module ParallelOut (
    input wire clk, rst, EN,
    input wire [7:0] RegData, Address,
	 output reg [7:0] DataOut
);

wire choice, En;

	assign choice = (Address == 8'hFF) ? 1'b1 : 1'b0; 
	assign En = EN & choice;

always @(posedge clk or negedge rst) //reset esta de forma assincrona
begin
    if (~rst)
			 //como em verilog não permite fazermos diretamente  "registers <= 8'b0;" então fiz um laço para atribuir 0 a cada elemento do vetor.
				DataOut <= 8'b0000_0000;
    else if (En)
				DataOut <= RegData;

end


endmodule