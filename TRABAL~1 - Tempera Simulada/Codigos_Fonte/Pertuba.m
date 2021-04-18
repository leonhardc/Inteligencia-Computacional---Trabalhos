%   Descrição: Função que realiza uma pertubação na Solução S
%
%   Valores de Entrada:
%       S = Configuração inicial do tabuleiro

function Si = Pertuba( S )
%   Valor de Saída:
%       Si = Solução pertubada
Si = S;

tam = size(S);  %   Saber o tamanho da Matriz
N = tam(1);     %   Numero de linhas ou de colunas, assumindo o tabuleiro
                %   quadrado ambos devem ser iguais
                
col = randi(N); %   Escolher uma coluna aleatoria
lin = randi(N); %   Escolher uma linha aleatória

%   Saber onde está a rainha na coluna aleatória
for i = 1:1:N
    if Si(i,col) == 1
        Si(i,col) = 0;
    end
end
Si(lin,col) = 1; % Mudar a posição da Rainha para escolhida aleatoriamente
                 % nos passos anteriores

end

