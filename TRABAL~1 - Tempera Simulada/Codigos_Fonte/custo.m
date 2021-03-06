%   Descri??o: Retorna o custo de uma configura??o S do tabuleiro
%   calculando quantos pares de rainhas est?o se atacando multuamente. 
%
%   Vari?veis:
%   S = Configura??o do tabuleiro a qual vai ser calculado seu custo
%   
%   
%   Exemplo de uso:
%   custo(a)

function CdeS = custo( S )
% CdeS => custo de S retonado pela fun??o
% Elabora??o da Fun??o:
% Primeiro: identificar onde est?o as rainhas (os valores 1)
% Segundo: Identificar quantos ataques existem

C = []; % Matriz que guarda as posi??es das rainhas no tabuleiro
tam = size(S);
N = tam(1);

% Identificar as posi??es das rainhas no tabuleiro
for j = 1:1:N
    for i = 1:1:N
        if S(i,j) == 1
            b = [i j];
            C = [C;b]; % Guarda as posi??es de cada rainha 
        end            
    end
end
% Fim da fase de identifica??o das posi??es das rainhas

% Operar sobre a matriz C para saber quantas rainhas est?o se atacando
CdeS = 0; % custo a ser retornado
for i = 1:1:N
    for j = 1:1:N
        if ((C(i,1)==C(j,1)) || (C(j,1)-C(i,1) == C(j,2)-C(i,2) || C(j,1)-C(i,1) == (-1)*(C(j,2) - C(i,2) ) ) ) && i~=j 
            CdeS = CdeS + 1;  % Incremente o contador caso as rainhas se ataquem
        end 
    end 
end 
CdeS = CdeS/2; % o custo real de quantos PARES de rainhas est?o se atacando e n?o quantos ataques existem
end

