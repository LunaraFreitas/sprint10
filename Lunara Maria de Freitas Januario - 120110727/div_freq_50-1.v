module clk_1(clk_50mhz, clk_out, clk_wtd);

   input clk_50mhz;
	input [31:0] clk_wtd;
   output reg clk_out;
	reg rst;
	reg[24:0] counter, base_clk, freq_wtd;
	
	
	
	initial begin
	counter = 0;
	rst=0;
	//base_clk = 25'd24_999_999;
	//freq_wtd = base_clk/clk_wtd;
	end
	
	
	
	always @(posedge clk_50mhz or negedge rst)
	begin
	if(!rst)
		begin
			rst=1;
			counter=25'd0;
			clk_out=1'b0;
		end
	else
		if(counter==25'd24_999_99)
			begin
				counter=25'd0;
				clk_out=~clk_out;
			end
		else
			begin
				counter=counter+1;
			end
		end
endmodule

//24_999_999 -> 1hz

