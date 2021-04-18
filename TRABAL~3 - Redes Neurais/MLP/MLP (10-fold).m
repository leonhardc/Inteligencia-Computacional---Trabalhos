% MLP - 10-FOLD
% Quantidade de neuronios da camada oculta, (pela regra do valor médio) = 4
% Quantidade de neurônios da camada de saída = 3

base = load('iris_log.dat');
format long
qt_fi = 15;
epocas = 10; % Quantidade de épocas de treinamento
soma_erros = 0; 
Eta = 0.00000011; % Passo de aprendizagem

% Normalização dos valores da base 
X_normal = base(: , 1:4);

for i = 1:4
    X_normal(: , i) = (X_normal(: , i) - min(X_normal(: , i)))/...
    (max(X_normal(: , i) - min(X_normal(: , i))));
end 

base(: , 1:4) = X_normal;
% Fim da normalização



for z = 1:10  % Loop externo - contador de partições na base      
    
    % DEFINIÇÃO DOS CONJUNTOS DE TREINAMENTO E TESTE ----------------------
    % ---------------------------------------------------------------------
    
    % partição de teste
    X_teste = base((z-1)*15+1:qt_fi*z , 1:4)';
    Y_teste = base((z-1)*15+1:qt_fi*z , 5:7);    
    % partição de treino
    
    % primeiro caso - primeira iteração
    if z  == 1
        X_treino = base(16:150 , 1:4)';
        Y_treino = base(16:150 , 5:7)';
    end 
    
    % segundo caso - qualquer iteração que nao seja a primeira nem a ultima
    if z ~= 1 && z ~= 10
        X_treinoin = base(1:(z-1)*15, 1:4)';
        Y_treinoin = base(1:(z-1)*15, 5:7)';
        
        X_treinofi = base(((z-1)*15)+16 : 150, 1:4)';
        Y_treinofi = base(((z-1)*15)+16 : 150, 5:7)';
        
        X_treino = [X_treinoin , X_treinofi];
        Y_treino = [Y_treinoin , Y_treinofi];        
    end
    
    % terceio caso - ultima iteração    
    if z == 10
        X_treino = base(1:135 , 1:4)';
        Y_treino = base(1:135 , 5:7)';
    end 
    
    X_treino = [(-1)*ones(1,135) ; X_treino];
    X_teste = [(-1)*ones(1,15) ; X_teste];     
    contErro = 0;

    W = rand(5 , 4); % Vetor de pesos da camada oculta 
    M = rand(5 , 3); % Vetor de pesos da camada de saida    
    
    % MLP -----------------------------------------------------------------
    % ---------------------------------------------------------------------
    
    for epoca = 1:epocas % Loop externo - quantidade de epocas - Início do treinamento
     
        Z = 1./(1 + exp(-(X_treino'*W))); % Matriz de saída da camada oculta - já aplicada a função degrau
        Z = [-ones(135 , 1) Z]; 
        Z_linha = Z(: , 2:5).*(1 - Z(: , 2:5)); % Derivada da função de saída da camada oculta
        O = 1./(1 + exp(-(Z*M))); % Matriz de saída da camada de saída - já aplicada a função degrau
        O_linha = O.*(1 - O); % Derivada da função de saída da camada de saída    
        Ek = (Y_treino - O')'; % Erro associado a camada de saída

        % Treino da Camada de Saída
        M = M + Eta*(Z'*(Ek.*O_linha));
        % Fim do Treino da camada de saída

        M_linha = M(2:5 , :); % Vetor para calculo do erro da camada oculta
        Ei = M_linha*(Ek.*O_linha)'; % Erro associado a cada neurônio da camada oculta   

        % Treino da camada oculta   
        W = W + X_treino*(Eta*Ei'.*Z_linha); 
        % Fim do Treino da Camada de entrada

    end % Fim do treinamento

    % Teste da Rede 
    % Calculo da camada oculta
    
    Z_teste = 1./(1 + exp(-(X_teste'*W))); % Função de ativação da camada oculta - Entrada da camada de saída
    Z_teste = [-ones(15 , 1) Z_teste]; % Atualização da função de ativação da camada oculta  - Entrada da camada de saída

    % Calculo da camada de Saída 
    
    O_teste = 1./(1 + exp(-(Z_teste*M)));
    % Fim do Teste da Rede
    qt_erros = 0;
    % Calculo da quantidade de erros
    for i = 1:15  
        if sum(Y_teste(i , :) == (max(O_teste(i , :)) == O_teste(i,:)))/3 ~= 1
            qt_erros = qt_erros + 1;
        end     
    end
    soma_erros = soma_erros + (qt_erros/45)*100;
end     

disp(strcat('>> Classificador MLP'));
disp(strcat('>> Metodo 10-FOLD'));
disp(strcat('>> Porcentagem de Erro: ', num2str(soma_erros/10), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - soma_erros/10), '%'));
disp('-------------------------------------------------------');

