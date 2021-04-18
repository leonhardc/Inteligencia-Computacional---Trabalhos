% 
% Retorno P_freio press�o que deve ser aplicada no pedal do feio quando o
% carro est� a uma velocida Vc, a velocidade da roda do carro � Vr e a 
% press�o no pedal do carro � Pp
% Obs: Ambos os parametros devem ser definidos no intervalo [0,100]
% Entrada:
%   Vc => Velocidade do Carro
%   Vr => Velocidade da Roda
%   Pp => Press�o no pedal
%
%   Exemplo de uso:
%   >> fuzzySet(30,40,50)
%
% ans = 
%
%   67

function P_freio = fuzzySet(Vc, Vr, Pp)
    
    % Fuzzyfica��o dos dados
    
    % Fuzzyfica��o da Velocidade do Carro 
    
    if Vc >= 0 && Vc <= 100
        pertVc_Rapido = trimf(Vc, [40 100 101]);
        pertVc_Medio = trimf(Vc, [20 50 80]);
        pertVc_Devagar = trimf(Vc, [-1 0 60]);
    end   
    
    % Fuzzyfica��o da Velocidade da Roda
    
    if Vr >= 0 && Vr <= 100
        pertVr_Rapido = trimf(Vr, [40 100 101]);
        pertVr_Medio = trimf(Vr, [20 50 80]);
        pertVr_Devagar = trimf(Vr, [-1 0 60]);
    end
    
    % Fuzzyfica��o da Press�o no pedal
    if Pp >= 0 && Pp <= 100
        pertPp_Alto = trimf(Pp, [50 100 101]);
        pertPp_Medio = trimf(Pp, [30 50 70]);
        pertPp_Baixo = trimf(Pp, [-1 0 50]);
    end
    
    % Aplica��o da inferencia de Mamdani
    
        % Regra 01
    apertarFreioR1 = pertPp_Medio;    
        % Regra 02
    apertarFreioR2 = min([pertPp_Alto pertVc_Rapido pertVr_Rapido]);
        % Regra 03
    liberarFreioR3 = min([pertPp_Alto pertVc_Rapido pertVr_Devagar]);
        % Regra 04
    liberarFreioR4 = pertPp_Baixo;
    
    
    % Defuzzyfica��o
    
    funcDefuzzy = [];
    fA = [];
    fS = [];
    apertarFreio = apertarFreioR1 + apertarFreioR2; % Regra de escolha das pertinencias
    liberarFreio = liberarFreioR3 + liberarFreioR4; % apresentadas no Slide de aula
    
    inter = [0:1:100];
    tamInter = 101;
    
    funcApertar = (trimf(inter, [0 100 101]))';
    funcSoltar = (trimf(inter, [-1 0 100]))';
    
        
    for i = 1:1:tamInter % Determina��o da fun��o de defuzifica��o       
        if funcApertar(i,1) > apertarFreio
            funcApertar(i,1) = apertarFreio;
        end 
        
        if funcSoltar(i,1) > liberarFreio
            funcSoltar(i,1) = liberarFreio;
        end
        
        funcDefuzzy = [funcDefuzzy  max(funcApertar(i,1), funcSoltar(i,1))];        
    end % fim da determina��o
  
    P_freio = (funcDefuzzy*inter')/sum(funcDefuzzy); % Metodo de Defuzzyfica��o - Centroide
    
    % Plotar gr�ficos relacionados
    
    fA = (trimf(inter, [0 100 101]))';
    fS = (trimf(inter, [-1 0 100]))';
    
    yY = [0:0.001:1];
    xX = P_freio;
  
    area(inter,funcDefuzzy)
    hold on
    plot(inter, fA, '--r', inter, fS, '--k',xX, yY,'or');
    
    
    xlabel('Intervalo - [0,100]')
    ylabel('Pertin�ncia - [0,1]')
    title(strcat('Apertar freio = ',' ',num2str(P_freio)))
    legend({'funcDefuzzy','funcApert', 'funcSoltar', 'Apertar Freio'},'Interpreter','latex','fontsize',10)  
        
end