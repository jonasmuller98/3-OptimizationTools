function [pop_bin_new] = evolve(filhos,pop_bin,parcruzar,iparcruzar,resp_pop,elite,ielite,f,pop_dec,nvar,nbits)
npop = size(pop_bin{1,1},1);

for iv=1:nvar
    pop_bin_new{iv} = zeros(npop,nbits(iv,1));
end

for iv = 1:nvar
    elite_aux = elite{iv};
    pop_bin_aux = pop_bin_new{iv};
    pop_bin_aux(ielite,:) = elite_aux;
    pop_bin_new{iv} = pop_bin_aux;  
end

for iv = 1:nvar
        filhos_aux = bi2de(filhos{1,iv}); 
        filhos_dec(:,iv) = filhos_aux;
end

for ifi = 1:2
    if f(filhos_dec(ifi,:)) > f(pop_dec(iparcruzar(ifi,1),:))
        for iv = 1:nvar
            filhos_aux = filhos{1,iv};
            pop_bin_aux = pop_bin_new{iv};
            filhos_aux = filhos{iv};
            pop_bin_aux(iparcruzar(ifi,1),:) = filhos_aux;
            pop_bin_new{iparcruzar(ifi,1),iv} = ;
        end
        %         pop_bin_new(iparcruzar(ifi,1),:) = filhos(ifi,:);
    elseif f(filhos_dec(ifi,:)) < f(pop_dec(iparcruzar(ifi,1),:))
        for iv = 1:nvar
            pop_bin_aux = pop_bin{1,iv};
            pop_bin_new{iparcruzar(ifi,1),iv} = pop_bin_aux;
        end
        %         pop_bin_new(iparcruzar(ifi,1),:) = pop_bin_actual(iparcruzar(ifi,1),:);
    end
end


end