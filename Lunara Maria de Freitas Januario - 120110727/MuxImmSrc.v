module MuxImmSrc(
	input wire [31:0] w_Inst,
	input wire [1:0] w_ImmSrc,
	output reg [7:0] w_Imm
);
	
	

always @(*) begin
	
	case (w_ImmSrc)
		2'b00:  w_Imm = w_Inst[31:20];
		2'b01:  w_Imm = {w_Inst[31:25], w_Inst[11:7]};
		2'b10:  w_Imm = {w_Inst[7], w_Inst[30:25], w_Inst[11:8], 1'b0};     
		default : w_Imm = 8'b0;  
	endcase
end

endmodule