%% Particle Swarm Optimization
% 27.09.19
% Não está completamente generalizado, sem restrição

clear all;clc;
%% Inicialização
% rng(5)
% f = @(x,y) 100*(y-x.^2).^2+(1-x).^2;    % Função para a otimização
% f = @(x,y) 1 - (1-(sin(sqrt(x.^2+y.^2))).^2)./(1+0.001.*(x.^2+y.^2));
% f = @(x,y) -20.*exp(-0.2.*sqrt(0.5.*(x.^2 + y.^2))) - exp(0.5.*(cos(2.*pi.*x) + cos(2.*pi.*y))) + exp(1) + 20;
 f = @(x,y) 100.*sqrt(abs(y-0.01.*x.^2))+0.01.*abs(x+10);
population = 20;    % População total
variaveis = 2;  % Número de variáveis de projeto
lambda1 = 2;    % Lambda 1
lambda2 = 2;    % Lambda 2
omega = 0.5;    % inércia
dominiox=[-5 5]; % domínio das variáveis - fronteira
dominioy=[-5 5];

for ivar = 1:population
    position(:,1) = -3 + (3+3)*rand(population,1);  % criando a população em x
    position(:,2) = -3 + (3+3)*rand(population,1);  % criando a população em y
end
npart = size(position,1);   % numero de individuos da população
nvar = size(position,2);    % numero de variáveis

velocity = zeros(npart,nvar);   % inicializa as velocidades

resultados = f(position(:,1),position(:,2));    % define os valores de f(x,y)
[resg,ord]=sort(resultados);    % ordena os valores do menor para o maior

xlbest = zeros(npart,nvar);
xgbest = [position(ord(1,1),1) position(ord(1,1),2)];   % define o melhor global como o primeiro do vetor ordenado
melhorglobal=xgbest;    % cria um valor armazenado do melhor global
ordglobal = ord(1,1);   % replica qual a linha do melhor global

parada = 0;
iter=0;

pos_old = position; 
v_old = velocity;
% fsurf(f);hold on;

while parada == 0
    iter=iter+1;
    r1 = rand;  % r1 aleatório
    r2 = rand;  % r2 aleatório
    
    for i=1:npart
        for j=1:nvar
            v(i,j) = omega*v_old(i)+lambda1*r1*(xlbest(i,j) - pos_old(i,j)) + lambda2*r2*(xgbest(j) - pos_old(i,j));
            pos(i,j) = pos_old(i,j) + v(i,j);
        end
    end
    
    cont1=1;cont2=1;
    for ia=1:npart
        
        if pos(ia,1) > dominiox(2) || pos(ia,1) >  dominiox(2)
            passoux(cont1,1) = pos(ia,1);
            cont1=cont1+1;
            pos(ia,1) = pos(ia,1) - (pos(ia,1)-1);
            
        elseif pos(ia,2) <  dominioy(1) || pos(ia,2) <  dominioy(1)
            passouy(cont2,1) = pos(ia,2);
            pos(ia,2) = pos(ia,2) - (pos(ia,2)-1);
            cont2=cont2+1;
        end
        
    end
        
        resultados = f(pos(:,1),pos(:,2));  
        [resl,ord]=sort(resultados);
        
        xlbest = [pos(ord,1) pos(ord,2)];
        melhorlocal = [xlbest(1,1) xlbest(1,2)];
        ordlocal = ord;
        
        v_old = v;
        pos_old = pos;
        
        if resg(1,1) > resl(1,1)
           resg=resl;
           melhorglobal = resl;
           xgbest=[xlbest(1,1) xlbest(1,2)];
        end
        
%         scatter3(xgbest(1,1),xgbest(1,2),f(xgbest(1,1),xgbest(1,2)));hold on;
        
        figure(2);
        scatter(iter,f(xgbest(1,1),xgbest(1,2)));hold on;
        
        if iter==300
            parada=1;
        end
        
end

