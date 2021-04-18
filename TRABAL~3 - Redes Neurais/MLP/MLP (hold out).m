% MLP - HOLD-OUT (70% treino(105 amostras), 30% teste (45 amostras))
% Quantidade de neuronios da camada oculta, (pela regra do valor m�dio) = 4
% Quantidade de neur�nios da camada de sa�da = 3

base = load('iris_log.dat');
format long

% Normaliza��o dos valores da base
X_normal = base(: , 1:4);

for i = 1:4
    X_normal(: , i) = (X_normal(: , i) - min(X_normal(: , i)))/...
    (max(X_normal(: , i) - min(X_normal(: , i))));
end 

base(: , 1:4) = X_normal;
% Fim da normaliza��o


Eta = 0.000011; % Passo de aprendizagem
epocas = 10; % Quantidade de �pocas de treinamento
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

for epoca = 1:epocas % Loop externo - quantidade de epocas - In�cio do treinamento
    
    Z = 1./(1 + exp(-(X_treino'*W))); % Matriz de sa�da da camada oculta - j� aplicada a fun��o degrau
    Z = [-ones(105 , 1) Z]; 
    Z_linha = Z(: , 2:5).*(1 - Z(: , 2:5)); % derivada da fun��o de sa�da da camada oculta
    O = 1./(1 + exp(-(Z*M))); % Matriz de sa�da da camada de sa�da - j� aplicada a fun��o degrau
    O_linha = O.*(1 - O); % derivada da fun��o de sa�da da camada de sa�da    
    Ek = (Y_treino - O')'; % erro associado a camada de sa�da
        
    % Treino da Camada de Sa�da
    M = M + Eta*(Z'*(Ek.*O_linha));
    % Fim do Treino da camada de sa�da
    
    M_linha = M(2:5 , :); % vetor para calculo do erro da camada oculta
    Ei = M_linha*(Ek.*O_linha)'; % Erro associado a cada neur�nio da camada oculta   
    
    % Treino da camada oculta   
    W = W + X_treino*(Eta*Ei'.*Z_linha); 
    % Fim do Treino da Camada de entrada
    
end % Fim do treinamento

% Teste da Rede 
% Calculo da camada oculta

Z_teste = 1./(1 + exp(-(X_teste'*W))); % Fun��o de ativa��o da camada oculta - Entrada da camada de sa�da
Z_teste = [-ones(45 , 1) Z_teste]; % Atualiza��o da fun��o de ativa��o da camada oculta  - Entrada da camada de sa�da

% Calculo da camada de Sa�da 
O_teste = 1./(1 + exp(-(Z_teste*M)));
% Fim do Teste da Rede
qt_erros = 0;
% Calculo da quantidade de erros
for i = 1:45  
    if sum(Y_teste(i , :) == (max(O_teste(i , :)) == O_teste(i,:)))/3 ~= 1
        qt_erros = qt_erros + 1;
    end     
end 

% Apresenta��o de resultados
disp(strcat('>> Classificador MLP'));
disp(strcat('>> Metodo HOLD OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str((qt_erros/45)*100), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - (qt_erros/45)*100), '%'));
disp('-------------------------------------------------------');