% Aula 1 - Algoritmos de Otimização
% syms x1 x2
% f = x1^2+3*x2^2-2*x1*x2+2*x1+4*x2;
% a = hessian(f,[x1,x2]);
clear all;clc;

%% Método da Hessiana
% Exemplo 1
figure(1)
x1 = linspace(-3,3,100);
y1 = linspace(-3,3,100);
[X1,Y1] = meshgrid(x1,y1);
Z1 = X1.^2+3.*Y1.^2-2.*X1.*Y1+2.*X1+4.*Y1;
surf(X1,Y1,Z1);xlabel('x1');ylabel('y1');
hold on;

% Exemplo 2
figure(2)
x2 = linspace(-5,5,10);
y2 = linspace(-5,5,10);
[X2,Y2] = meshgrid(x2,y2);
Z2 = X2.^3+Y2.^3+2.*X2.^2+4.*Y2.^2+6;
surf(X2,Y2,Z2);xlabel('x2 (x1)');ylabel('y2 (x2)');zlabel('z2');
hold on;

%% Método de Newton
f = @(x) x(1)^3 + 2*x(1)^2 + 4*x(2)^2 + 6;  % Função
gradF = @(x) [3*x(1)^2 + 4*x(1);3*x(2)^2+8*x(2)];   % Gradiente da Função
H = @(x) [6*x(1)+4,0;0,6*x(2)+8];   % Matriz Hessiana
x0 = [-0.1;0-0.1]; 
plot3(x0(1),x0(2),f(x0),'r*');hold on;

for i=1:100
     x=x0-inv(H(x0))*gradF(x0);
%     x = x0-eye(2)*gradF(x0);
    x0=x;
    plot3(x(1),x(2),f(x),'co');hold on; 
end
x0
