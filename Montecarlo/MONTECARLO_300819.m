%% Engenharia Aeroespacial - Algoritmos de otimização
% Jonas Müller Gonçalves
% Método MonteCarlo
% 30.08.2019
clear all; clc;
%% Parte 1
N = 1000;
cont = 0;
% rns(222); % seta os mesmos valores para rand

for i = 1:N
    x = rand;
    y = rand;
    d = sqrt(x^2+y^2);
    if d<=1
        cont = cont + 1;
        plot(x,y,'r*');
    end
    plot(x,y,'bo'); hold on;
end

Erro = (cont/N)*4 - pi;
disp(['O valor do teste é ',num2str(Erro+pi)]);
disp(['A diferença entre o valor e pi é ',num2str(Erro)]);

%% Parte 2
f = @(x) x(1)^2 + x(2)^2 -2*x(1) - 2*x(2) + 2;  % Função

N = 10000;
x_obj = 1e5;
xmax = 10;
xmin = -10;

for i = 1:N
    x(1) = xmin+rand*(xmax-xmin);
    x(2) = xmin+rand*(xmax-xmin);
    
    if f(x) < x_obj;
        x_obj = f(x);
        melhor = x;
    end
    
end
melhor_antigo = melhor;

%% Parte 3
% f = @(x) x(1)^2 + x(2)^2 -2*x(1) - 2*x(2) + 2;  % Função
% 
% N = 10000;
% x_obj = 1e5;
% xmax = 10;
% xmin = -10;

for i = 1:N
    x(1) = melhor(1)+rand*(xmax-xmin)/5 - (xmax-xmin)/5;
    x(2) = melhor(2)+rand*(xmax-xmin)/5 - (xmax-xmin)/5;
    
    if f(x) < x_obj;
        x_obj = f(x);
        melhor = x;
    end
    
end


