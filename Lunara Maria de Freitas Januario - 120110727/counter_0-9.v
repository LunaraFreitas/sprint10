module contador_0_a_9(
    input wire CLK,   // Sinal de clock
    input wire RESET, // Sinal de reset na borda negativa
    output wire Q3,   // Saída do bit mais significativo
    output wire Q2,
    output wire Q1,
    output wire Q0    // Saída do bit menos significativo
);

    reg [3:0] count = 4'b0000; // Registrador para armazenar o valor do contador
    
    always @(posedge CLK or negedge RESET)
    begin
        if (!RESET) // Reset na borda negativa
            count <= 4'b0000; // Reiniciar o contador para 0
        else if (count == 4'b1001) // Quando o contador atinge 9 (1001 em binário)
            count <= 4'b0000; // Reiniciar o contador para 0
        else
            count <= count + 1; // Incrementar o contador
    end

    assign {Q3, Q2, Q1, Q0} = count; // Atribuir o valor do contador aos bits de saída

endmodule