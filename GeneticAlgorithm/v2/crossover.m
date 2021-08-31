function [filhos] = crossover(parcruzar)
% Realiza o cruzamento entre as espécies de acordo com a seleção realizada
% cruzamento gera dois filhos

% for ipar=1:size(parcruzar,1)
filhos = [parcruzar(1:3) parcruzar(4:5)
                parcruzar(4:5) parcruzar(1:3)];     
% end

end