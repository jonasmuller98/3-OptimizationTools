clear all;clc;
%% Valor objetivo
a = 0.05;

%% Pesos
w1 = 0.11;
w2 = 0.21;
w3 = 0.12;
w4 = 0.08;
w5 = 0.14;
w6 = 0.15;

%% Input
f = @(x) 3.*x(1) - x(2); %2

i1 = 2; %4
i2 = 3; %6

i3 = 5; %10
i4 = 1; %0

% Pontos de Treinamento
inputs(1,:) = [i1 i2];
inputs(2,:) = [i3 i4];

actual(1,:) = [f(inputs(1,:))];
actual(2,:) = [f(inputs(2,:))];
    
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
        
        %% Erro
        Error_aux(j,1) = 0.5*(outputs - actual(j,1))^2;
    
    
    Error = sum(Error_aux);
    %% Prediction
    prediction = (i1*w1 + i2*w2)*w5 + (i1*w3+i2*w4)*w6;
    
    %% Backpropagation
    h1 = i1*w1 + i2*w2;
    h2 = i1*w3 + i2*w4;
    delta = prediction - actual(j,1);
    
    WB = wb - a.*[h1;h2].*delta;
    WA = wa - delta.*a.*[inputs(j,:)'].*WB;
    end
    w1 = WA(1,1);
    w2 = WA(2,1);
    w3 = WA(1,2);
    w4 = WA(2,2);
    w5 = WB(1,1);
    w6 = WB(2,1);
    
    %% Contador
    iter=iter+1;
    
    if Error < 0.0001 || iter > 1000
        ierr =0;
    end
end


%% Teste 

