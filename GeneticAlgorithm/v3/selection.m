function [parcruzar,iparcruzar,resp_pop,elite,ielite] = selection(pop_bin_actual,pop_dec_actual,f)

% Calcula as f's
for iresp=1:size(pop_dec_actual,1)
    resp_pop(iresp,1) = f(pop_dec_actual(iresp));
end

% Rankeia a população 
[~,isort] = sort(resp_pop);
pop_sort = pop_bin_actual(flip(isort),:);

% Elitismo - preserva o melhor valor
elite = pop_sort(1,:);
ielite = isort(end,1);
% Calcula as novas probabilidades
for ipi=1:size(pop_dec_actual,1)
    Pi(ipi,1) = (resp_pop(ipi,1)/sum(resp_pop(:,1)));
end

Pif(1,1) = 0;
% Constrói a roleta
for ipif=1:size(pop_dec_actual,1)
    Pi_aux = sum(Pi(1:ipif,1));
    Pif(ipif+1,1) = Pi_aux;
end
isorteio = [0;0];
% Gira a roleta e seleciona o par de cromossomos que irá sofrer cruzamento
while isorteio(1,1) == isorteio(2,1)
    for j=1:2
        aleatorio = rand;
        for i=1:size(pop_dec_actual,1)
            if Pif(i,1) < aleatorio && aleatorio <= Pif(i+1,1)
                sorteio(j,1) = Pif(i,1);
                isorteio(j,1) = i;
            end    
        end
    end
end

parcruzar = pop_bin_actual(isorteio,:);
iparcruzar = isorteio;
end