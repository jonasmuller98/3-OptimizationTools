%% Bee Colony Optimization
% Jonas Muller Gonçalves
clear all;clc;
parada=0;
iter=0;
rng(2);

%% Dados da Função de Otimização
f = @(x) 100*(x(2)-x(1).^2).^2+(1-x(1)).^2; % Função Objetivo
dominio=[-3 3;-3 3];                     % Domínio das nvar variaveis

n_abelhas = 5;   % Nº de abelhas na colméia
n_variaveis = 2;  % Variáveis de projeto
n_seguidoras = 3; % Número de pontos analisados pelas seguidoras

%% Inicialização das Operárias Iniciais
for icol = 1:n_variaveis
    for ivar = 1:n_abelhas
        operarias_inicial(ivar,icol) = randi([-3 3]);%dominio(icol,1) + rand*(dominio(icol,1)-dominio(icol,2));
    end
end

operarias_inicial(4,1) = 2;   % excluir essa linha
operarias_inicial(4,2) = 2;   % excluir essa linha

%% Avalia a função nas Operárias Iniciais
for ifunc=1:n_abelhas
    resp_oper_inicial(ifunc,1) = f(operarias_inicial(ifunc,:));
end

%% Lança as Seguidoras Iniciais
for i=1:n_abelhas
    for n=1:n_seguidoras
        for j=1:n_variaveis
            seguidoras_inicial(n,j,i) = operarias_inicial(i,j)+rand;
        end
    end
end

%% Avalia a função nas Seguidoras Iniciais
for iabelha=1:n_abelhas
    for ifunc = 1:n_seguidoras
        resp_seg_inicial(ifunc,iabelha) = f(seguidoras_inicial(ifunc,:,iabelha));
    end
end

%% Comparação das funções entre seguidoras e operárias
% contador = zeros(5,1);
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

% % respostas=[resp_oper_inicial';resp_seg_inicial];
% for iabel=1:n_abelhas
%     [resp(iabel,1),iresp(iabel,1)] = max(respostas(:,iabel));
% end

%% Cálculo das Probabilidades
for iab=1:n_abelhas
    Pi_aux(iab,1) = respostas(iab,1)/sum(respostas(:,1));
end

Pi_Roleta(1,1) = 0;

for i=1:n_abelhas
    Pi_Roleta(i+1,1) = sum(Pi_aux(1:i,1));
end

% Gira a Roleta e atribui o Valor das Posições de Acordo com as
% Probabilidades

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
            teste(j,:) = respostas(armazenalinha1(j,1),1);
            teste2(j,:) = operarias_inicial(linhas(j,1),:);
            elseif contador2(j,1) == 0
            teste2(j,:) = seguidoras_inicial(linhas(j,1),:,colunas(j,1));    
            end
            
%             if iresp(j)==1
% %                 teste2(j,:) = operarias_inicial(armazenalinha(j,1),:);
%                 teste(j,1) = respostas(iresp(j),armazenalinha(j,1));
%             else
% %                 teste2(j,:) = seguidoras_inicial(iresp(j+1,1)-1,:,armazenalinha(j,1));
%                 teste(j,1) = respostas(iresp(j+1),armazenalinha(j,1));
%             end
             
        end
    end
end



a=1;
    armazena
armazenalinha1


