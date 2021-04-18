% Esse script tem o intuito de mostrar o funcionamento do classificador KNN
% tendo como validação os métodos Hold out, 10-fold, e leave-one-out 
% Obs: Vale salientar que é usado somente a distancia Euclidiana. 

base = load('iris_log.dat');
k = 7;


%                   Metodo 10-fold (10 partições)



% Tamanho de cada partição é igual a 150/10 = 15 elementos

qt_fi = 15;
pt_erro = [];

for z = 1:10  % Loop externo - contador de partições na base
    
    contAcertos = 0;
    
    % partição de teste
    X_teste = base((z-1)*15+1:qt_fi*z , 1:4)';
    Y_teste = base((z-1)*15+1:qt_fi*z , 5:7)';
    
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
    
    % aplicaçao direta do KNN   
    
        
    for i = 1:15 % Loop externo - verifica cada amostra de teste
        Dist = [];

        for j = 1:135 % Loop interno - verifica cada amostra de treino
            dist = sqrt( sum( (X_teste(:,i) - X_treino(:,j)).^2 ) ); % calculo da distância Euclidiana
            Dist = [Dist ; dist]; % matriz com todas as 105 distâncias                 
        end 
        % retirar as k menores distancias da matriz Dist
        orgDist = sort(Dist);
        mDist = orgDist(1:k , 1); % k menores distancias

        % Achar o indice correspondente de cada elemento que tem menor
        % distância    
        Ind = []; % Matriz que guarda os indices dos menores valores da Matriz Dist

        for n = 1:135
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

        if sum(rot_amostra == Y_teste(: , i))/3 == 1
            contAcertos = contAcertos + 1;
        end 
    end
    
    porct_a = (contAcertos/15)*100; % Acurácia do classificador segundo HOLD OUT
    porct_e = 100 - porct_a;
    pt_erro = [pt_erro; porct_e];
end     

Erro = sum(pt_erro)/10; % erro para 10-fold

disp(strcat('>> Metodo 10-FOLD'));
disp(strcat('>> Porcentagem de Erro: ', num2str(Erro), '%'));
disp(strcat('>> Porcentagem de Acertos: ', num2str(100 - Erro), '%'));
disp('-------------------------------------------------------');

