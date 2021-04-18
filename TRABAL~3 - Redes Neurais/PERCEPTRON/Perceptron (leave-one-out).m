%   Perceptron - Análise com 10-FOLD 
%   quantidade de neurônios 3

base = load('iris_log.dat');

Eta = 0.1;
epocas = 10; % Quantidade de épocas de treinamento
q = 3;     % Quantidade de neuronios da camada de saída
contErro = 0; % Contador de percentual de erros

for i = 1:150  % Loop externo - contador de partições na base    
    Dist = [];
    % partição de teste
    X_teste = base(i , 1:4)';
    Y_teste = base(i , 5:7)';
    
    % partição de treino
    % primeiro caso - primeira iteração
    if i  == 1
        X_treino = base(2:150 , 1:4)';
        Y_treino = base(2:150 , 5:7)';
    end 
    
    % segundo caso - qualquer iteração que nao seja a primeira nem a ultima
    if i > 1 && i < 150
        X_treinoin = base(1:i-1, 1:4)';
        Y_treinoin = base(1:i-1, 5:7)';
        
        X_treinofi = base(i+1 : 150, 1:4)';
        Y_treinofi = base(i+1 : 150, 5:7)';
        
        X_treino = [X_treinoin , X_treinofi];
        Y_treino = [Y_treinoin , Y_treinofi];        
    end
    
    % terceio caso - ultima iteração    
    if i == 150
        X_treino = base(1:149 , 1:4)';
        Y_treino = base(1:149 , 5:7)';
    end   
    
    % aplicaçao direta do Perceptron

    X_treino = [(-1)*ones(1,149) ; X_treino]; 
    X_teste = [(-1)*ones(1,1) ; X_teste];
    W = rand(5 , q); % Vetor de pesos   
    
    for epoca = 1:epocas % Loop externo - quantidade de epocas - Início do treinamento

            for i = 1:149 % Loop Interno - quantidade de amostras      

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
    
    % Inicio do teste
    vY = [];
    for j = 1:q
        Uj = X_teste(: , 1)'*W(: , j);

        Yj = 1; % Yj - função de disparo                
        if Uj <= 0
            Yj = 0;
        end

        vY = [vY; Yj];
    end
    % Final do teste
    
    % Verificação se a resposta da rede está certa ou não
    erro = sum(Y_teste(: , 1) - vY);
    if erro ~= 0
        contErro = contErro + 1;
    end 
    % fim da verificação de erro    
end

% Apresentação de resultados
disp(strcat('>> Classificador PERCEPTRON'));
disp(strcat('>> Metodo LEAVE-ONE-OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str(contErro/150), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - contErro/150), '%'));
disp('-------------------------------------------------------');
