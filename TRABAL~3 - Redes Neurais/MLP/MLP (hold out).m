% MLP - HOLD-OUT (70% treino(105 amostras), 30% teste (45 amostras))
% Quantidade de neuronios da camada oculta, (pela regra do valor médio) = 4
% Quantidade de neurônios da camada de saída = 3

base = load('iris_log.dat');
format long

% Normalização dos valores da base
X_normal = base(: , 1:4);

for i = 1:4
    X_normal(: , i) = (X_normal(: , i) - min(X_normal(: , i)))/...
    (max(X_normal(: , i) - min(X_normal(: , i))));
end 

base(: , 1:4) = X_normal;
% Fim da normalização


Eta = 0.000011; % Passo de aprendizagem
epocas = 10; % Quantidade de épocas de treinamento
Erros = []; % Quantidade de erros que a rede cometeu
contErro = 0; % Contador de erros para os testes da rede MLP


% amostras para treino da rede
X_treino = base(1:105, 1:4)';
Y_treino = base(1:105, 5:7)';
X_treino = [(-1)*ones(1,105) ; X_treino]; 

% amostras para teste da rede
X_teste = base(106:150, 1:4)';
Y_teste = base(106:150, 5:7);
X_teste = [(-1)*ones(1,45) ; X_teste]; 


W = rand(5 , 4); % Vetor de pesos da camada oculta 
M = rand(5 , 3); % Vetor de pesos da camada de saida

for epoca = 1:epocas % Loop externo - quantidade de epocas - Início do treinamento
    
    Z = 1./(1 + exp(-(X_treino'*W))); % Matriz de saída da camada oculta - já aplicada a função degrau
    Z = [-ones(105 , 1) Z]; 
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
Z_teste = [-ones(45 , 1) Z_teste]; % Atualização da função de ativação da camada oculta  - Entrada da camada de saída

% Calculo da camada de Saída 
O_teste = 1./(1 + exp(-(Z_teste*M)));
% Fim do Teste da Rede
qt_erros = 0;
% Calculo da quantidade de erros
for i = 1:45  
    if sum(Y_teste(i , :) == (max(O_teste(i , :)) == O_teste(i,:)))/3 ~= 1
        qt_erros = qt_erros + 1;
    end     
end 

% Apresentação de resultados
disp(strcat('>> Classificador MLP'));
disp(strcat('>> Metodo HOLD OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str((qt_erros/45)*100), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - (qt_erros/45)*100), '%'));
disp('-------------------------------------------------------');