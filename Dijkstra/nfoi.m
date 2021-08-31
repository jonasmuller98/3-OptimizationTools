clear all;clc;

W = [0 15 Inf Inf 9 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7     %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %tcamin

AntRotuloT = [Inf(1,5)];
AntRotuloP = [0 Inf(1,5)];

NovoRotuloT = AntRotuloT;
NovoRotuloP = AntRotuloP;

loop = 1;iter=1;
perm = 1;

contadores = [2;3;4;5;6];
c = 1;

while loop == 1
    NovoRotuloT = [];
    disp(['Iteração: ',num2str(iter)]);
    disp(' ');
    
    for i = 1:size(AntRotuloT,2)
        if iter == 1
            NovoRotuloT(i) = min(AntRotuloT(i),AntRotuloP(perm)+W(perm,i+1));
        else
            NovoRotuloT(i) = min(AntRotuloT(i),AntRotuloP(perm+1)+W(perm+1,contadores(i,1)));
        end
    end
    
    disp(['Rotulos Temporarios: rot=[',num2str(NovoRotuloT),']']);
    
    [Vmin,imin]=min(NovoRotuloT);
    perm=imin;
    if imin == 6
    loop = 0;    
    end
    
    AntRotuloT=NovoRotuloT;
    AntRotuloT(perm) = [];
    caminho(c) = contadores(perm);
    c = c+1;
    contadores(perm)=[];
    
    if size(NovoRotuloT,2) == 2
        NovoRotuloP = AntRotuloP;
        NovoRotuloP(end) = Vmin;
        disp(['Rótulos Permanentes: rot=[',num2str(NovoRotuloP),']']);

        loop = 0;
        break;
    end
    
    AntRotuloP(perm+1) = Vmin;
    disp(['Rótulos Permanentes: rot=[',num2str(AntRotuloP),']']);

    iter=iter+1;
end





