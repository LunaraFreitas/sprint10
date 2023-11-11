addi x1, x0, 7 #inicializa x1 com 7
#addi x3, x0, 3 #inicializa x3 com 3
init:
lb x3, 0xFF(x0)  #passa os valores do SW[7:0] para o registrador x1  , devo atualizar x1 ou x3????
addi x2, x0, -1 #inicializa o contador x2 com -1


incremento:
addi x2, x2, 1 #incrementa x2
slt x7, x2, x3 #atualiza a saída x7
#####
beq x1, x1, animacao #se a condição de parada for atingida, reinicia a rotina
continuar:
beq x1, x2, init #se a condição de parada for atingida, reinicia a rotina
beq x0, x0, incremento # volta para incrementar x2



verificador:
#lb x1, 0xFF(x0) #passa os valores do SW[7:0] para o registrador x1
#andi x3, x1, 1  #salva em x3 1 se o sw[0] tiver ligado ou 0 se estiver desligado
#beq x3, x0, verificador #caso x3 for 0 ele verifica de novo se mudou de estado, e se não for igual a 0 ele faz animação

animacao:
#como não temos função de Deslocamento de bits vamos fazer um por um
lb x3, 0xFF(x0)
addi x4, x0, 1 #x4 = 00000001
sb x4, 0xFF(x0)
addi x4, x0, 2 #x4 = 00000010
sb x4, 0xFF(x0)
addi x4, x0, 4 #x4 = 00000100
sb x4, 0xFF(x0)
addi x4, x0, 8 #x4 = 00001000
sb x4, 0xFF(x0)
addi x4, x0, 16 #x4 = 00010000
sb x4, 0xFF(x0)
addi x4, x0, 32 #x4 = 00100000
sb x4, 0xFF(x0)
addi x4, x0, 64 #x4 = 01000000
sb x4, 0xFF(x0)
addi x4, x0, 128 #x4 = 10000000
sb x4, 0xFF(x0)


beq x0, x0, continuar #volta ao loop
