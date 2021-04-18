% 
% Desenvolvimento de modelo de regress�o com duas varaveis regressoras
%
%
%
% Base de dados:

D = [  122 139 0.115; 
       114 126 0.120; 
       086 090 0.105; 
       134 144 0.090; 
       146 163 0.100; 
       107 136 0.120; 
       068 061 0.105; 
       117 062 0.080; 
       071 041 0.100; 
       098 120 0.115  ]; 

   
% defini��o dos vetores

vXUm = D(:,1);   % Primeira vari�vel independente (regressora)
vXDois = D(:,2); % Segunda vari�vel independente (regressora)
vY = D(:,3);     % Vari�vel dependente

% Definir tamanho de qualquer um dos vetores
 tam = size(vY);
 N = tam(1,1);
 
 % Definir a matrix X 
 mX = [ones(N,1) vXUm vXDois];

 vBeta = ((mX'*mX)^(-1))*mX'*vY;  % Matriz de coeficientes Beta
 
 yChapeu = mX*vBeta;              
 
 [x1,x2] = meshgrid(0:10:200);                 % Intervalo qualquer que contenha os pontos de amostragem 
 B = vBeta(2,1)*x1 + vBeta(3,1)*x2+vBeta(1,1); % Equa��o geral do superplano   
 surf(x1,x2,B)                                 % Plotar o plano que melhor se adequa ao meu conjunto de dados 
 hold on 
 plot3(vXUm, vXDois,vY, '*r');                 % O conjunto de dados propriamente dito
 xlabel('X1')
 ylabel('X2')
 zlabel('Y')
 title('Regress�o Multipla - Quest�o 03')
 
 % Medida de adequa��o ao modelo proposto, segundo a avalia��o R2
 adequacaoAoModelo = 1 - sum((vY - yChapeu).^2)/sum((vY - mean(vY)).^2) 
 
 % Final do script
 