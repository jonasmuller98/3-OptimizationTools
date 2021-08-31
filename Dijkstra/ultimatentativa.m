%% Algoritmos de Otimização

clear all; clc;
%% Variáveis Pré-Loop
Worig = [0 15 Inf Inf 9 Inf;    %S
    Inf 0 35 3 Inf Inf;     %A
    Inf 16 0 6 Inf 21       %B
    Inf Inf Inf 0 2 7       %C
    Inf 4 Inf 2 0 Inf       %D
    Inf Inf 5 Inf Inf 0];   %t

W=Worig;
parar = 0; imin = 0; iter = 1;  % Variáveis Auxiliares
aRotT = [Inf(1,5)];             % Rótulo Antigo Temporário
aRotP = [0 Inf(1,5)];           % Rótulo Antigo Permanente
nRotP = [0 Inf(1,5)];           % Novo Rótulo Permanente
contadores=[2 3 4 5 6];         % Contadores relativos aos vértices, excluindo o primeiro
Vobjetivo = 5;                  % Vértice objetivo contado a partir do primeiro (excluindo origem)

while parar == 0
    aRotP = nRotP;          % Define o Rótulo Antigo como o Novo Rótulo
    
    if iter == 1, imin=1;   % Válido para o primeiro laço - inicia pelo 0
    else, imin=imin+1;
    end
    
    for ie = 1:size(contadores,2)
        nRotT(ie) = min(aRotT(ie),aRotP(imin)+W(imin,contadores(ie)));
    end
    
    if iter == 1
    else, nRotT(marcados) = Inf;    % Evita o erro que ocorre ao manter o vetor completo de rótulos temporários re-definindo permanentes como infinito
    end
    
    [vmin,imin] = min(nRotT);   % Verifica o menor dos rótulos temporários
    marcados(iter) = imin;  % Armazena qual rótulo se tornou permanente
    
    flag=imin+1;            % Flag auxiliar para definir Wij quando i=j como Inf
    nRotP(imin+1) = vmin;   % Define o Novo Rótulo Permanente
    aRotT = nRotT;          % Define o Rótulo Temporário Antigo como o Resultado do Novo Rótulo Temporário
    aRotT(imin) = Inf;      % Define o respectivo temporário que se tornou permanente como Inf
    W(flag,flag)=Inf;       % Define Wij(i=j)=Inf
    
    RotT(:,iter) = nRotT;   % Armazena o Rótulo em uma matriz de temporários
    RotP(:,iter) = nRotP;   % Armazena o Rótulo em uma matriz de permanentes
    
    iter=iter+1;            % Atualiza a Iteração
    
    if marcados(end) == Vobjetivo, parar=1; % Condição de parada - se o último permanente for o último vértice
    end
end
disp(['Rotulos Permanentes = [',num2str(RotP(:,end)'),']']);
disp(['Caminho Mínimo = ',num2str(RotP(end,end))]);

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



