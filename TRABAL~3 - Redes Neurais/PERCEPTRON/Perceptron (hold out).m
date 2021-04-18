%   Perceptron - Análise com HOLD OUT (70% treino (105 amostras) e 30% teste (45 amostras))
%   quantidade de neurônios 3


base = load('iris_log.dat');

Eta = 0.1; % Passo de aprendizagem
q = 3;     % Quantidade de neuronios da camada de saída
epocas = 10; % Quantidade de épocas de treinamento
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

for epoca = 1:epocas % Loop externo - quantidade de epocas - Início do treinamento
    
        for i = 1:105 % Loop Interno - quantidade de amostras      
            
            for j = 1:q % Loop Interno - atualização do vetor de pesos
                Uj = X_treino(: , i)'*W(: , j);               
                                
                Yj = 1; % Yj - função de disparo
                
                if Uj <= 0
                    Yj = 0;
                end
                
                W(: , j) = W(: , j) + Eta*(Y_treino(j , i) - Yj)*X_treino(: , i); % Atualização do vetor de pesos
            end % fim da atualização do vetor de pesos
            
        end % Fim da verificação da quantidade de amostras      
    
end % Fim do treinamento

for i = 1:45 % Início dos testes
    vY = [];
    for j = 1:q
        Uj = X_teste(: , i)'*W(: , j);
        
        Yj = 1; % Yj - função de disparo                
        if Uj <= 0
            Yj = 0;
        end
        
        vY = [vY; Yj];        
    end 
    
    % Verificação se a resposta da rede está certa ou não
    erro = sum(Y_teste(: , i) - vY);
    if erro ~= 0
        contErro = contErro + 1;
    end 
    % fim da verificação de erro
    
end % Final dos testes

% Apresentação de resultados
disp(strcat('>> Classificador PERCEPTRON'));
disp(strcat('>> Metodo HOLD OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str((contErro/45)*100), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - (contErro/45)*100), '%'));
disp('-------------------------------------------------------');

