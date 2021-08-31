%% Engenharia Aeroespacial - Algoritmos de Otimização
% Jonas Muller Gonçalves
% 30.08.2019
% Nelder Mead Method
% INCOMPLETO ---
clear all; clc;

%% Criar a função para aproximação
f = @(x) x(1)^2 + x(2)^2 -2*x(1) - 2*x(2) + 2;  % Função Utilizada
alfa = 1; % input('Insira o valor de alpha: ')   %
beta = 2; % input('Insira o valor de beta: ')
gama = 0.5; % input('Insira o valor de gamma: ')
delta = 0.5;% input('Insira o valor de delta: ')
x0 = [2 3]; % input('Insira o ponto 1 do chute inicial i.e. [x0 y0]: ')
x1 = [1 4]; % input('Insira o ponto 2 do chute inicial i.e. [x1 y1]: ')
x2 = [3 1]; % input('Insira o ponto 3 do chute inicial i.e. [x2 y2]: ')
triang_area = 10;   % Chute da área inicial do triângulo

while triang_area > 0.5
    Xf = sort([f(x0) f(x1) f(x2)]);
    
    if Xf(1) < Xf(2) & Xf(1)  < Xf(3)
        primeiro = x0;
        if Xf(2) < Xf(3)
            segundo = x1;
            terceiro = x2;
        elseif Xf(3) < Xf(2)
            segundo = x2;
            terceiro = x1;
        end
    elseif Xf(2) < Xf(1) & Xf(2)  < Xf(3)
        primeiro = x1;
        if Xf(1) < Xf(3)
            segundo = x0;
            terceiro = x2;
        elseif Xf(3) < Xf(1)
            segundo = x2;
            terceiro = x0;
        end
    elseif Xf(3) < Xf(2) & Xf(3)  < Xf(1)
        primeiro = x2;
        if Xf(1) < Xf(2)
            segundo = x0;
            terceiro = x1;
        elseif Xf(2) < Xf(1)
            segundo = x1;
            terceiro = x0;
        end
    end
    
    ordenados = [primeiro;segundo;terceiro];
    N = length(Xf) - 1;
    
    centroide(1,1) = (1/N)*sum(ordenados(1:end-1,1));
    centroide(1,2) = (1/N)*sum(ordenados(1:end-1,2));
    
    Xr(1,1) = centroide(1,1) + alfa*(centroide(1,1) - ordenados(end,1));
    Xr(1,2) = centroide(1,2) + alfa*(centroide(1,2) - ordenados(end,2));
    
    if f(Xr) < Xf(1)
        Xe(1,1) = Xr(1,1) + beta*(Xr(1,1) - centroide(1,1));
        Xe(1,2) = Xr(1,2) + beta*(Xr(1,2) - centroide(1,2));
        if f(Xe) < f(Xr)
            ordenados(end,1) = Xe(1,1);
            ordenados(end,2) = Xe(1,2);
            
        else
            ordenados(end,1) = Xr(1,1);
            ordenados(end,2) = Xr(1,2);
        end
        
    elseif f(Xr) > Xf(1)
        Xc(1,1) = ordenados(end,1) + gama*(centroide(1,1) - ordenados(end,1));
        Xc(1,2) = ordenados(end,2) + gama*(centroide(1,2) - ordenados(end,2));
        if f(Xc) < Xf(3)
            ordenados(end,1) = Xc(1,1);
            ordenados(end,2) = Xc(1,2);
        else
            x1(1,1) = ordenados(1,1) + delta*(x1(1,1) - ordenados(1,1));
            x1(1,2) = ordenados(1,2) + delta*(x1(1,2) - ordenados(1,2))
            x2(1,1) = ordenados(1,1) + delta*(x2(1,1) - ordenados(1,1));
            x2(1,2) = ordenados(1,2) + delta*(x2(1,2) - ordenados(1,2));
        end
        
    elseif Xf(1) <= f(Xr) & f(Xr) < Xf(2)
        ordenados(end,1) = Xr(1,1);
        ordenados(end,2) = Xr(1,2);
    end
    
    determ = [x0 1;x1 1;x2 1];
    triang_area = 0.5*det(determ)
    
    if triang_area < 0
        triang_area = -triang_area;
    end
    
end


% Validação Matlab
% options = optimset('Tolfun',1e-3)
% [x,fval,exitflag,output] = fminsearch(f,x0);