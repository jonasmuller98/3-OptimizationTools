clear all; clc; close all;
% Caminho mínimo cidades
WA = [0 80 256 Inf(1,11)];%A
WB = [Inf 0 Inf 96 193 Inf(1,9)];%B
WC = [Inf(1,2) 0 Inf Inf 109 Inf(1,8)];%C
WD = [Inf(1,3) 0 Inf Inf 113 202 Inf(1,6)];%D
WE = [Inf(1,4) 0 Inf Inf Inf 136 Inf(1,5)];%E
WF = [Inf(1,5) 0 Inf Inf 100 Inf(1,5)];%F
WG = [Inf(1,6) 0 Inf Inf 127 Inf(1,4)];%G
WH = [Inf(1,7) 0 Inf 243 Inf(1,4)];%H
WI = [Inf(1,8) 0 Inf 75 Inf(1,3)];%I
WJ = [Inf(1,9) 0 Inf 47 Inf(1,2)];%J
WK = [Inf(1,10) 0 Inf 42 Inf];%K
WL = [Inf(1,11) 0 Inf 78];%L
WM = [Inf(1,12) 0 61];
WN = [Inf(1,13) 0];

w = [WA;WB;WC;WD;WE;WF;WG;WH;WI;WJ;WK;WL;WM;WN];
clear WA WB WC WD WE WF WG WH WI WJ WK WL WM WN

% Inicialização
rot=[0 Inf(1,13)];

iter=1; % Inicializa a variável de iteração
rotaux=zeros(size(rot)); % Inicializa o vetor de rótulos auxiliar
perm=0; % Inicializa o valor final do vetor de rótulos permanentes para dar início ao laço
rotfin=length(rot); % Declara o critério de parada, que é quando o ponto de chegada torna-se um rótulo permanente
armaz=zeros(length(rotaux)); % Inicializa a matriz que armazena os rótulos em cada iteração
while perm(end)~=rotfin % Enquanto a componente final do vetor de rótulos permanentes for diferente do valor do ponto de chega, roda o laço
    rotp=min(rot); % Calcula o rótulo permanente
    [~,ord]=sort(rot); % Ordena em ordem crescente o vetor de rótulos
    perm(iter)=ord(1); % Pega a primeira componente do vetor ordenado e atribui que essa variável é a nova componente do vetor de rótulos permanentes
    
    % Atualiza os novos rótulos com base nos valores da matriz de rótulos,
    % valor de rótulo permanente e matriz W.
    rotn(2)=min([rot(2),rotp+w(ord(1),2)]);     % a
    rotn(3)=min([rot(3),rotp+w(ord(1),3)]);     % b
    rotn(4)=min([rot(4),rotp+w(ord(1),4)]);     % c
    rotn(5)=min([rot(5),rotp+w(ord(1),5)]);     % d
    rotn(6)=min([rot(6),rotp+w(ord(1),6)]);     % e
    rotn(7)=min([rot(7),rotp+w(ord(1),7)]);     % f
    rotn(8)=min([rot(8),rotp+w(ord(1),8)]);     % g
    rotn(9)=min([rot(9),rotp+w(ord(1),9)]);     % h
    rotn(10)=min([rot(10),rotp+w(ord(1),10)]);  % i
    rotn(11)=min([rot(11),rotp+w(ord(1),11)]);  % k
    rotn(12)=min([rot(12),rotp+w(ord(1),12)]);  % l
    rotn(13)=min([rot(13),rotp+w(ord(1),13)]);  % m
    rotn(14)=min([rot(14),rotp+w(ord(1),14)]);  % n
    rotaux=rotn; % Atualização: atribui que o vetor de rótulos auxiliares é igual ao vetor de novos rótulos
    l=length(perm); % Calcula o comprimento do vetor de rótulos permanentes
    for i=1:l
        rotn(perm(i))=Inf; % Atribui valor de infinito para o rótulo permanente da iteração no vetor de novos rótulos. Isso foi feito para que o valor não seja detectado como mínimo na próxima iteração
        rotaux(perm(i))=0; % Atribui valor de zero para o rótulo permanente da iteração no vetor de rótulos auxiliares. Isso foi feito para não deletar as componentes do vetor a cada iteração.
    end
    armaz(iter,:)=rotn; % Atualiza a matriz de armazenamento com a linha que corresponde ao vetor de rótulos novos
    rot=rotn; % Atualiza o vetor de rótulos
    iter=iter+1; % Atualiza a iteração
end

minimo=rotp; % Quando o critério é atingido, o valor do caminho mínimo será igual ao valor do rótulo permanente
disp(['Comprimento do menor caminho = ',num2str(minimo)]);

dist=minimo; % Atribui novo nome para o caminho mínimo
cont=1; % Variável contadora
r=length(perm); % Atribui novo nome para o comprimento do vetor de rótulos permanentes
cam(cont)=perm(r); % Inicializa o vetor de caminho
while r>1 % Loop até chegar no valor de r=1, que é o início do caminho
    [r,~]=find(armaz==dist); % Comando para encontrar a posição da linha onde o valor mínimo apareceu na matriz de rótulos permanentes
    r=min(r); % Pega o mínimo do vetor de r, que é onde o valor mínimo apareceu pela primeira vez, ou seja, onde o valor mínimo se tornou um rótulo permanente
    cam(cont+1)=perm(r); % Atualiza o vetor de caminho
    cont=cont+1; % Atualiza o contador
    if r==1 % Flag para atualizar o valor mínimo do vetor de rótulos permanentes
        dist=min(armaz(r,:)); % Quando r=1, não existe vetor anterior
    else
        dist=min(armaz(r-1,:)); % Quando r>1, pega o valor mínimo do vetor anterior, que é o próximo rótulo que virou permanente na iteração anterior
    end
end
cam=fliplr(cam); % Espelha o vetor de caminho para deixar na ordem do caminho de início até o caminho de chegada
% for i=1:length(cam) % Laço para atribuir strings aos números
%     if cam(i)==1,camstr(i)='s';elseif cam(i)==2,camstr(i)='a';
%     elseif cam(i)==3,camstr(i)='b';elseif cam(i)==4,camstr(i)='c';
%     elseif cam(i)==5,camstr(i)='d';elseif cam(i)==6,camstr(i)='e';
%     elseif cam(i)==7,camstr(i)='f';elseif cam(i)==8,camstr(i)='g';
%     elseif cam(i)==9,camstr(i)='h';elseif cam(i)==10,camstr(i)='i';
%     elseif cam(i)==11,camstr(i)='t';
%     end
%     disp(['Caminho ',num2str(i),' = ',camstr(i)]);
% end
