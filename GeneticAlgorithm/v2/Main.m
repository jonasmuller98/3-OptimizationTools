%% Algoritmo Genético
% Jonas Muller
% Algoritmos de Otimização
clear all; clc;
%% Função principal
% Variáveis Auxiliares
istop = 0;  % Auxiliar de parada =0
ngen = 0; % Número de Gerações
rng(3);

% Variáveis de Input
nvar = 2;   % Número de Variáveis
npop = 5;   % Número de Indivíduos na População (ÍMPAR)
nbits(1,1) = 5;  % Número de bits no genótipo da variável 1 (MAIOR)
% nbits(2,1) = 3;  % Número de bits no genótipo da variável 2 (MENOR)
dominio(1,:) = [0 31]; % Domínio das variáveis
% dominio(2,:) = [0 31]; % Domínio das variáveis
pcross = 0.95; % Probabilidade de cruzamento
pmut = 0.1; % Probabilidade de mutação
f = @(x) x.^2;   % Função de otimização


%% Criação da População Inicial de Indivíduos binários e decimais
pop_bin_actual = [];
[pop_bin_actual,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual);

% pop_bin_actual = pop_bin_ini;   % População Binária
% pop_dec_actual = pop_dec_ini;   % População Decimal


%% Evolução das Espécimes
while istop == 0
    ngen = ngen+1;    % Atualiza o Contador de Gerações
    [parcruzar,iparcruzar,resp_pop,elite,ielite] = selection(pop_bin_actual,pop_dec_actual,f);    % Seleciona os indíviduos a partir da aptidão
    
    if pcross > rand
        [filhos] = crossover(parcruzar);  % Realiza o crossover a partir da probabilidade
        if pmut > rand
            [filhosm] = mutate(filhos,nbits); % Realiza mutação a partir da probabilidade
            filhos = filhosm;
        end
        [pop_bin_new] = evolve(filhos,pop_bin_actual,parcruzar,iparcruzar,resp_pop,elite,ielite,f,pop_dec_actual)
        
    else
        
    end
    

    
    pop_bin_actual = pop_bin_new;
    [~,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual);
    
    if ngen == 1000
        istop=1;
    end
    
end
