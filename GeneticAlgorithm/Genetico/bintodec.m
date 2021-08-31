function [pop_dec_ini]=bintodec(bin,dominio,nbits,individuo,variavel,pop_bin_ini)
        pop_dec_ini(individuo,variavel) = bi2de(pop_bin_ini(individuo,:,variavel));

end
