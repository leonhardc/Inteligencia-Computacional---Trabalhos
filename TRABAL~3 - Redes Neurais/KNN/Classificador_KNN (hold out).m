%
% Esse script tem o intuito de mostrar o funcionamento do classificador KNN
% tendo como validação os métodos Hold out, 10-fold, e leave-one-out 
% Obs: Vale salientar que é usado somente a distancia Euclidiana. 

base = load('iris_log.dat');


%
% Método HOLD OUT (70% treinamento (105 amostras) e 30% teste (45 amostras))
%
% 
%

k = 7; % escolha arbitrária de K, para determinar os K vizinhos mais proximos da amostra de teste. 

% Grupo de Treino
X_treino = base(1:105 , 1:4)';
Y_treino = base(1:105 , 5:7)';

% Grupo de Teste
X_teste = base(106:150 , 1:4)';
Y_teste = base(106:150 , 5:7)';

contAcertos = 0;


for z = 1:45 % Loop externo - verifica cada amostra de teste
    Dist = [];
    
    for j = 1:105 % Loop interno - verifica cada amostra de treino
        dist = sqrt( sum( (X_teste(:,z) - X_treino(:,j)).^2 ) ); % calculo da distância Euclidiana
        Dist = [Dist ; dist]; % matriz com todas as 105 distâncias                 
    end 
    % retirar as k menores distancias da matriz Dist
    orgDist = sort(Dist);
    mDist = orgDist(1:k , 1); % k menores distancias
    
    % Achar o indice correspondente de cada elemento que tem menor
    % distância    
    Ind = []; % Matriz que guarda os indices dos menores valores da Matriz Dist
    
    for n = 1:105
        for p = 1:k
            if Dist(n , 1) == mDist(p,1)
                Ind = [Ind ; n];
            end 
        end 
    end 
    
    % Achar os valores dos rótulos dos k vizinhos mais próximos do valor de teste
    % associados aos indices da matriz Ind
    Rotulos_Y = [];
    
    for n = 1:k
        y_rot = Y_treino(: , Ind (n , 1) );
        Rotulos_Y = [Rotulos_Y , y_rot];
    end 
    
    % Descobrir o rotulo que aparece mais vezes
    cont1 = 0;
    cont2 = 0;
    cont3 = 0;
    
    for n = 1:k % loop para descobrir quantas vezes cada rotulo aparece
        % teste para o primeiro rotulo
        if (sum( Rotulos_Y(: , n) == [1;0;0] ))/3 == 1
            cont1 = cont1 + 1;
        end
        % teste para o segundo rotulo
        if (sum( Rotulos_Y(: , n) == [0;1;0] ))/3 == 1
            cont2 = cont2 + 1;
        end     
        % teste para o terceiro rotulo
        if (sum( Rotulos_Y(: , n) == [0;0;1] ))/3 == 1
            cont3 = cont3 + 1;
        end        
    end
    
    % atribuir um rotulo a amostra 
    if cont1 > cont2 && cont1>cont3 % rotulo da amostra será [1;0;0]
        rot_amostra = [1;0;0];
    end 
    
    if cont2 > cont1 && cont2>cont3 % rotulo da amostra será [0;1;0]
        rot_amostra = [0;1;0];
    end 
    
    if cont3 > cont2 && cont3>cont1 % rotulo da amostra será [0;0;1]
        rot_amostra = [0;0;1];
    end 
    
    % verificar se houve erro ou nao
    
    if sum(rot_amostra == Y_teste(: , z))/3 == 1
        contAcertos = contAcertos + 1;
    end 
end 

porct_a = (contAcertos/45)*100; % Acurácia do classificador segundo HOLD OUT
disp('>> Metodo HOLD OUT:');
disp(strcat('>> Numero de Acertos: ', int2str(contAcertos)));
disp(strcat('>> Porcentagem de Acertos: ', num2str(porct_a),'%'));
disp(strcat('>> Porcentagem de Erros: ', num2str(100 - porct_a),'%'));
disp('-------------------------------------------------------');
disp('-------------------------------------------------------');









