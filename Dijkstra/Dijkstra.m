%% Algoritmos de Otimização
% Engenharia Aeroespacial
% 13.09.2019
clear all; clc;
    %S  A  B   C  D  T
W = [0 15 Inf Inf 9 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7     %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %t
Ws=W(1,1:end); Wa=W(2,1:end); Wb=W(3,1:end); Wc=W(4,1:end); Wd=W(5,1:end); Wt=W(6,1:end);

%RotT = [A B C D T]
%RotP = [0 a b c d t]
rot_P = [0 Inf Inf Inf Inf Inf];
rot_T = [Inf Inf Inf Inf Inf]
a=1;b=2;c=3;d=4;t=5;
parada = 0;
cont = 1;

while parada ~= 1    
rot_T(a) = min(rot_T(a),rot_P(cont) + W(cont,a+1));
rot_T(b) = min(rot_T(b),rot_P(cont) + W(cont,b+1));
rot_T(c) = min(rot_T(c),rot_P(cont) + W(cont,c+1));
rot_T(d) = min(rot_T(d),rot_P(cont) + W(cont,d+1));
rot_T(t) = min(rot_T(t),rot_P(cont) + W(cont,t+1));

[vmin,imin] = min(rot_T);
rot_P(imin) = vmin;

if imin == 1, cont = 1;
elseif imin == 2,cont = 2;
elseif imin == 3,cont = 3;
elseif imin == 4, cont = 4;
elseif imin == 5, cont = 5;
end

if rot_P(end) ~= Inf
    parada = 1;
else
    parada = 0;
end
    
end 