
% Esse script tem o intuito de mostrar o funcionamento do classificador KNN
% tendo como validação os métodos Hold out, 10-fold, e leave-one-out 
% Obs: Vale salientar que é usado somente a distancia Euclidiana. 

base = load('iris_log.dat');
k = 7;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Metodo leave-one-out (150 partições)
%
%


contAcertos = 0;

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
    
    % aplicaçao direta do KNN

    for j = 1:149 % verifica a distancia de cada amostra de treino
        dist = sqrt( sum( (X_teste(:,1) - X_treino(:,j)).^2 ) ); % calculo da distância Euclidiana
        Dist = [Dist ; dist]; % matriz com todas as 105 distâncias                 
    end 
    
    % retirar as k menores distancias da matriz Dist
    orgDist = sort(Dist);
    mDist = orgDist(1:k , 1); % k menores distancias
    
    % Achar o indice correspondente de cada elemento que tem menor
    % distância    
    Ind = []; % Matriz que guarda os indices dos menores valores da Matriz Dist

    for m = 1:149
        for p = 1:k
            if Dist(m , 1) == mDist(p , 1)
                if ~(ismember(m, Ind))
                    Ind = [Ind ; m];
                end 
            end 
        end 
    end 
    
        % Achar os valores dos rótulos dos k vizinhos mais próximos do valor de teste
    % associados aos indices da matriz Ind
    Rotulos_Y = [];

    for m = 1:k
        y_rot = Y_treino(: , Ind (m , 1) );
        Rotulos_Y = [Rotulos_Y , y_rot];
    end 
    
        % Descobrir o rotulo que aparece mais vezes
    cont1 = 0;
    cont2 = 0;
    cont3 = 0;

    for m = 1:k % loop para descobrir quantas vezes cada rotulo aparece
        % teste para o primeiro rotulo
        if (sum( Rotulos_Y(: , m) == [1;0;0] ))/3 == 1
            cont1 = cont1 + 1;
        end
        % teste para o segundo rotulo
        if (sum( Rotulos_Y(: , m) == [0;1;0] ))/3 == 1
            cont2 = cont2 + 1;
        end     
        % teste para o terceiro rotulo
        if (sum( Rotulos_Y(: , m) == [0;0;1] ))/3 == 1
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

    if sum(rot_amostra == Y_teste(: , 1))/3 == 1
        contAcertos = contAcertos + 1;
    end
end

qt_erros = 100 - (contAcertos/150)*100;
disp(strcat('>> Classificador KNN'));
disp(strcat('>> Metodo LEAVE-ONE-OUT'));
disp(strcat('>> Porcentagem de Erro: ', num2str(qt_erros), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - qt_erros), '%'));
disp('-------------------------------------------------------');
