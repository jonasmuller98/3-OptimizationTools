%% Algoritmo Gen�tico
% Jonas Muller
% Algoritmos de Otimiza��o
clear all; clc;
%% Fun��o principal
% Vari�veis Auxiliares
istop = 0;  % Auxiliar de parada =0
ngen = 0; % N�mero de Gera��es
rng(3);

% Vari�veis de Input
nvar = 2;   % N�mero de Vari�veis
npop = 5;   % N�mero de Indiv�duos na Popula��o (�MPAR)
nbits(1,1) = 5;  % N�mero de bits no gen�tipo da vari�vel 1 (MAIOR)
% nbits(2,1) = 3;  % N�mero de bits no gen�tipo da vari�vel 2 (MENOR)
dominio(1,:) = [0 31]; % Dom�nio das vari�veis
% dominio(2,:) = [0 31]; % Dom�nio das vari�veis
pcross = 0.95; % Probabilidade de cruzamento
pmut = 0.1; % Probabilidade de muta��o
f = @(x) x.^2;   % Fun��o de otimiza��o


%% Cria��o da Popula��o Inicial de Indiv�duos bin�rios e decimais
pop_bin_actual = [];
[pop_bin_actual,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual);

% pop_bin_actual = pop_bin_ini;   % Popula��o Bin�ria
% pop_dec_actual = pop_dec_ini;   % Popula��o Decimal


%% Evolu��o das Esp�cimes
while istop == 0
    ngen = ngen+1;    % Atualiza o Contador de Gera��es
    [parcruzar,iparcruzar,resp_pop,elite,ielite] = selection(pop_bin_actual,pop_dec_actual,f);    % Seleciona os ind�viduos a partir da aptid�o
    
    if pcross > rand
        [filhos] = crossover(parcruzar);  % Realiza o crossover a partir da probabilidade
        if pmut > rand
            [filhosm] = mutate(filhos,nbits); % Realiza muta��o a partir da probabilidade
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
