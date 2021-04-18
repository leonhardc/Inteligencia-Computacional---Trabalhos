% EXTREME LEARNING MACHINE - ELM - 10-FOLD

base = load('iris_log.dat');
format long
epocas = 10; % Quantidade de épocas de treinamento
cont = 0; 
q = 4; % numero de neurônios da camada oculta (regra do ponto médio)
p = 4; % numero de entradas de cada neurônio
a = 0; b = 0.1; % Intervalo dos pesos [0,1]

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
    
    X_treino = [(-1)*ones(1,149) ; X_treino]; 
    X_teste = [(-1)*ones(1,1) ; X_teste]; 
    
    % ELM -----------------------------------------------------------------
    % ---------------------------------------------------------------------
    % TREINAMENTO DA REDE
    W = a + (b-a).*randn(q , p+1); % Gerar numeros aleatorios uniformes - pesos da camada oculta
    Z = 1./(1 + exp(-(W*X_treino))); % Saída da camada oculta - já aplicada a função de ativação

    M = Y_treino*Z'*((Z*Z')^(-1)); % Pesos da camada de saída

    % FIM DO TREINAMENTO DA REDE

    % TESTE DE GENERALIZAÇÃO

    Z_teste = 1./(1 + exp( -(W*X_teste))); % APLICAÇÃO NA CAMADA OCULTA

    A_teste = 1./(1 + exp( -(M*Z_teste))); % APLICAÇÃO NA CAMADA DE SAÍDA
    
    if sum((max(A_teste(: , 1)) == A_teste(: , 1)) == Y_teste')/3 ~= 1
        cont = cont + 1;    
    end 
end

disp(strcat('>> Classificador ELM'));
disp(strcat('>> Metodo LEAVE-ONE-OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str(cont/150*100), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - cont/150*100), '%'));
disp('-------------------------------------------------------');
