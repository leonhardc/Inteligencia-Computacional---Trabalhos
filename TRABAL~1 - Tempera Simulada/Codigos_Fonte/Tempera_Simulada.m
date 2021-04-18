%   Descri��o: Fun��o que retorna solu�ao do problema das N rainhas
%   atacantes (posi��es com 0: sem rainha, posi��es com 1: com rainha )
%
%   Valores de Entrada:
%       S0 = Configura��o inicial 
%       M = Numero m�ximo de intera��es 
%       P = Numero m�ximo de perturba��es por itera��o
%       alpha = fator de redu��o de temperatura
%   Valores de Saida:
%       S = Solu��o do problema

function S = Tempera_Simulada( S0, M, P, alpha, T0)
%   Fun��es Auxiliares:
%       pertuba(S) = Fun��o que realiza uma pertuba��o na Solu��o S
%       rand() = Fun��o que gera um numero aleat�rio no intervalo [0,1]
%       custo(Si) = Valor da Fun��o objetivo correspondente a configura��o Si

%   Vari�veis de programa:
%       Si = Configura��o da itera��o i
%       T0 = Temperatura inicial
%       i, j = Vari�veis de controle

%       Valor geralmente usado para a temperatura inicial T_inicial = 10000

%       Declara��o de Vari�veis:
S = S0;
T = T0;

%  LOOP PRINCIPAL 
for j = 1:1:M     
    %   LOOP INTERNO - Realiza��o de perturba��o em uma itera��o
    for i = 1:1:P
        
        Si = Pertuba(S);
        delta_fi = custo(Si) - custo(S);
        
        %   Teste de aceita��o de uma nova solu��o        
        if (delta_fi <= 0) || (exp((-1)*(delta_fi)/T) > rand())             
            S = Si;            
        end 
    end    
    %   Atualiza��o da Temperatura
    T = alpha*T;
     
end
cost = custo(S) % numero de pares de rainhas se atacando ao final da execuss�o do algoritimo
end

