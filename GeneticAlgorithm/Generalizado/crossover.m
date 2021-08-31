function [filhos] = crossover(parcruzar,nbits,nvar)
% Realiza o cruzamento entre as espécies de acordo com a seleção realizada
% cruzamento gera dois filhos

for iv = 1:nvar
parcruzar1 = str2num(parcruzar{1,iv});    % passa para valor numérico pra ordenar do menor para maior

filhos{iv} = [parcruzar1(1,1:nbits(iv,1)/2) parcruzar1(2,nbits(iv,1)/2+1:nbits(iv,1))
            parcruzar1(1,nbits(iv,1)/2+1:nbits(iv,1)) parcruzar1(2,1:nbits(iv,1)/2)];     

%     parcruzars1{iv} = num2str(pop_cruzar);     % passa novamente para string
end