%% Bee Algorithm
% Jonas Müller 
clear all; clc;

rng(5);
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
        colmeia(ivar,icol) = dominio(icol,1) + rand*(dominio(icol,1)-dominio(icol,2));
    end
end

% Checando se o chute inicial está dentro do domínio
for ipart=1:n_abelhas
    for ivariab=1:n_var
        if colmeia(ipart,ivariab) < dominio(ivariab,1)
            fora_dominio_menor(ct1,ivariab) = colmeia(ipart,ivariab); ct1=ct1+1;
            colmeia(ipart,ivariab) = rand*dominio(ivariab,1);  % Induz o retorno da partícula que passou
        elseif colmeia(ipart,ivariab) >  dominio(ivariab,2)
            fora_dominio_maior(ct2,ivariab) = colmeia(ipart,ivariab); ct2=ct2+1;
            colmeia(ipart,ivariab) = rand*dominio(ivariab,2);  % Induz o retorno da partícula que passou
        end
    end
end

%Calcula a função para a colmeia inicial
for ifunc=1:n_abelhas
   resp_inicial(ifunc,1) = f(colmeia(ifunc,:)); 
end

parada=0;iter=0;
while parada==0
iter=iter+1;
c=1;

% Criando os pontos ao redor das abelhas operárias
localizax = [1 3 5]'; % generalizar 1:2:seg_points
localizay = [2 4 6]'; % generalizar 2:2:seg_points+1
cont=1;

for j=1:n_abelhas
    for i=1:size(localizax)
        seguidoras(localizax(i),j) = colmeia(cont,1)*rand + rand;
        seguidoras(localizay(i),j) = colmeia(cont,2)*rand + rand;
    end
    cont=cont+1;
end
c2=1;

% Calculando a função para as seguidoras
for j=1:n_abelhas
    for i=1:2:seg_points*2
        aux(1:2,1)=seguidoras(i:i+1,j);
        res_oper(c2,1) = f(aux);
%         indices(c2,1) = i;
        c2=c2+1;
    end
end

% Verificando os maiores
[res_op_max,ord_op_max] = sort(res_oper);
res_op_max = flip(res_op_max); ord_op_max = flip(ord_op_max);

% Retorna as abelhas com valores máximos


end

