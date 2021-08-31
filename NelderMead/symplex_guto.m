clc; clear all; close all;

% Aula 03 de Algoritmos de Otimização (DEM1124) - Algoritmo de Nelder-Mead.
% Aluno: Augusto Morcelli.
% Professor: Marcos Awruch.

% Definição dos parâmetros do método e variáveis gerais:
alfa=1; beta=2; gama=.5; delta=.5; symp=2;
cont=0; n=1; erro=1e-30; 
min=5; max=5.3; % Tamanho inicial do symplex.

% Definição da function:
f=@(x) x(1)^2+x(2)^2-2*x(1)-2*x(2)+2;

% Plot da função:
xx=-10:.2:10;
yy=-10:.2:10;
[X,Y]=meshgrid(xx,yy);
ff=X.^2+Y.^2-2.*X-2.*Y+2;
surf(X,Y,ff); hold on;

% Criação aleatória do symplex inicial.
for i=1:symp+1
    if symp<=2
        x(i,1)=min+rand*(max-min); x(i,2)=min+rand*(max-min);
    else
        x(i,1)=min+rand*(max-min); 
        x(i,2)=min+rand*(max-min); 
        x(i,3)=min+rand*(max-min);
    end
end

while n==1
    
    for i=1:symp+1
        res(i)=f(x(i,:)); % Cria o vetor de respostas f(x,y).
    end
    
    [res,ind]=sort(res); % Organiza as respostas em ordem crescente.
    
    for i=1:symp+1
        x_new(i,:)=x(ind(i),:); % Organiza o vetor x (f(x1)<f(x2)<f(x3)).
    end
    
    xbar=(1/symp)*sum(x_new(1:symp,:),1); % Obtém o centróide da figura.
    
    xr=xbar+alfa*(xbar-x_new(end,:)); % Refelte o ponto mais distante.
    
    % Árvore de possibilidades acerca do novo ponto xr:
    if f(x_new(1,:))<=f(xr) && f(xr)<f(x_new(2,:))
        x_new(3,:)=xr;
    elseif f(xr)<f(x_new(1,:))
        xe=xr+beta*(xr-xbar);
        if f(xe)<f(xr), x_new(3,:)=xe; else, x_new(3,:)=xr; end
    elseif f(xr)>f(x_new(2,:))
        xc=x_new(3,:)+gama*(xbar-x_new(3,:));
        if f(xc)<f(x_new(3,:))
            x_new(3,:)=xc;
        else
            for i=1:symp+1
                x_new(i,:)=x_new(1,:)+delta(x_new(i,:)-x_new(1,:));
            end
        end
    end
    
    % Condição para interrupção:
    if f(x_new(1,:))<erro, n=0; else x=x_new; end
    
    % Plot dos pontos:
    plot3(x_new(1,1),x_new(1,2),f(x_new(1,:)),'.c');
    plot3(x_new(2,1),x_new(2,2),f(x_new(2,:)),'.c');
    plot3(x_new(3,1),x_new(3,2),f(x_new(3,:)),'.c');
    
    % Plot dos Symplex:
    A=[x_new(1,1) x_new(2,1) x_new(3,1) x_new(1,1)];
    B=[x_new(1,2) x_new(2,2) x_new(3,2) x_new(1,2)];
    C=[f(x_new(1,:)) f(x_new(2,:)) f(x_new(3,:)) f(x_new(1,:))];
    plot3(A, B, C,'c-'); drawnow
end

% Faz a montagem dos resultados finais.
for i=1:symp+1
    res(i)=f(x(i,:));
end

[res,ind]=sort(res);

for i=1:symp+1
    x_new(i,:)=x(ind(i),:);
end

% Display dos resultados:
disp('------------------ Resultado -------------------------');
disp(['Melhor dupla de valores: x1 = ',num2str(x_new(1,1)),', x2 = ',num2str(x_new(1,2)),...
    newline, 'Mínimo encontrado: ',num2str(res(1,:))]);
