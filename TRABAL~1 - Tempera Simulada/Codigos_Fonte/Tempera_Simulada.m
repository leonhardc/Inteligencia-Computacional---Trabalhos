%   Descrição: Função que retorna soluçao do problema das N rainhas
%   atacantes (posições com 0: sem rainha, posições com 1: com rainha )
%
%   Valores de Entrada:
%       S0 = Configuração inicial 
%       M = Numero máximo de interações 
%       P = Numero máximo de perturbações por iteração
%       alpha = fator de redução de temperatura
%   Valores de Saida:
%       S = Solução do problema

function S = Tempera_Simulada( S0, M, P, alpha, T0)
%   Funções Auxiliares:
%       pertuba(S) = Função que realiza uma pertubação na Solução S
%       rand() = Função que gera um numero aleatório no intervalo [0,1]
%       custo(Si) = Valor da Função objetivo correspondente a configuração Si

%   Variáveis de programa:
%       Si = Configuração da iteração i
%       T0 = Temperatura inicial
%       i, j = Variáveis de controle

%       Valor geralmente usado para a temperatura inicial T_inicial = 10000

%       Declaração de Variáveis:
S = S0;
T = T0;

%  LOOP PRINCIPAL 
for j = 1:1:M     
    %   LOOP INTERNO - Realização de perturbação em uma iteração
    for i = 1:1:P
        
        Si = Pertuba(S);
        delta_fi = custo(Si) - custo(S);
        
        %   Teste de aceitação de uma nova solução        
        if (delta_fi <= 0) || (exp((-1)*(delta_fi)/T) > rand())             
            S = Si;            
        end 
    end    
    %   Atualização da Temperatura
    T = alpha*T;
     
end
cost = custo(S) % numero de pares de rainhas se atacando ao final da execussão do algoritimo
end

