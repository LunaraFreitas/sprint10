
O objetivo dessa sprint final foi de que cada aluno deveria criar novas
funcionalidades para seu processador RISC-V e utilizá-las em uma aplicação
prática. Tendo como objetivos específicos os seguintes:
● Acrescentar, no mínimo, 3 novos componentes de hardware no circuito do seu
processador;
● Documentar as novas funcionalidades no formato de um help;
● Projetar uma aplicação prática, com potencial de uso real, baseada no novo
processador RISC-V melhorado.
Especificação da Implementação e Aplicações
Foi implementado o suporte às instruções: LW (Load Word), SW (Store Word),
ORI (OR Immediate), ANDI (AND Immediate), e XOR (Exclusive OR). Cada uma
dessas instruções desempenha um papel crucial na execução eficiente de
programas, proporcionando funcionalidades essenciais ao contexto do processador
RISC-V de ciclo único.
A funcionalidade de cada uma delas é tal que:
A instrução LW é responsável por carregar um dado da memória para um
registrador. Esse processo é crucial para a manipulação eficiente de dados,
permitindo a transferência de informações da memória principal para o processador.
Ao contrário da instrução LW, a SW realiza a operação inversa, armazenando
um dado de um registrador na memória. Essa capacidade é vital para a persistência
e o compartilhamento de dados durante a execução de programas.
A instrução ORI realiza a operação lógica "OR" entre um registrador e uma
constante imediata, fornecendo flexibilidade na manipulação de dados. Essa
operação é valiosa em contextos nos quais a combinação de bits é essencial,
permitindo a configuração de flags e opções de controle.
ANDI realiza a operação lógica "AND" entre um registrador e uma constante
imediata. Essa instrução é valiosa para operações de máscara e manipulação de
bits, sendo útil em diversos contextos de processamento de dados.
A instrução XOR executa a operação lógica XOR entre dois registradores.
Essa operação é útil em operações de alternância de bits e criptografia, contribuindo
para a diversidade de operações lógicas disponíveis no conjunto de instruções.
No âmbito deste projeto, destaca-se uma aplicação prática relevante e de
potencial uso real, utilizando o processador RISC-V de ciclo único aprimorado. A
aplicação escolhida consiste em um gerador de pulso PWM (Pulse Width
Modulation) implementado por meio do ambiente de desenvolvimento Quartus,
utilizando o RARs (RISC-V Assembly Language) e integrado a uma placa FPGA.

O objetivo principal desta aplicação é controlar a duração do pulso PWM,
influenciando diretamente uma animação dos LEDs presentes na placa FPGA. A
manipulação da largura do pulso é realizada através das chaves SW[7:0] da placa
FPGA, em que a inserção de um valor binário por meio dessas chaves determina a
extensão temporal do pulso gerado.
Em termos práticos, durante o período em que a saída PWM está em nível
alto, os LEDs na FPGA são acionados para executar uma animação específica
pré-definida, anteriormente realizada em sprints anteriores. A relação direta entre o
valor inserido pelas chaves SW[7:0] e a duração do pulso proporciona um controle
sobre o comportamento da animação, tornando esta aplicação uma ferramenta
versátil para demonstrações visuais e experimentação prática.
Vale ressaltar que a variação de pulso ocorre em 8 bits é de 2^8 = 256
unidades de tempo. Dessa forma, quanto mais unidades de tempo, maior a largura
do pulso.
