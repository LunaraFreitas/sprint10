module desafio(
  input wire clk,
  output reg [6:0] SEG0,SEG1,SEG2,SEG3
);

//seg0 = hex3 e seg3 = hex0

reg [3:0] counter = 0 ;
 
	always @(posedge clk)
		begin
			
			SEG0=7'b111_1111;
			SEG1=7'b111_1111;
			SEG2=7'b111_1111;
			SEG3=7'b111_1111;
			
			if(counter >= 12)
			counter = 0;
	
			if(counter == 0)
				SEG0 = 7'b011_1111;
				
			if(counter == 1)
				SEG1 = 7'b011_1111;
			
			if(counter == 2)
				SEG2 = 7'b011_1111;

			if(counter == 3)
				SEG3 = 7'b011_1111;

			if(counter == 4)
				SEG3 = 7'b101_1111;

			if(counter == 5)
				SEG3 = 7'b110_1111;

			if(counter == 6)
				SEG3 = 7'b111_0111;

			if(counter == 7)
				SEG2 = 7'b111_0111;

			if(counter == 8)
				SEG1 = 7'b111_0111;

			if(counter == 9)
				SEG0 = 7'b111_0111;

			if(counter == 10)
				SEG0 = 7'b111_1011;

			if(counter == 11)
				SEG0 = 7'b111_1101;
				
			counter=counter + 1;
			

		end
 endmodule