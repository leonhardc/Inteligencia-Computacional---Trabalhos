%   Descri��o: Fun��o que realiza uma pertuba��o na Solu��o S
%
%   Valores de Entrada:
%       S = Configura��o inicial do tabuleiro

function Si = Pertuba( S )
%   Valor de Sa�da:
%       Si = Solu��o pertubada
Si = S;

tam = size(S);  %   Saber o tamanho da Matriz
N = tam(1);     %   Numero de linhas ou de colunas, assumindo o tabuleiro
                %   quadrado ambos devem ser iguais
                
col = randi(N); %   Escolher uma coluna aleatoria
lin = randi(N); %   Escolher uma linha aleat�ria

%   Saber onde est� a rainha na coluna aleat�ria
for i = 1:1:N
    if Si(i,col) == 1
        Si(i,col) = 0;
    end
end
Si(lin,col) = 1; % Mudar a posi��o da Rainha para escolhida aleatoriamente
                 % nos passos anteriores

end

