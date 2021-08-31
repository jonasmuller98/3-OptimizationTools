f = @(x) x(1)^2 + x(2)^2 -2*x(1) - 2*x(2) + 2;  % Função

N = 10000;
x_a = 1e5;
xmax = 10;
xmin = -10;

for i = 1:N
    x(1) = xmin+rand*(xmax-xmin);
    x(2) = xmin+rand*(xmax-xmin);
    
    if f(x) < x_a;
        x_a = f(x);
       melhor = x;       
    end
    
end