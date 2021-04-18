% EXTREME LEARNING MACHINE - ELM - HOLD OUT

base = load('iris_log.dat');
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

% amostras para treino da rede
X_treino = base(1:105, 1:4)';
Y_treino = base(1:105, 5:7)';
X_treino = [(-1)*ones(1,105) ; X_treino]; 

% amostras para teste da rede
X_teste = base(106:150, 1:4)';
Y_teste = base(106:150, 5:7)';
X_teste = [(-1)*ones(1,45) ; X_teste]; 

% TREINAMENTO DA REDE
W = a + (b-a).*randn(q , p+1); % Gerar numeros aleatorios uniformes - pesos da camada oculta
Z = 1./(1 + exp(-(W*X_treino))); % Saída da camada oculta - já aplicada a função de ativação

M = Y_treino*Z'*((Z*Z')^(-1)); % Pesos da camada de saída

% FIM DO TREINAMENTO DA REDE

% TESTE DE GENERALIZAÇÃO

Z_teste = 1./(1 + exp( -(W*X_teste))); % APLICAÇÃO NA CAMADA OCULTA

A_teste = 1./(1 + exp( -(M*Z_teste))); % APLICAÇÃO NA CAMADA DE SAÍDA

% CONTADOR DE ERROS
cont = 0;
for i = 1:45
    if sum((max(A_teste(: , i)) == A_teste(: , i)) == Y_teste(: , i))/3 ~= 1
        cont = cont + 1;
    end 
end 

disp(strcat('>> Classificador ELM'));
disp(strcat('>> Metodo HOLD OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str((cont/45)*100), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - (cont/45)*100), '%'));
disp('-------------------------------------------------------');
