function [] = selection(pop_dec_actual,f)
 % Calcula as f's
 for i=1:size(pop_dec_actual,1)
    resp_pop(i,1) = f(resp_pop(i,:));
 end
 
 % Calcula as novas probabilidades
    for i=1:pop_dec_actual
        Pi(i,1) = (1-resp_seg(i,1))/sum(resp_seg);
    end
    
    Pif(1,1) = 0;
    
    for i=1:size(pop_dec_actual,1)
        Pi_aux = sum(Pi(1:i,1));
        Pif(i+1,1) = Pi_aux;
    end
      
    % Gira a roleta e Atribui a nova colméia relativo a probabilidade da roleta
    for j=1:size(pop_dec_actual,1)
        aleatorio = rand;
        for i=1:size(pop_dec_actual,1)
            if Pif(i,1) < aleatorio && aleatorio <= Pif(i+1,1)
                a=1; armazena(j,1) = Pif(i,1);
                pop_dec_nova(i,:) = retorno(i,:);
            end
        end
    end



end