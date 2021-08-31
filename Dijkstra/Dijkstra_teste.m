%% Algoritmos de Otimização
% Engenharia Aeroespacial
% 13.09.2019
clear all; clc;
%S  A  B   C  D  T
W = [0 9 Inf Inf 60 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7     %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %t
Wa = W;
paux=0;
%RotT = [A B C D T]
%RotP = [0 a b c d t]
rot_P = [0 Inf Inf Inf Inf Inf];
rot_T = [Inf Inf Inf Inf Inf];
a=1;b=2;c=3;d=4;t=5;
parada = 0;
cont = 1;
i = 1;
nrot_T = rot_T;
imin=1;

while parada ~= 1
    disp(['Iteração:',num2str(i)]);
    for ie=1:size(nrot_T,2)
        if i == 1
            nrot_T(ie) = min(nrot_T(ie),rot_P(imin) + Wa(cont,ie+1));
        else
            nrot_T(ie) = min(nrot_T(ie),rot_P(imin+1) + Wa(imin+1,ie+1));
        end
    end
    
    [vmin,imin] = min(nrot_T(:));
    disp(['Rotulos Temporarios: rot=[',num2str(nrot_T),']']);
    
    if size(nrot_T,2) == 2
        paux = 1;
        rot_P(1,end) = vmin;
    end
    
    if size(nrot_T,2) ~= 2
        rot_P(imin+1) = vmin;
        nrot_T(imin) = [];
    end
    
    disp(['Rótulos Permanentes: rot=[',num2str(rot_P),']']);
    
    if imin == 1, cont = 1;     Wa(:,2) = [];
    elseif imin == 2,cont = 2;  Wa(:,3) = [];
    elseif imin == 3,cont = 3;  Wa(:,4) = [];
    elseif imin == 4, cont = 4; Wa(:,5) = [];
    elseif imin == 5, cont = 5; Wa(:,6) = [];
    end
    
    if paux == 1
        parada = 1;
        cont = 6;
        disp(['O menor comprimento possível é: ',num2str(rot_P(end))]);
        break;
    else
        parada = 0;
        i = i+1;
    end
end

%% Checando o Caminho realizado
check = 0; j=1;
Wb = W;
coluna = cont;
while check ~= 1
    Wba = Wb(:,coluna);
    [ValorMin,IndiceMin] = min(Wba(Wba>0));
    
    if IndiceMin == 1
        break;
    end
    Wb(IndiceMin,:) = [];
    if j == 1
        coluna=IndiceMin;
    else
        coluna=IndiceMin+1;
    end
    caminho(j)=coluna;
    j=j+1;
end
caminho=flip(caminho);

for ib=1:size(caminho,2)
    str_cam(1)='s';
    if caminho(1,ib)==1, str_cam(c)='s';
    elseif caminho(1,ib)==2,str_cam(c)='a';
    elseif caminho(1,ib)==3,str_cam(c)='b';
    elseif caminho(1,ib)==4,str_cam(c)='c';
    elseif caminho(1,ib)==5,str_cam(c)='d';
    elseif caminho(1,ib)==6,str_cam(c)='t';
    end
    str_cam(end+1)='t';
    c=c+1;
end

disp(['O caminho realizado é: ',num2str(str_cam)]);