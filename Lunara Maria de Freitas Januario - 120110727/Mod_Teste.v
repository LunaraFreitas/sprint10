`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------




// sprint 9 -  Programação em Assembly – Processador RISC-V

wire w_ULASrc, w_RegWrite, w_MemWrite, w_ResultSrc, CLK, CLK_gen, w_PCSrc, w_Zero, w_Branch, w_EN;
wire [1:0] w_ImmSrc;
wire [2:0] w_ULAControl;
wire [7:0] w_rd1SrcA, w_ULAResult, w_rd2, w_SrcB, w_PCp4, w_PC, w_Wd3, w_Imm, w_RData, w_ImmPC, w_PCn, w_DataIn, w_DataOut, w_RegData;
wire [31:0] w_Inst;

assign w_d0x4 = w_PC;
assign w_d1x4 = w_DataOut;
assign LEDG[0] = w_Zero;
assign w_DataIn = SW[7:0];

PC p1 (.clk(CLK), .rst(KEY[0]), .PCin(w_PCn), .PC(w_PC));
assign w_PCp4 = w_PC + 3'h4;

InstructionMemory im1 (.A(w_PC), .RD(w_Inst));

ControlUnit cu1 (.OP(w_Inst[6:0]), .Funct3(w_Inst[14:12]), .Funct7(w_Inst[31:25]), .ResultSrc(w_ResultSrc), .MemWrite(w_MemWrite), .ULAControl(w_ULAControl), .ULASrc(w_ULASrc), .ImmSrc(w_ImmSrc), .RegWrite(w_RegWrite), .Branch(w_Branch));


RegisterFile r1 (.clk(CLK), .rst(KEY[0]), .we3(w_RegWrite), .wa3(w_Inst[11:7]), .ra1(w_Inst[19:15]), .ra2(w_Inst[24:20]), .wd3(w_Wd3), .rd1(w_rd1SrcA), .rd2(w_rd2), .x0(w_d0x0), .x1(w_d0x1), .x2(w_d0x2), .x3(w_d0x3), .x4(w_d1x0), .x5(w_d1x1), .x6(w_d1x2), .x7(w_d1x3));
ULA u1( .SrcA(w_rd1SrcA), .SrcB(w_SrcB), .ULAControl(w_ULAControl), .ULAResult(w_ULAResult), .FlagZ(w_Zero));
assign w_SrcB = (w_ULASrc == 1'b0) ? w_rd2 : w_Imm; //MuxULASrc

MuxImmSrc mu1 (.w_Inst(w_Inst), .w_ImmSrc(w_ImmSrc), .w_Imm(w_Imm));

assign w_PCSrc = w_Branch & w_Zero; //AND ULA e ControlUnit
assign w_ImmPC = w_PC + w_Imm; //Adder ImmPC
assign w_PCn = (w_PCSrc == 1'b0) ? w_PCp4 : w_ImmPC; //MuxPCSrc

DataMemory dm1(.clk(CLK), .rst(KEY[0]), .A(w_ULAResult), .WD(w_rd2), .WE(w_MemWrite), .RD(w_RData));
assign w_Wd3 = (w_ResultSrc == 1'b0) ? w_ULAResult : w_RegData; //MuxResSrc

//ParallelIn
assign w_RegData = (w_ULAResult == 8'hFF) ? w_DataIn : w_RData; //Mux Parallel in

ParallelOut po1 (.clk(CLK), .rst(KEY[0]), .EN(w_MemWrite), .RegData(w_rd2), .Address(w_ULAResult), .DataOut(w_DataOut));

//mostrar os valores no display 7seg
decoder_7seg d0(w_Inst[3], w_Inst[2], w_Inst[1], w_Inst[0], HEX0);
decoder_7seg d1(w_Inst[7], w_Inst[6], w_Inst[5], w_Inst[4], HEX1);
decoder_7seg d2(w_Inst[11], w_Inst[10], w_Inst[9], w_Inst[8], HEX2);
decoder_7seg d3(w_Inst[15], w_Inst[14], w_Inst[13], w_Inst[12], HEX3);
decoder_7seg d4(w_Inst[19], w_Inst[18], w_Inst[17], w_Inst[16], HEX4);
decoder_7seg d5(w_Inst[23], w_Inst[22], w_Inst[21], w_Inst[20], HEX5);
decoder_7seg d6(w_Inst[27], w_Inst[26], w_Inst[25], w_Inst[24], HEX6);
decoder_7seg d7(w_Inst[31], w_Inst[30], w_Inst[29], w_Inst[28], HEX7);


//PARA TROCAR O CLOCK DO BOTÃO PARA O DIVISOR DE FREQUENCIA:
//substituir o (assign CLK = KEY[1];) por: (assign CLK = CLK_gen);
assign CLK = CLK_gen;
clk_1 cl1(.clk_50mhz(CLOCK_50), .clk_out(CLK_gen), .clk_wtd(1));

attsw(.DataIn(w_DataIn), .SW(SW[7:0]), .LEDR(LEDR[7:0]), .DataOut(w_DataOut));
//assign w_DataIn = SW[7:0];
//assign LEDR[7:0] = w_DataOut;

 
endmodule



/*

FORAM IMPLEMENTADAS NOVAS FUNÇÕES
ORI, XOR E ANDI, SW, LW
*/


