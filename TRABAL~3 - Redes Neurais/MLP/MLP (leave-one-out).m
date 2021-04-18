% MLP - 10-FOLD
% Quantidade de neuronios da camada oculta, (pela regra do valor médio) = 4
% Quantidade de neurônios da camada de saída = 3

base = load('iris_log.dat');
format long
qt_erros = 0;
epocas = 10;
Eta = 0.00000011; % Passo de aprendizagem

% Normalização dos valores da base
X_normal = base(: , 1:4);

for i = 1:4
    X_normal(: , i) = (X_normal(: , i) - min(X_normal(: , i)))/...
    (max(X_normal(: , i) - min(X_normal(: , i))));
end 

base(: , 1:4) = X_normal;
% Fim da normalização


for i = 1:150  % Loop externo - contador de partições na base   
    
    % partição de teste
    X_teste = base(i , 1:4)';
    Y_teste = base(i , 5:7);
    
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
    
    % MLP -----------------------------------------------------------------
    % ---------------------------------------------------------------------

    X_treino = [(-1)*ones(1,149) ; X_treino]; 
    X_teste = [(-1)*ones(1,1) ; X_teste];
    
    W = rand(5 , 4); % Vetor de pesos da camada oculta 
    M = rand(5 , 3); % Vetor de pesos da camada de saida
    
    for epoca = 1:epocas % Loop externo - quantidade de epocas - Início do treinamento

        Z = 1./(1 + exp(-(X_treino'*W))); % Matriz de saída da camada oculta - já aplicada a função degrau
        Z = [-ones(149 , 1) Z]; 
        Z_linha = Z(: , 2:5).*(1 - Z(: , 2:5)); % derivada da função de saída da camada oculta
        O = 1./(1 + exp(-(Z*M))); % Matriz de saída da camada de saída - já aplicada a função degrau
        O_linha = O.*(1 - O); % derivada da função de saída da camada de saída    
        Ek = (Y_treino - O')'; % erro associado a camada de saída

        % Treino da Camada de Saída
        M = M + Eta*(Z'*(Ek.*O_linha));
        % Fim do Treino da camada de saída

        M_linha = M(2:5 , :); % vetor para calculo do erro da camada oculta
        Ei = M_linha*(Ek.*O_linha)'; % Erro associado a cada neurônio da camada oculta   

        % Treino da camada oculta   
        W = W + X_treino*(Eta*Ei'.*Z_linha); 
        % Fim do Treino da Camada de entrada

    end % Fim do treinamento

    % Teste da Rede 
    % Calculo da camada oculta    
    Z_teste = 1./(1 + exp(-(X_teste'*W))); % Função de ativação da camada oculta - Entrada da camada de saída
    Z_teste = [-ones(1 , 1) Z_teste]; % Atualização da função de ativação da camada oculta  - Entrada da camada de saída

    % Calculo da camada de Saída 
    Us_teste = Z_teste*M;
    O_teste = 1./(1 + exp(-Us_teste));
    % Fim do Teste da Rede
    
    % Calculo da quantidade de erros
     
    if sum(Y_teste(1 , :) == (max(O_teste(1 , :)) == O_teste(1,:)))/3 ~= 1
        qt_erros = qt_erros + 1;
    end     
       
end

% Apresentação de resultados
disp(strcat('>> Classificador MLP'));
disp(strcat('>> Metodo LEAVE-ONE-OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str((qt_erros/150)*100), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - (qt_erros/150)*100), '%'));
disp('-------------------------------------------------------');
