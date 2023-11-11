module decoder(
  input wire SW2, SW1, SW0,
  output wire [7:0] SEG
);

  reg [2:0] HEX; // Armazena o valor hexadecimal correspondente
  
  always @(*)
  begin
    // Atribuição de bits individuais da entrada SW ao registrador HEX
    HEX[0] = SW0; // Bit menos significativo
    HEX[1] = SW1;
    HEX[2] = SW2;// Bit mais significativo
  end

  reg [7:0] segment_table [7:0];

  initial begin
   //7 6 5 4 3 2 1 
    segment_table[0] = 8'b0000_0001; 
    segment_table[1] = 8'b0000_0010;
    segment_table[2] = 8'b0000_0100; 
    segment_table[3] = 8'b0000_1000;  
    segment_table[4] = 8'b0001_0000; 
    segment_table[5] = 8'b0010_0000;  
    segment_table[6] = 8'b0100_0000;  
    segment_table[7] = 8'b1000_0000;  
    
  end

  assign SEG = segment_table[HEX]; // Atribuição do padrão de segmentos correspondente ao valor HEX à saída SEG


endmodule