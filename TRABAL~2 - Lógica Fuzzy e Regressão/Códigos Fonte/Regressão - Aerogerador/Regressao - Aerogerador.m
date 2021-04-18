%
% Esse script pretende mostrar uma relação P = f(v) entre a velocidade do 
% vento (v) e a potencia (P) gerada no aerogerador dada na base de dados 
% aerogerador.dat. O método usado será regressão multipla.
%
% Os modelos aqui apresentados (polinomios de grau 2, 3, 4 e 5) pretendem
% mostrar um grau de encaixe entre a função f(v) (modelo) e os dados reais 
% presentes na base de dados. Para, em casos de análise, haja a
% possibilidade de supor uma Potencia gerada no aerogerador dada por uma
% determinada velocidade do vento.
%
% Primeiramente temos que carregar a base de dados aerogerador.dat a qual
% vamos trabalhar.

format long;
DataBase = load('aerogerador.dat');

vX = DataBase(:,1); % carregar todas as linhas da coluna 1 da base no vetor vX (velocidade do vento)
vY = DataBase(:,2); % carregar todas as linhas da coluna 2 da base no vetor vY (potencia gerada no aerogerador)

%  Calculo do polinomio de segundo grau

tam = size(vX);       
N = tam(1,1); % achar o tamanho do vetor vX

% Calculo do polinomio de segundo grau
mXUm = [ones(N,1) vX vX.^2];                 % Matriz X para um polinomio de ordem 2
betaChapeuUm = ((mXUm'*mXUm)^(-1))*mXUm'*vY; % Calculando a matriz de coefcientes para
                                             % um polinomio de grau 2.  

YChapeuUm = mXUm*betaChapeuUm;           

% Calculo do polinomio de terceiro grau

mXDois = [ones(N,1) vX vX.^2 vX.^3];                 % Matriz X para um polinomio de ordem 3
betaChapeuDois = ((mXDois'*mXDois)^(-1))*mXDois'*vY; % Calculando a matriz de coefcientes para
                                                     % um polinomio de grau 3.  

YChapeuDois = mXDois*betaChapeuDois;           

% Calculo do Polinomio de quarto Grau

mXTres = [ones(N,1) vX vX.^2 vX.^3 vX.^4];           % Matriz X para um polinomio de ordem 4
betaChapeuTres = ((mXTres'*mXTres)^(-1))*mXTres'*vY; % Calculando a matriz de coefcientes para
                                                     % um polinomio de grau 4.  

YChapeuTres = mXTres*betaChapeuTres;                 

% Calculo do Polinomio de quinto grau

mXQuatro = [ones(N,1) vX vX.^2 vX.^3 vX.^4 vX.^5];           % Matriz X para um polinomio de ordem 5
betaChapeuQuatro = ((mXQuatro'*mXQuatro)^(-1))*mXQuatro'*vY; % Calculando a matriz de coefcientes para
                                                             % um polinomio de grau 3.  

YChapeuQuatro = mXQuatro*betaChapeuQuatro;   

% Plotar todas as funções

plot(vX,vY,'og',vX, YChapeuUm,'r', vX, YChapeuDois, 'b', vX, YChapeuTres, 'k', vX, YChapeuQuatro, 'm');
xlabel('Velocidade do Vento')
ylabel('Potência Gerada')
title('Aerogerador - Modelos de Regressão')
legend({'Dados Reais','Polinomio - Grau 2','Polinomio - Grau 3','Polinomio - Grau 4','Polinomio - Grau 5'},'Interpreter','latex','fontsize',10)

% Calculo das adequações dos modelos feitos peor regressão ao conjunto de
% dados

% Medida de adequação do primeiro modelo (coeficiente de determinação e 
% coeficiente de determinação ajustado)
adequacaoModeloUmR2 = 1- sum((vY - YChapeuUm).^2)/sum((vY - mean(vY)).^2)
adequacaoModeloUmR2aj = 1- (sum((vY - YChapeuUm).^2)/(N-3))/(sum((vY - mean(vY)).^2)/(N-1))

% Medida de adequação do segundo modelo (coeficiente de determinação e 
% coeficiente de determinação ajustado)
adequacaoModeloDoisR2 = 1- sum((vY - YChapeuDois).^2)/sum((vY - mean(vY)).^2)
adequacaoModeloDoisR2aj = 1- (sum((vY - YChapeuDois).^2)/(N-3))/(sum((vY - mean(vY)).^2)/(N-1))

% Medida de adequação do terceiro modelo (coeficiente de determinação e 
% coeficiente de determinação ajustado)
adequacaoModeloTresR2 = 1- sum((vY - YChapeuTres).^2)/sum((vY - mean(vY)).^2)
adequacaoModeloTresR2aj = 1- (sum((vY - YChapeuTres).^2)/(N-3))/(sum((vY - mean(vY)).^2)/(N-1))

% Medida de adequação do quarto modelo (coeficiente de determinação e 
% coeficiente de determinação ajustado)
adequacaoModeloQuatroR2 = 1- sum((vY - YChapeuQuatro).^2)/sum((vY - mean(vY)).^2)
adequacaoModeloQuatroR2aj = 1- (sum((vY - YChapeuQuatro).^2)/(N-3))/(sum((vY - mean(vY)).^2)/(N-1))

% final do script
 