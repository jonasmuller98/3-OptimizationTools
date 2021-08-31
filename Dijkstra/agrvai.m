clear all;clc;

W = [0 15 Inf Inf 9 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7     %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %t

parada = 0;
RotRotT(1,1) = 0;
i = 1;PermAnt(1)=1;
NovoRotulo = RotT(:,1);

while parada == 0
    RotuloAnt = NovoRotulo;
    RotuloPerm = NovoRotuloPerm
    for iter = 1:size(RotuloAnt,1)
        NovoRotulo(iter,1)=min(RotuloAnt(iter),RotuloPerm(PermAnt(i))+W(PermAnt(i),iter));
    end
    
    if i == 1
        NovoRotulo(1) = nan;
    else
        RotT(PermAnt(i),i+1) = nan;
    end

    [Vmin,imin] = min(NovoRotulo);
    PermAnt(i+1) = imin;
    
    RotT(:,i+1) = NovoRotulo;
    
    i = i+1;
end