%% Bee Algorithm
% Jonas Müller
clear all; clc;

rng(2);
%% Inicialização da Colméia
f = @(x) 100*(x(2)-x(1).^2).^2+(1-x(1)).^2; % Função Objetivo
dominio=[-3 3;-3 3];                     % Domínio das nvar variaveis

n_abelhas = 5;   % Nº de abelhas na colméia
n_var = 2;  % Variáveis de projeto
seg_points = 3; % Número de pontos analisados pelas seguidoras
ct1=1;ct2=1;

% Inicializa as Operárias
for icol = 1:n_var
    for ivar = 1:n_abelhas
        colmeia1(ivar,icol) = dominio(icol,1) + rand*(dominio(icol,1)-dominio(icol,2));
    end
end

% Checando se o chute inicial está dentro do domínio
for ipart=1:n_abelhas
    for ivariab=1:n_var
        if colmeia1(ipart,ivariab) < dominio(ivariab,1)
            fora_dominio_menor(ct1,ivariab) = colmeia1(ipart,ivariab); ct1=ct1+1;
            colmeia1(ipart,ivariab) = rand*dominio(ivariab,1);  % Induz o retorno da partícula que passou
        elseif colmeia1(ipart,ivariab) >  dominio(ivariab,2)
            fora_dominio_maior(ct2,ivariab) = colmeia1(ipart,ivariab); ct2=ct2+1;
            colmeia1(ipart,ivariab) = rand*dominio(ivariab,2);  % Induz o retorno da partícula que passou
        end
    end
end

%Calcula a função para a colmeia inicial
% for ifunc=1:n_abelhas
%     resp_inicial(ifunc,1) = f(colmeia1(ifunc,:));
% end

% Distribuindo as Seguidoras
% for i=1:n_abelhas
%     for j=1:n_var
%         seguidoras1(i,j)=colmeia1(i,j) + rand*(colmeia1(i,j) - colmeia1(randi([1 n_abelhas]),j));
%     end
% end

colmeia=colmeia1; seguidoras=seguidoras1;
parada=0;iter=0;
while parada==0
    iter=iter+1;
    c=1;
    
    for ifunc=1:n_abelhas
        resp_f(ifunc,1) = f(colmeia(ifunc,:));
    end

    % Distribuindo as Seguidoras
    for i=1:n_abelhas
        for j=1:n_var
            seguidoras(i,j)=colmeia(i,j) + rand*(colmeia(i,j) - colmeia(randi([1 n_abelhas]),j));
        end
    end
    
    for k=1:size(seguidoras,1)
        func_seguidoras(k,1) = f(seguidoras(k,:));
    end
    
    % Retornando para a colméia com as melhores posições
    cont=1;
    for i=1:n_abelhas
        if f(seguidoras(i,:)) > f(colmeia(i,:))
            retorno(cont,:) = seguidoras(i,:);
            cont=cont+1;
        else
            retorno(cont,:) = colmeia(i,:);
            cont=cont+1;
        end
    end
    
    % Calcula a f para as melhores posições
    for i=1:n_abelhas
        resp_seg(i,1) = f(retorno(i,:));
    end
    
    
    % Calcula as novas probabilidades
    for i=1:n_abelhas
        Pi(i,1) = resp_seg(i,1)/sum(resp_seg);
    end
    
    Pif(1,1) = 0;
    
    for i=1:n_abelhas
        Pi_aux = sum(Pi(1:i,1));
        Pif(i+1,1) = Pi_aux;
    end
    
    
    % Gira a roleta e Atribui a nova colméia relativo a probabilidade da roleta
    for j=1:n_abelhas
        aleatorio = rand;
        for i=1:n_abelhas
            if Pif(i,1) < aleatorio && aleatorio <= Pif(i+1,1)
                a=1; armazena(j,1) = Pif(i,1);
                colmeia(i,:) = retorno(i,:);
            end
        end
    end
    
    a=1;
end

