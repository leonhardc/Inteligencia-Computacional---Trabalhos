%   Perceptron - An�lise com 10-FOLD 
%   quantidade de neur�nios 3

base = load('iris_log.dat');

Eta = 0.5; % Passo de aprendizagem
epocas = 10; % Quantidade de �pocas de treinamento
q = 3;     % Quantidade de neuronios da camada de sa�da
contErroPercent = 0; % Contador de percentual de erros
qt_fi = 15;



for z = 1:10  % Loop externo - contador de parti��es na base      
    
    % parti��o de teste
    X_teste = base((z-1)*15+1:qt_fi*z , 1:4)';
    Y_teste = base((z-1)*15+1:qt_fi*z , 5:7)';    
    % parti��o de treino
    
    % primeiro caso - primeira itera��o
    if z  == 1
        X_treino = base(16:150 , 1:4)';
        Y_treino = base(16:150 , 5:7)';
    end 
    
    % segundo caso - qualquer itera��o que nao seja a primeira nem a ultima
    if z ~= 1 && z ~= 10
        X_treinoin = base(1:(z-1)*15, 1:4)';
        Y_treinoin = base(1:(z-1)*15, 5:7)';
        
        X_treinofi = base(((z-1)*15)+16 : 150, 1:4)';
        Y_treinofi = base(((z-1)*15)+16 : 150, 5:7)';
        
        X_treino = [X_treinoin , X_treinofi];
        Y_treino = [Y_treinoin , Y_treinofi];        
    end
    
    % terceio caso - ultima itera��o    
    if z == 10
        X_treino = base(1:135 , 1:4)';
        Y_treino = base(1:135 , 5:7)';
    end 
    
    X_treino = [(-1)*ones(1,135) ; X_treino]; 
    X_teste = [(-1)*ones(1,15) ; X_teste]; 
    W = rand(5 , q); % Vetor de pesos
    contErro = 0;

    for epoca = 1:epocas % Loop externo - quantidade de epocas - In�cio do treinamento

            for i = 1:135 % Loop Interno - quantidade de amostras      

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

    for i = 1:15 % In�cio dos testes
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
    end  
    
    
    contErroPercent =  contErroPercent + (contErro/15)*100;
end     

% Apresenta��o de resultados
disp(strcat('>> Classificador PERCEPTRON'));
disp(strcat('>> Metodo 10-FOLD'));
disp(strcat('>> Porcentagem de Erro: ', num2str(contErroPercent/10), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - contErroPercent/10), '%'));
disp('-------------------------------------------------------');


