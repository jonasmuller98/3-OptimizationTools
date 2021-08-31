function [pop_bin_new] = evolve(filhos,pop_bin_actual,parcruzar,iparcruzar,resp_pop,elite,ielite,f,pop_dec_actual)
npop = size(pop_bin_actual,1);
nbits = size(pop_bin_actual,2);
pop_bin_new = zeros(npop,nbits);
pop_bin_new(ielite,:) = elite;

pop_dec_new = zeros(npop,1);
pop_dec_new(ielite,1) = pop_dec_actual(ielite,1);

for ifd = 1:2
   filhos_dec(ifd,1) = bi2de(filhos(ifd,:)); 
end


for ifi = 1:2
    if f(filhos_dec(ifi,:)) > f(pop_dec_actual(iparcruzar(ifi,1),:))
        pop_bin_new(iparcruzar(ifi,1),:) = filhos(ifi,:);
    elseif f(filhos(ifi,:)) < f(pop_dec_actual(iparcruzar(ifi,1),:))
        pop_bin_new(iparcruzar(ifi,1),:) = pop_bin_actual(iparcruzar(ifi,1),:);
    end
end


end