function [pop_bin_ini,pop_dec_ini] = init_gen(nvar,npop,nbits,dominio)
pop_bin_ini=zeros(npop,max(nbits),nvar);
pop_dec_ini=zeros(npop,nvar);

for variavel=1:nvar
    for individuo=1:npop
        pop_bin_ini(individuo,1:nbits(variavel,1),variavel) = randi([0 1],1,nbits(variavel,1));
        pop_dec_ini(individuo,variavel) = bi2de(pop_bin_ini(individuo,:,variavel));
    end
end

end