function [filhos] = crossover(parcruzar)
% Realiza o cruzamento entre as esp�cies de acordo com a sele��o realizada
% cruzamento gera dois filhos

% for ipar=1:size(parcruzar,1)
filhos = [parcruzar(1:3) parcruzar(4:5)
                parcruzar(4:5) parcruzar(1:3)];     
% end

end