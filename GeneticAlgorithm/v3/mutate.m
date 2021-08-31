function [filhosm] = mutate(filhos,nbits)
casa = randi([1 nbits]);
filhote = randi([1 size(filhos,1)]);
filhosm=filhos;

    
if filhosm(filhote,casa) == 1
    filhosm(filhote,casa) = 0;
elseif filhosm(filhote,casa) == 0
    filhosm(filhote,casa) = 1;
end

end