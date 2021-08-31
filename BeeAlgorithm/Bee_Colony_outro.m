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
respostas=[resp_oper_inicial';resp_seg_inicial];

for iabel=1:n_abelhas
        resp(iabel,1) = max(respostas(:,iabel));
end


% for iabel=1:n_abelhas
%     for iseg=1:n_seguidoras
%         if resp_seg_inicial(iseg,iabel) > resp_oper_inicial(iabel)
%             respostas(iabel,1) = resp_seg_inicial(iseg,iabel);
%             disp(['. ',num2str(resp_seg_inicial(iseg,iabel)),' é maior que ',num2str(resp_oper_inicial(iabel))]);
%         else
%             respostas(iabel,1) = resp_oper_inicial(iabel);
%             disp(['. ',num2str(resp_oper_inicial(iabel)),' é maior que ',num2str(resp_seg_inicial(iseg,iabel))]);
%         end
%     end
% end

%% Cálculo das Probabilidades

for iab=1:n_abelhas
%     for ipi=1:size(respostas,1)
        Pi(iab,1) = resp(iab,1)/sum(resp);
%     end
end


%% Inicia o loop
while parada==0;
%% Calcula as probabilidades

end


