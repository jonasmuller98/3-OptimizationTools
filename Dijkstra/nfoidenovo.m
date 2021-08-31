clear all; clc;

W = [0 15 Inf Inf 9 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7     %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %t
RTAntigo = [Inf(1,5)];
RPAntigo = [0 Inf(1,5)];
RPNovo = RPAntigo;
criterio=0;
i = 1;
iRPantigo = 1;
iter = 1;
while criterio == 0
    c = 1;
    for i = 1:size(RTAntigo,2)
        if iter == 1
        RTNovo(c) = min(RTAntigo(i),RPAntigo(iRPantigo)+W(iRPantigo,i+1));
        else
        RTNovo(c) = min(RTAntigo(i),RPAntigo(iRPantigo)+W(iRPantigo+1,i+1));
        end
        c = c+1;
    end
[vmin,imin]=min(RTNovo);
RPNovo(imin) = vmin;
RPAntigo = RPNovo;
RTAntigo = RTNovo;
RTAntigo(imin) = nan;
iRPantigo = imin;
iter = iter+1;
end