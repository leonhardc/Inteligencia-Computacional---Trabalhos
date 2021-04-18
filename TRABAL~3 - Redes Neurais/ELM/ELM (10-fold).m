% EXTREME LEARNING MACHINE - ELM - 10-FOLD

base = load('iris_log.dat');
format long
qt_fi = 15;
epocas = 10; % Quantidade de �pocas de treinamento
soma_erros = 0; 
q = 4; % numero de neur�nios da camada oculta (regra do ponto m�dio)
p = 4; % numero de entradas de cada neur�nio
a = 0; b = 0.1; % Intervalo dos pesos [0,1]

% Normaliza��o dos valores da base 
X_normal = base(: , 1:4);

for i = 1:4
    X_normal(: , i) = (X_normal(: , i) - min(X_normal(: , i)))/...
    (max(X_normal(: , i) - min(X_normal(: , i))));
end 

base(: , 1:4) = X_normal;
% Fim da normaliza��o


for z = 1:10  % Loop externo - contador de parti��es na base      
    
    % DEFINI��O DOS CONJUNTOS DE TREINAMENTO E TESTE ----------------------
    % ---------------------------------------------------------------------
    
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
    contErro = 0;

    W = rand(5 , 4); % Vetor de pesos da camada oculta 
    M = rand(5 , 3); % Vetor de pesos da camada de saida    
    
    % ELM -----------------------------------------------------------------
    % ---------------------------------------------------------------------
    % TREINAMENTO DA REDE
    W = a + (b-a).*randn(q , p+1); % Gerar numeros aleatorios uniformes - pesos da camada oculta
    Z = 1./(1 + exp(-(W*X_treino))); % Sa�da da camada oculta - j� aplicada a fun��o de ativa��o

    M = Y_treino*Z'*((Z*Z')^(-1)); % Pesos da camada de sa�da

    % FIM DO TREINAMENTO DA REDE

    % TESTE DE GENERALIZA��O

    Z_teste = 1./(1 + exp( -(W*X_teste))); % APLICA��O NA CAMADA OCULTA

    A_teste = 1./(1 + exp( -(M*Z_teste))); % APLICA��O NA CAMADA DE SA�DA
    
    % CONTAR QUANTIDADE DE ERROS
    
    cont = 0;
    for i = 1:15
        if sum((max(A_teste(: , i)) == A_teste(: , i)) == Y_teste(: , i))/3 ~= 1
            cont = cont + 1;
        end 
    end 
    
    soma_erros = soma_erros + (cont/15)*100;
end    

disp(strcat('>> Classificador ELM'));
disp(strcat('>> Metodo 10-FOLD'));
disp(strcat('>> Porcentagem de Erro: ', num2str(soma_erros/10), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - soma_erros/10), '%'));
disp('-------------------------------------------------------');

