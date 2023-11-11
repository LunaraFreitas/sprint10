module attsw (input wire [7:0] SW, DataOut,
	output reg [7:0] LEDR, DataIn
);

always @(*) begin
	DataIn = SW;
	LEDR = DataOut;
	end
	
endmodule