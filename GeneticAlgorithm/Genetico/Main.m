%% Algoritmo Gen�tico 
% Jonas Muller
% Algoritmos de Otimiza��o
clear all; clc;
%% Fun��o principal
% Vari�veis Auxiliares
istop = 0;  % Auxiliar de parada =0
ngen = 0; % N�mero de Gera��es
rng(5);

% Vari�veis de Input
nvar = 1;   % N�mero de Vari�veis
npop = 5;   % N�mero de Indiv�duos na Popula��o

f = @(x) x^2;

nbits(1,1) = 5;  % N�mero de bits no gen�tipo da vari�vel 1 (MAIOR)
% nbits(2,1) = 3;  % N�mero de bits no gen�tipo da vari�vel 2 (MENOR)
dominio(1,:) = [0 31]; % Dom�nio das vari�veis

%% Cria��o da Popula��o Inicial de Indiv�duos bin�rios e decimais
[pop_bin_ini,pop_dec_ini] = init_gen(nvar,npop,nbits,dominio);
pop_bin_actual = pop_bin_ini;   % Popula��o Bin�ria
pop_dec_actual = pop_bin_ini;   % Popula��o Decimal



%% Evolu��o das Esp�cimes
% while istop == 0
% ngen = ngen+1;    % Atualiza o Contador de Gera��es
% 
% [] = selection (pop_dec_actual);
% [] = crossover();
% [] = mutate();
% 
% if niter = 1000;
%     istop=1;
% end
% 
% end
