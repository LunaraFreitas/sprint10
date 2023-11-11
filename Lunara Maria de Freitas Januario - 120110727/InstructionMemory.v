module InstructionMemory (
  input wire [7:0] A,
  output reg [31:0] RD 
);

  // Defina uma memória ROM como um array bidimensional inicializado com valores
  reg [31:0] rom [255:0];

  // Inicialize a ROM com seus valores a partir de um arquivo .hex ou .mif
  initial begin
    $readmemh("rom_data.hex", rom); // Carrega dados da ROM a partir de um arquivo .hex
    // Ou $readmif("rom_data.mif", rom); // Carrega dados da ROM a partir de um arquivo .mif
  end

  // Lógica para acessar a ROM com base no endereço de entrada A
  always @(*) begin
  if(A != 0)
    RD = rom[A/4];
	else
		RD = rom[A];
  end

endmodule