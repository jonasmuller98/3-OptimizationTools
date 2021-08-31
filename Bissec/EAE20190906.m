%% Algoritmos de Otimização
% Método da Bisseção
% 06.09.2019
clear all; clc;
%% Primeiro - Bissecção
  y1 = @(x) -(1/((x-0.3)^2+0.01) + 1/((x-0.9)^2+0.04) - 6);
% y1 = @(x) 2*x.^2 - 5*x - 5;
intervalo = -2:0.1:2;
dist = 1000;
ai = intervalo(1);
bi = intervalo(end);
bb = bi;
aa = ai;
iter = 1;
ierro = 1;

while ierro == 1
    x_meio = (aa+bb)/2;
    x_meio_e = (aa+x_meio)/2;
    x_meio_d = (bb+x_meio)/2;
    
    y_meio_e = y1(x_meio_e);
    y_meio_d = y1(x_meio_d);
    
    dist = abs(aa - bb)/(bi - ai);

    if dist<1e-6
        ierro = 0;
    else
        if y_meio_e > y_meio_d
            aa = x_meio_e;
        elseif y_meio_d > y_meio_e
            bb = x_meio_d;
        end
    end
    x_f(iter) = x_meio;
    iter = iter+1; 
end

for i = 1:size(intervalo,2);
y(i) = y1(intervalo(i));
end

for i = 1:size(x_f,2)
yf(i) = y1(x_f(i));
end
figure (1)
plot(intervalo,y);hold on;
scatter(x_f,yf);hold off;

%% Segundo - Golden Search
  y1 = @(x) -(1/((x-0.3)^2+0.01) + 1/((x-0.9)^2+0.04) - 6);
% y1 = @(x) 2*x.^2 - 5*x - 5;
intervalo = -2:0.1:2;
dist = 1000;
ai = intervalo(1);
bi = intervalo(end);
bb = bi;
aa = ai;
iter2 = 1;
ierro = 1;
alfa1 = (3-sqrt(5))/2;
alfa2 = 1-alfa1;
while ierro == 1
    x_meio = (aa+bb)/2;
    x_meio_e = aa + alfa1*(bb-aa);
    x_meio_d = aa + alfa2*(bb-aa);
    
    y_meio_e = y1(x_meio_e);
    y_meio_d = y1(x_meio_d);
    
    dist = abs(aa - bb)/(bi - ai);

    if dist<1e-6
        ierro = 0;
    else
        if y_meio_e > y_meio_d
            aa = x_meio_e;
        elseif y_meio_d > y_meio_e
            bb = x_meio_d;
        end
    end
    x_f(iter2) = x_meio;
    iter2 = iter2+1;  
end

for i = 1:size(intervalo,2);
y(i) = y1(intervalo(i));
end

for i = 1:size(x_f,2)
yf(i) = y1(x_f(i));
end
figure(2)
plot(intervalo,y);hold on;
scatter(x_f,yf);hold off;
