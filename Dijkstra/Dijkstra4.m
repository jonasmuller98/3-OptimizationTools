W = [0 15 Inf Inf 9 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7     %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %t

RotP = [0 Inf Inf Inf Inf Inf]';
RotT = [Inf Inf Inf Inf Inf]';
nRotT(:,1) = RotT;

Waux = W;
continuar=1;
iteracao=1;

while continuar=1;
    if iteracao == 1
        nRotT(:,iteracao) = RotT';
    end
    
    nRotT(:,iteracao) = nan;
    
    for i=1:size(nrot_T,2)
        nRotT(i,iteracao) = min(nrot_T(i,iteracao),rot_P_aux + Waux(i,));      
    end
    
end


