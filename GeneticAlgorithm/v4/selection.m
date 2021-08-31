function [parcruzar,iparcruzar,resp_pop,elite,ielite] = selection(pop_bin_actual,pop_dec_actual,f,pop_bin,pop_dec,nvar)

% Calcula as f's
for iresp=1:size(pop_dec,1)
    resp_pop(iresp,1) = f(pop_dec(iresp,:));
end

% Rankeia a população
[~,isort] = sort(resp_pop);

for iv = 1:nvar
    pop_sorts1 = str2num(pop_bin{1,iv});    % passa para valor numérico pra ordenar do menor para maior
    pop_sort = pop_sorts1(flip(isort),:);   % ordena o vetor do menor para o maior
    pop_sorts2{iv} = num2str(pop_sort);     % passa novamente para string
    
    % Elitismo - preserva o melhor valor
    elite{iv} = pop_sort(1,:);
    ielite = isort(end,1);    
end


% Calcula as novas probabilidades
for ipi=1:size(pop_dec,1)
    Pi(ipi,1) = (resp_pop(ipi,1)/sum(resp_pop(:,1)));
end

Pif(1,1) = 0;
% Constrói a roleta
for ipif=1:size(pop_dec,1)
    Pi_aux = sum(Pi(1:ipif,1));
    Pif(ipif+1,1) = Pi_aux;
end
isorteio = [0;0];

% Gira a roleta e seleciona o par de cromossomos que irá sofrer cruzamento
while isorteio(1,1) == isorteio(2,1)    % Condiciona à pares distintos
    for j=1:2
        aleatorio = rand;
        for i=1:size(pop_dec,1)
            if Pif(i,1) < aleatorio && aleatorio <= Pif(i+1,1)
                sorteio(j,1) = Pif(i,1);
                isorteio(j,1) = i;
            end
        end
    end
end


for iv = 1:nvar
    pop_sorts1 = str2num(pop_bin{1,iv});    % passa para valor numérico pra ordenar do menor para maior
    pop_cruzar = pop_sorts1(isorteio,:);   % seleciona o vetor 
    parcruzar{iv} = num2str(pop_cruzar);     % passa novamente para string
end

% parcruzar = pop_bin_actual(isorteio,:);
iparcruzar = isorteio;
end