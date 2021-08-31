clear all;clc;
%% Valor objetivo
a = 0.05;
rng(5);
%% Pesos
w1 = 0.11;
w2 = 0.21;
w3 = 0.12;
w4 = 0.08;
w5 = 0.14;
w6 = 0.15;

%% Input
f = @(x) 3.*x(1) - x(2); %2

ninputs = 10; % Pontos de Treinamento

for ip = 1:ninputs
inputs(ip,:) = [randi([1 10]) randi([1 10])];
end

for ia = 1:ninputs
actual(ia,:) = [f(inputs(ia,:))];
end

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
    delta(1,j) = outputs - actual(j,1);
    Error_aux(j,1) = 0.5*(delta(1,j))^2;

    %% Prediction
%     prediction = (i1*w1 + i2*w2)*w5 + (i1*w3+i2*w4)*w6;

    %% Backpropagation
    i1 = inputs(j,1);
    i2 = inputs(j,2);
    
    h1(1,j) = i1*w1 + i2*w2;
    h2(1,j) = i1*w3 + i2*w4;
    
    WB = wb - a.*[sum(h1);sum(h2)].*sum(delta);
    WA = wa - sum(delta).*a.*[inputs(j,:)'].*wb';
    end
    
    Error = sum(Error_aux);
    
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

