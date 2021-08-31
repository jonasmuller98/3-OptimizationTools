%% Algoritmo Genético
% Jonas Muller
% Algoritmos de Otimização
% Programa para MAXIMIZAR
clear all; clc;

%% Função principal
% Variáveis Auxiliares
istop = 0;  % Auxiliar de parada =0
ngen = 0; % Número de Gerações
rng(6);

% Variáveis de Input
nvar = 2;   % Número de Variáveis
npop = 7;   % Número de Indivíduos na População (ÍMPAR)
nbits(1,1) = 4;          % Número de bits no genótipo da variável (PARES)
nbits(2,1) = 6;          % Número de bits no genótipo da variável (PARES)
nbits(3,1) = 6;          % Número de bits no genótipo da variável (PARES)
dominio(1,:) = [0 31];   % Domínio das variáveis
dominio(2,:) = [0 31];   % Domínio das variáveis
dominio(3,:) = [0 31];   % Domínio das variáveis
pcross = 0.95;  % Probabilidade de cruzamento
pmut = 0.1;     % Probabilidade de mutação
f = @(x) x(1).^2 + x(2);  % Função de otimização
ncount = 20;    % Limite de repetições para a condição
counter = 0;

for ivar = 1:nvar
    %% Criação da População Inicial de Indivíduos binários e decimais
    pop_bin_actual = [];
    [pop_bin_actual,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual,ivar);
    pop_bin{ivar} = num2str(pop_bin_actual);
    pop_dec(:,ivar) = pop_dec_actual;
end

%% Evolução das Espécimes
while istop == 0
    ngen = ngen+1;    % Atualiza o Contador de Gerações
    [parcruzar,iparcruzar,resp_pop,elite,ielite] = selection(pop_bin_actual,pop_dec_actual,f,pop_bin,pop_dec,nvar); % Seleciona os indivíduos   % Seleciona os indíviduos a partir da aptidão
    
    if pcross > rand
        [filhos] = crossover(parcruzar,nbits,nvar);  % Realiza o crossover a partir da probabilidade
        if pmut > rand
            [filhosm] = mutate(filhos,nbits,nvar); % Realiza mutação a partir da probabilidade
            filhos = filhosm;
        end
        
        [pop_bin_new] = evolve(filhos,pop_bin,parcruzar,iparcruzar,resp_pop,elite,ielite,f,pop_dec,nvar,nbits); % Evolui a espécie
        
    else
        pop_bin_new = pop_bin_actual;   % Se o crossover não é realizado, mantém a espécie
    end
    
    pop_bin_actual = pop_bin_new;   % Atualiza a população binária
    [~,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual);  % Inicializa a população decimal
    
    %% Condição de Parada
    if ngen > 1
        valormax(ngen,1) = max(resp_pop);
        vmax(ngen,1) = mode(valormax);
        if vmax(ngen-1)==vmax(ngen)
            counter = counter + 1;
        else
            counter = 0;
        end
    end
    
    if counter == ncount
        istop=1;
    end
    
end

disp(['O valor da função é: ',num2str(vmax(end,1))]);