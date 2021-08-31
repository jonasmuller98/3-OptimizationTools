%% Algoritmos de Otimiza��o

clear all; clc;
%% Vari�veis Pr�-Loop
Worig = [0 15 Inf Inf 9 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7       %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %t

W=Worig;
parar = 0; imin = 0; iter = 1;  % Vari�veis Auxiliares
aRotT = [Inf(1,5)];             % R�tulo Antigo Tempor�rio
aRotP = [0 Inf(1,5)];           % R�tulo Antigo Permanente
nRotP = [0 Inf(1,5)];           % Novo R�tulo Permanente
contadores=[2 3 4 5 6];         % Contadores relativos aos v�rtices, excluindo o primeiro
Vobjetivo = 5;                  % V�rtice objetivo contado a partir do primeiro (excluindo origem)

while parar == 0
    aRotP = nRotP;          % Define o R�tulo Antigo como o Novo R�tulo
    
    if iter == 1, imin=1;   % V�lido para o primeiro la�o - inicia pelo 0
    else, imin=imin+1;
    end
    
    for ie = 1:size(contadores,2)
        nRotT(ie) = min(aRotT(ie),aRotP(imin)+W(imin,contadores(ie)));
    end
    
    if iter == 1
    else, nRotT(marcados) = Inf;    % Evita o erro que ocorre ao manter o vetor completo de r�tulos tempor�rios re-definindo permanentes como infinito
    end
    
    [vmin,imin] = min(nRotT);   % Verifica o menor dos r�tulos tempor�rios
    marcados(iter) = imin;  % Armazena qual r�tulo se tornou permanente
    
    flag=imin+1;            % Flag auxiliar para definir Wij quando i=j como Inf
    nRotP(imin+1) = vmin;   % Define o Novo R�tulo Permanente
    aRotT = nRotT;          % Define o R�tulo Tempor�rio Antigo como o Resultado do Novo R�tulo Tempor�rio
    aRotT(imin) = Inf;      % Define o respectivo tempor�rio que se tornou permanente como Inf
    W(flag,flag)=Inf;       % Define Wij(i=j)=Inf
    
    RotT(:,iter) = nRotT;   % Armazena o R�tulo em uma matriz de tempor�rios
    RotP(:,iter) = nRotP;   % Armazena o R�tulo em uma matriz de permanentes
    
    iter=iter+1;            % Atualiza a Itera��o
    
    if marcados(end) == Vobjetivo, parar=1; % Condi��o de parada - se o �ltimo permanente for o �ltimo v�rtice
    end
end
disp(['Rotulos Permanentes = [',num2str(RotP(:,end)'),']']);
disp(['Caminho M�nimo = ',num2str(RotP(end,end))]);

%% Checando o Caminho realizado
check = 0; j=1;
Wb = Worig;
coluna = 6;

while check ~= 1
    Wba = Wb(:,coluna);
    [ValorMin,IndiceMin] = min(Wba(Wba>0));
    
    if IndiceMin == 1
        break;
    end
    
    Wb(IndiceMin,:) = Inf;
    
    %     if j == 1
    coluna=IndiceMin;
    %     else
    %         coluna=IndiceMin+1;
    %     end
    caminho(j)=coluna;
    j=j+1;
end

caminho=flip(caminho);



