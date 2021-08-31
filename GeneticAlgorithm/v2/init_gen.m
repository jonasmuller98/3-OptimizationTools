function [pop_bin_actual,pop_dec_actual] = init_gen(ngen,npop,nbits,dominio,pop_bin_actual)
% pop_bin_ini=zeros(npop,nbits);
% pop_dec_ini=zeros(npop,1);  % generalizar o 1
if ngen == 0
    for individuo=1:npop
        bin_aux = randi([0 1],1,nbits);
        pop_bin_actual(individuo,:) = (bin_aux);
        pop_aux = bi2de(pop_bin_actual(individuo,:)); 
        pop_dec_actual(individuo,1) = dominio(1,1) + ((dominio(1,2) - dominio(1,1)).*pop_aux./(2.^nbits-1));
    end
else
    for individuo=1:npop
        pop_aux = bi2de(pop_bin_actual(individuo,:)); 
        pop_dec_actual(individuo,1) = dominio(1,1) + ((dominio(1,2) - dominio(1,1)).*pop_aux./(2.^nbits-1));
    end
end

end