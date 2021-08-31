%% Algoritmos De Otimização
% Algoritmo de Dijkstra - Otimização de Rota
% Rota Chuí-Iraí 
% Jonas Müller Gonçalves

clear all; clc;
%%

WA = [0 80 256 Inf(1,11)];%A
WB = [Inf 0 Inf 96 193 Inf(1,9)];%B
WC = [Inf(1,2) 0 Inf Inf 109 Inf(1,8)];%C
WD = [Inf(1,3) 0 Inf Inf 207 202 Inf(1,6)];%D
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

W = [WA;WB;WC;WD;WE;WF;WG;WH;WI;WJ;WK;WL;WM;WN];

Wa = W;
paux=0;

%RotT = [A B C D E F G H I J K L M N];
%RotP = [0 A B C D E F G H I J K L M N];
rot_P = [0 Inf(1,13)];
rot_T = [Inf(1,13)];

parada = 0; cont = 1; i = 1; nrot_T=rot_T; imin=1;

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
    
    cont = imin;
    Wa(:,imin+1)=[];
    
    if paux == 1
        parada = 1;
        cont = 14;
        disp(['O menor comprimento possível é: ',num2str(rot_P(end))]);
        break;
    else
        parada = 0;
        i = i+1;
    end
end

%% Checando o Caminho realizado
% check = 0; j=1;
% Wb = W;
% coluna = cont;
% while check ~= 1
%     Wba = Wb(:,coluna);
%     [ValorMin,IndiceMin] = min(Wba(Wba>0));
%     
%     if IndiceMin == 1
%         break;
%     end
%     Wb(IndiceMin,:) = [];
%     if j == 1
%         coluna=IndiceMin;
%     else
%         coluna=IndiceMin+1;
%     end
%     caminho(j)=coluna;
%     j=j+1;
% end
% caminho=flip(caminho);

% for ib=1:size(caminho,2)
%     str_cam(1)='s';
%     if caminho(1,ib)==1, str_cam(c)='s';
%     elseif caminho(1,ib)==2,str_cam(c)='a';
%     elseif caminho(1,ib)==3,str_cam(c)='b';
%     elseif caminho(1,ib)==4,str_cam(c)='c';
%     elseif caminho(1,ib)==5,str_cam(c)='d';
%     elseif caminho(1,ib)==6,str_cam(c)='t';
%     end
%     str_cam(end+1)='t';
%     c=c+1;
% end
% 
% disp(['O caminho realizado é: ',num2str(str_cam)]);