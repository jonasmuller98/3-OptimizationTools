function [pop_bin_actual,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual,ivar)

if ngen == 0
    for individuo=1:npop
        bin_aux = randi([0 1],1,nbits(ivar,1));
        pop_bin_actual(individuo,:) = (bin_aux);
        pop_aux = bi2de(pop_bin_actual(individuo,:)); 
        pop_dec_actual(individuo,1) = dominio(ivar,1) + ((dominio(ivar,2) - dominio(ivar,1)).*pop_aux./(2.^nbits(ivar,1)-1));
    end
else
    for individuo=1:npop
        pop_aux = bi2de(pop_bin_actual(individuo,:)); 
        pop_dec_actual(individuo,1) = dominio(ivar,1) + ((dominio(ivar,2) - dominio(ivar,1)).*pop_aux./(2.^nbits(ivar,1)-1));
    end
end

end