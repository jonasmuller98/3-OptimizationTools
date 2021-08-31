%% Algoritmo Genético 
% Jonas Muller
% Algoritmos de Otimização
clear all; clc;
%% Função principal
% Variáveis Auxiliares
istop = 0;  % Auxiliar de parada =0
ngen = 0; % Número de Gerações
rng(5);

% Variáveis de Input
nvar = 1;   % Número de Variáveis
npop = 5;   % Número de Indivíduos na População

f = @(x) x^2;

nbits(1,1) = 5;  % Número de bits no genótipo da variável 1 (MAIOR)
% nbits(2,1) = 3;  % Número de bits no genótipo da variável 2 (MENOR)
dominio(1,:) = [0 31]; % Domínio das variáveis

%% Criação da População Inicial de Indivíduos binários e decimais
[pop_bin_ini,pop_dec_ini] = init_gen(nvar,npop,nbits,dominio);
pop_bin_actual = pop_bin_ini;   % População Binária
pop_dec_actual = pop_bin_ini;   % População Decimal



%% Evolução das Espécimes
% while istop == 0
% ngen = ngen+1;    % Atualiza o Contador de Gerações
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
