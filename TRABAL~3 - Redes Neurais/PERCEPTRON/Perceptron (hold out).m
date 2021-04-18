%   Perceptron - An�lise com HOLD OUT (70% treino (105 amostras) e 30% teste (45 amostras))
%   quantidade de neur�nios 3


base = load('iris_log.dat');

Eta = 0.1; % Passo de aprendizagem
q = 3;     % Quantidade de neuronios da camada de sa�da
epocas = 10; % Quantidade de �pocas de treinamento
Erros = []; % Quantidade de erros que a rede cometeu
contErro = 0; % Contador de erros para os testes da rede perceptron simples

% amostras para treino da rede
X_treino = base(1:105, 1:4)';
Y_treino = base(1:105, 5:7)';
X_treino = [(-1)*ones(1,105) ; X_treino]; 

% amostras para teste da rede
X_teste = base(106:150, 1:4)';
Y_teste = base(106:150, 5:7)';
X_teste = [(-1)*ones(1,45) ; X_teste]; 

W = rand(5 , q); % Vetor de pesos

for epoca = 1:epocas % Loop externo - quantidade de epocas - In�cio do treinamento
    
        for i = 1:105 % Loop Interno - quantidade de amostras      
            
            for j = 1:q % Loop Interno - atualiza��o do vetor de pesos
                Uj = X_treino(: , i)'*W(: , j);               
                                
                Yj = 1; % Yj - fun��o de disparo
                
                if Uj <= 0
                    Yj = 0;
                end
                
                W(: , j) = W(: , j) + Eta*(Y_treino(j , i) - Yj)*X_treino(: , i); % Atualiza��o do vetor de pesos
            end % fim da atualiza��o do vetor de pesos
            
        end % Fim da verifica��o da quantidade de amostras      
    
end % Fim do treinamento

for i = 1:45 % In�cio dos testes
    vY = [];
    for j = 1:q
        Uj = X_teste(: , i)'*W(: , j);
        
        Yj = 1; % Yj - fun��o de disparo                
        if Uj <= 0
            Yj = 0;
        end
        
        vY = [vY; Yj];        
    end 
    
    % Verifica��o se a resposta da rede est� certa ou n�o
    erro = sum(Y_teste(: , i) - vY);
    if erro ~= 0
        contErro = contErro + 1;
    end 
    % fim da verifica��o de erro
    
end % Final dos testes

% Apresenta��o de resultados
disp(strcat('>> Classificador PERCEPTRON'));
disp(strcat('>> Metodo HOLD OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str((contErro/45)*100), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - (contErro/45)*100), '%'));
disp('-------------------------------------------------------');

