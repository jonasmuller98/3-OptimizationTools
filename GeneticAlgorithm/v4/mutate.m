function [filhosm] = mutate(filhos,nbits,nvar)
for iv=1:nvar
    casa = randi([1 nbits(iv,1)]);  % Chuta uma casa para sofrer mutação
    filhote = randi([1 2]);    % Chuta qual filho sofrerá a mutação (1 ou 2)
    % filhosm=filhos;
    
%     filhos_aux = str2num(filhos{1,iv});    % passa para valor numérico pra ordenar do menor para maior
    filhos_aux = filhos{1,iv};
    
    if filhos_aux(filhote,casa) == 1
        filhos_aux(filhote,casa) = 0;
    elseif filhos_aux(filhote,casa) == 0
        filhos_aux(filhote,casa) = 1;
    end
    
    filhosm{iv} = (filhos_aux);     % passa novamente para string
end

end