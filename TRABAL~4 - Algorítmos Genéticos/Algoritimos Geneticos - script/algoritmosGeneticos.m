% implementar um script seguindo o algoritmo GA para maximizar a fun??o 
% f(x,y) = sqrt(((x*sin(y*(pi/4))) + (x*sin(y*(pi/4))))^2)

geracoes = 10; % numero de gera??es para a popula??o
populacao = randi([0 1], 100, 20); % populacao 100 individuos x e 100 individuos y 
const = 1; % constante que ser? atribuido ao valor de qualquer nota se a mesma for zero

for i = 1:geracoes
    
    notas = []; % notas de cada gera?ao
    for j = 1:100 % dar as notas para cada individuo
        Xi_bin = populacao(j , 1:10); 
        Yi_bin = populacao(j , 11:20);
        
        X_aux = int2str(Xi_bin);
        Y_aux = int2str(Yi_bin);
        
        rX = bin2dec(X_aux); % numero real X correspondente ao binario encontrado
        rY = bin2dec(Y_aux); % numero real Y correspondente ao binario encontrado
        
        % leva os numeros encontrados para o intervalo [0 , 20]
        
        Xi = rX*(20/((2^10)-1)); % leva rX para o intervalo [0 20]
        Yi = rY*(20/((2^10)-1)); % leva rY para o intervalo [0 20]
        
        nota = abs((Xi*sin(Yi*(pi/4))) + (Yi*sin(Xi*(pi/4))));
        
        notas = [notas ; nota];
    end % fim da atibui??o de notas
    
    % checar se alguma nota foi zero, se sim, somar uma constante a ele
    if (sum(ismember(notas,0))  == 1)
        notas = notas + 1;
    end % fim da checagem
    
    % sele?ao de pais para proxima geracao
    pais = [];
    
    for l = 1:100 % implementa??o da roleta para escolha de pais
        k = 1;
        s = (sum(notas))*rand();
        aux = notas(k,1);
        
        while aux < s
            k = k + 1;
            aux = aux + notas(k,1);
        end 
        
        pais = [pais ; k]; % posi??o de todos os pais escolhidos
    end % fim da sele??o de pais
    
    % opera??o de crossover
    filhos = [];
    j = 1;
    while j < 100
        % filhos de X
        Xfilho1 = [populacao(pais(j,1), 1:5) populacao(pais(j+1,1), 6:10)];
        Xfilho2 = [populacao(pais(j+1,1), 1:5) populacao(pais(j,1), 6:10)];
        % filhos de Y
        Yfilho1 = [populacao(pais(j,1), 11:15) populacao(pais(j+1,1), 16:20)];
        Yfilho2 = [populacao(pais(j+1,1), 11:15) populacao(pais(j,1), 16:20)];
        
        nfilho = [Xfilho1 Yfilho1 ; Xfilho2 Yfilho2];
        
        filhos = [filhos ; nfilho]; % matriz de filhos nessa gera??o
        
        j = j + 2;
    end     
    % fim da operacao de crossover

    % inicio da opera??o de muta??o
    % probablidade da opera??o de muta??o = 0.5 % 
    for j = 1:100 % loop externo - controla o individuo que ir? acontecer a muta??o
        for k = 1:20 % loop interno - controla se o bit ir? receber muta??o ou nao
            result = randi([0 200]);
            if result == 1 
                filhos(j , k) = ~(filhos(j , k)); % opera??o de muta??o do bit
            end 
        end 
    end 
    
    % fim da opera??o de muta??o
    populacao = filhos; 
end 

% ao final, os melhores individuos devem ser escolhidos

% notas da populacao final 
notas = []; % notas da popula??o final
for j = 1:100 % dar as notas para cada individuo
    Xi_bin = populacao(j , 1:10); 
    Yi_bin = populacao(j , 11:20);

    X_aux = int2str(Xi_bin);
    Y_aux = int2str(Yi_bin);

    Xi = bin2dec(X_aux); % numero real X correspondente ao binario encontrado
    Yi = bin2dec(Y_aux); % numero real Y correspondente ao binario encontrado

    nota = abs((Xi*sin(Yi*(pi/4))) + (Yi*sin(Xi*(pi/4))));

    notas = [notas ; nota];
end % fim da atibui??o de notas

% saber quem s?o os melhores individuos

maior_nota = max(notas);

for j = 1:100
    if notas(j , 1) == maior_nota
        ind_maior_nota = j; % indice dos individuos x e y que tem maior nota
    end 
end 

X_maior_bin = populacao(ind_maior_nota , 1:10);
Y_maior_bin = populacao(ind_maior_nota , 11:20);

rX = bin2dec(int2str(X_maior_bin)); % numero real X correspondente ao binario encontrado
rY = bin2dec(int2str(Y_maior_bin)); % numero real Y correspondente ao binario encontrado

X_maior = rX*(20/((2^10)-1)); % leva rX para o intervalo [0 20]
Y_maior = rY*(20/((2^10)-1)); % leva rY para o intervalo [0 20]
Z_maior = abs((X_maior*sin(Y_maior*(pi/4))) + (Y_maior*sin(X_maior*(pi/4))));


% gerar superficie da fun??o e mostrar onde a solu??o se encontra na
% superficie

[X , Y] = meshgrid(0:0.5:20 , 0:0.5:20);
Z = abs((X.*sin(Y.*(pi/4))) + (Y.*sin(X.*(pi/4))));


mesh(X, Y ,Z) 
hold on
plot3(X_maior, Y_maior, Z_maior, '*r')

xlabel('Eixo x')
ylabel('Eixo y')
zlabel('Eixo z')
title(strcat('X = ',' ',num2str(X_maior), ' ', 'Y = ', ' ', num2str(Y_maior)))



