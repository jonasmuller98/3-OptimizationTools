%% Engenharia Aeroespacial - Algoritmos de Otimização
% Nelder Mead - n Simplex
% Jonas Müller Gonçalves
clear all; clc;
%% Definição da função e variáveis do método
f = @(x) x(1)^2 + x(2)^2 -2*x(1) - 2*x(2) + 2;  % Função Utilizada
alfa = 1; % input('Insira o valor de alpha: ')   %
beta = 2; % input('Insira o valor de beta: ')
gama = 0.5; % input('Insira o valor de gamma: ')
delta = 0.5;% input('Insira o valor de delta: ')

%% Definição do vetor de simplex
P1 = [0.2 5]; % input('Insira o ponto 1 do chute inicial i.e. [x0 y0]: ')
P2 = [1.5 2]; % input('Insira o ponto 2 do chute inicial i.e. [x1 y1]: ')
P3 = [3 0.4]; % input('Insira o ponto 3 do chute inicial i.e. [x2 y2]: ')
erro = 1e-5;
ierro = 1;
Points = [P1;P2;P3];
iteracoes = 0;

%% Plot da função:
xx=-10:.2:10;
yy=-10:.2:10;
[X,Y]=meshgrid(xx,yy);
ff=X.^2+Y.^2-2.*X-2.*Y+2;
surf(X,Y,ff); hold on;

%% Laço Externo
while ierro == 1
    iteracoes = iteracoes + 1;
    %% Identifica os valores do Simplex
    P1 = Points(1,:);
    P2 = Points(2,:);
    P3 = Points(3,:);
    
    %% Organiza os simplex, da menor f para maior
    [Xf,iordem] = sort([f(P1);f(P2);f(P3)]);
    x1 = Points(iordem(1),:);
    x2 = Points(iordem(2),:);
    x3 = Points(iordem(3),:);
    x_novo = [x1;x2;x3];    
    N = length(Xf) - 1; % Obtém o n do simplex
    
    Xb = (1/N)*sum(x_novo(1:N,:),1);    % Obtém o centróide
    Xr = Xb + alfa*(Xb - x_novo(end,:));   % Reflete o pior ponto
    
    %% Comparações
    if f(x_novo(1,:))<=f(Xr) && f(Xr)<f(x_novo(2,:))
        x_novo(3,:)=Xr;
    elseif f(Xr)<f(x_novo(1,:))
        Xe=Xr+beta*(Xr-Xb);
        if f(Xe)<f(Xr), x_novo(3,:)=Xe; else, x_novo(3,:)=Xr; end
    elseif f(Xr)>f(x_novo(2,:))
        Xc=x_novo(3,:) + gama*(Xb-x_novo(3,:));
        if f(Xc)<f(x_novo(3,:))
            x_novo(3,:) = Xc;
        else
            for i=1:N+1
                x_novo(i,:)=x_novo(1,:)+delta*(x_novo(i,:)-x_novo(1,:));
            end
        end
    end
    %% Verificação do Erro
    if f(x_novo(1,:)) < erro
        ierro = 0;
    else
        Points = x_novo;
    end
    

    
    symplex_x(:,iteracoes) = x_novo(:,1);
    symplex_y(:,iteracoes) = x_novo(:,2);
    
    %% Plot dos Symplex:
%     A=[x_novo(1,1) x_novo(2,1) x_novo(3,1) x_novo(1,1)];
%     B=[x_novo(1,2) x_novo(2,2) x_novo(3,2) x_novo(1,2)];
%     C=[f(x_novo(1,:)) f(x_novo(2,:)) f(x_novo(3,:)) f(x_novo(1,:))];
%     plot3(A, B, C,'c-'); hold on;
end

for i = 1:length(symplex_x)
    plot(symplex_x(:,i),symplex_y(:,i),'r','linewidth',1.4); pause(0.5); hold on; 
end

% x_novo
% iteracoes