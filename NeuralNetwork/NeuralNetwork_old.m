%% Simple Neural Network
% Jonas Müller Gonçalves - Engenharia Aeroespacial
% Algoritmos de Otimização
clear all; clc;

%% Dados de Entrada da Rede
a = 0.05;   % Valor de ajuste
rng(5);

%% Pesos dos Perceptrons
w1 = 0.11;
w2 = 0.21;
w3 = 0.12;
w4 = 0.08;
w5 = 0.14;
w6 = 0.15;

%% Input
f = @(x) 3.*x(1) - x(2); % Função de referência
ninputs = 3; % Nº de Pontos de Treinamento

for ip = 1:ninputs
    inputs(ip,:) = [randi([1 10]) randi([1 10])];   % Gera inputs randômicos para a entrada
end

for ia = 1:ninputs
    actual(ia,:) = [f(inputs(ia,:))];   % Calcula a saída espera a partir da função de referência
end

% Auxiliares
prediction = 0;
iter=0;
ierr = 1;

%% Treino da Rede
while ierr == 1
    for j = 1:size(inputs,1)
        wa = [w1 w3;w2 w4];
        wb = [w5;w6];
        hidden1 = inputs(j,:)*wa;
        outputs = hidden1*wb;
        delta(j,1) = outputs - actual(j,1);
        
        %% Erro
        Error_aux(j,1) = 0.5*(delta(j,1))^2;
        
        %% Backpropagation
        i1 = inputs(j,1);
        i2 = inputs(j,2);
        
        h1 = i1*w1 + i2*w2;
        h2 = i1*w3 + i2*w4;
        h(:,j) = [h1;h2];
        
    end
    
    WB = wb - a.*sum(delta'.*h,2);
    WA = wa - a.*wb'.*[sum(delta.*inputs,1)'];
    Error = sum(Error_aux);
    
    w1 = WA(1,1);
    w2 = WA(2,1);
    w3 = WA(1,2);
    w4 = WA(2,2);
    w5 = WB(1,1);
    w6 = WB(2,1);
    
    %% Contador
    iter=iter+1;
    
    if Error < 0.1 || iter > 1000
        ierr =0;
    end
    
end