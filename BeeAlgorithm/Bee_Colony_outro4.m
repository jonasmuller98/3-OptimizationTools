%% Bee Colony Optimization
% Jonas Muller Gon�alves
clear all;clc;
parada=0;
iter=0;
% rng(2);
iparada=0;
%% Dados da Fun��o de Otimiza��o
% f = @(x) 100*(x(2)-x(1).^2).^2+(1-x(1)).^2; % Fun��o Objetivo
% dominio=[-3 3;-3 3];                     % Dom�nio das nvar variaveis
f = @(x) (x+2*y-7).^2+(2*x+y-5).^2;
dominio=[-10 10];
n_abelhas = 50;   % N� de abelhas na colm�ia
n_variaveis = 2;  % Vari�veis de projeto
n_seguidoras = 10; % N�mero de pontos analisados pelas seguidoras
ipart=n_abelhas;

%% Inicializa��o das Oper�rias Iniciais
for icol = 1:n_variaveis
    for ivar = 1:n_abelhas
        operarias_novas(ivar,icol) = randi([-3 3]);%dominio(icol,1) + rand*(dominio(icol,1)-dominio(icol,2));
    end
end

% operarias_novas(4,1) = 2;   % excluir essa linha
% operarias_novas(4,2) = 2;   % excluir essa linha

while iparada==0
    iter=iter+1;
    operarias_inicial=operarias_novas
    
    % Confere se as oper�rias est�o no dom�nio
    for ipart=1:n_abelhas
        for ivariab=1:n_variaveis
            if operarias_novas(ipart,ivariab) < dominio(ivariab,1)
                operarias_inicial(ipart,ivariab) = rand*dominio(ivariab,1);  % Induz o retorno da part�cula que passou
            elseif operarias_novas(ipart,ivariab) >  dominio(ivariab,2)
                operarias_inicial(ipart,ivariab) = rand*dominio(ivariab,2);  % Induz o retorno da part�cula que passou
            end
        end
    end
    
    %% Avalia a fun��o nas Oper�rias Iniciais
    for ifunc=1:n_abelhas
        resp_oper_inicial(ifunc,1) = f(operarias_inicial(ifunc,:));
    end
    
    %% Lan�a as Seguidoras Iniciais
    for i=1:n_abelhas
        for n=1:n_seguidoras
            for j=1:n_variaveis
                seguidoras_inicial(n,j,i) = operarias_inicial(i,j)+rand;
            end
        end
    end
    
    % Confere se as seguidores est�o no dom�nio
    for ipart=1:n_abelhas
        for isegd=1:n_seguidoras
            for ivariab=1:n_variaveis
                if seguidoras_inicial(isegd,ivariab,ipart) < dominio(ivariab,1)
                    seguidoras_inicial(isegd,ivariab,ipart) = rand*dominio(ivariab,1);  % Induz o retorno da part�cula que passou
                elseif seguidoras_inicial(isegd,ivariab,ipart) >  dominio(ivariab,2)
                    seguidoras_inicial(isegd,ivariab,ipart) = rand*dominio(ivariab,2);  % Induz o retorno da part�cula que passou
                end
            end
        end
    end
    
    %% Avalia a fun��o nas Seguidoras Iniciais
    for iabelha=1:n_abelhas
        for ifunc = 1:n_seguidoras
            resp_seg_inicial(ifunc,iabelha) = f(seguidoras_inicial(ifunc,:,iabelha));
        end
    end
    
    %% Compara��o das fun��es entre seguidoras e oper�rias
    for i=1:n_abelhas
        for j=1:n_seguidoras
            if resp_oper_inicial(i,1) > max(resp_seg_inicial(:,i))
                respostas(i,1) = resp_oper_inicial(i,1);
                respostas(i,2) = i;
                respostas(i,3) = 1;
                contador(i,1) = 1; % contador verifica se foi ativado resp oper
                
            elseif resp_oper_inicial(i,1) < max(resp_seg_inicial(:,i))
                respostas(i,1) = max(resp_seg_inicial(:,i));
                [~,respostas(i,2)] = max(resp_seg_inicial(:,i));
                respostas(i,3) = i;
                contador(i,1) = 0; % contador verifica se foi ativado resp seg
            end
        end
    end
    
    %% C�lculo das Probabilidades
    for iab=1:n_abelhas
        Pi_aux(iab,1) = respostas(iab,1)/sum(respostas(:,1)); % probabilidade auxiliar
    end
    
    Pi_Roleta(1,1) = 0; % seta a primeira probabilidade como 0
    
    for i=1:n_abelhas
        Pi_Roleta(i+1,1) = sum(Pi_aux(1:i,1));  % calcula as pr�ximas probabilidades de 0 a 1
    end
    
    % Gira a Roleta e atribui o Valor das Posi��es de Acordo com as Probabilidades
    
    for j=1:n_abelhas
        aleatorio = rand;
        for i=1:n_abelhas
            if Pi_Roleta(i,1) < aleatorio && aleatorio <= Pi_Roleta(i+1,1)
                a=1; armazena(j,1) = Pi_Roleta(i,1);
                armazenalinha1(j,1) = i;
                contador2(j,1) = contador(i,1);
                colunas(j,1) = respostas(armazenalinha1(j,1),3);
                linhas(j,1) = respostas(armazenalinha1(j,1),2);
                
                if contador2(j,1) == 1
                    operarias_novas(j,:) = operarias_inicial(linhas(j,1),:);
                elseif contador2(j,1) == 0
                    operarias_novas(j,:) = seguidoras_inicial(linhas(j,1),:,colunas(j,1));
                end
            end
        end
    end
    
    if iter == 100
        iparada=1;
    end
    
    scatter(iter,f(operarias_novas(1,:)));hold on;
end

% fsurf(@(x,y) 100.*(y-x.^2).^2+(1-x).^2); xlim([-3 3]); ylim([-3 3]); hold on;
% scatter3(operarias_novas(1,1),operarias_novas(1,2),f(operarias_novas(1,:)));


