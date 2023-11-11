module ControlUnit (
	 input wire [6:0] OP,Funct7,
	 input wire [2:0] Funct3,
	 output reg [2:0] ULAControl,
	 output reg [1:0] ImmSrc,
	 output reg ULASrc, RegWrite, Branch, MemWrite, ResultSrc
);

		
	initial begin
	ULAControl = 3'b000;
	ULASrc = 1'b0;
	RegWrite = 1'b1;
	end
	


	always @(*) begin
	
	
	    casex ({OP, Funct3, Funct7})
        17'b01100110000000000: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1xx0000000; //ADD
        17'b01100110000100000: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1xx0001000; //SUB
        17'b01100111110000000: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1xx0010000; //AND
        17'b01100111100000000: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1xx0011000; //OR
        17'b01100110100000000: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1xx0101000; //SLT
		  17'b0010011000xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1001000000; //ADDi
		  17'b0000011000xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1001000010; //LB
		  17'b0100011000xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b00110001x0; //SB
		  17'b1100011000xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b01000010x1; //BEQ
		 /*novas funçoes sprint 10*/
		  17'b0010011111xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1001010000; //ANDi
		  17'b0010011110xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1000011000; //ORi
		  17'b01100111000000000: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1xx0111000; //xor
        17'b0100011010xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b00110001x0; //SW
		  17'b0000011010xxxxxxx: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b1001000010; //LW
		  default: {RegWrite, ImmSrc, ULASrc, ULAControl, MemWrite, ResultSrc, Branch} = 10'b0;
		  

    endcase
	end	
	
endmodule
