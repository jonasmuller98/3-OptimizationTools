function [node_disp,Tensoes,Massa,Pcrit,SecForce] = FEM(area_anterior)
Dados.coordenadas = [-37.5 0 200
37.5 0 200
-37.5 37.5 100
37.5 37.5 100
37.5 -37.5 100
-37.5 -37.5 100
-100 100 0
100 100 0
100 -100 0
 -100 -100 0];
 

Dados.elementos = [1 2
1 4
2 3
1 5
2 6
2 5
2 4
1 3
1 6
3 6
4 5
3 4
5 6
3 10
6 7
4 9
5 8
3 8
4 7
6 9
5 10
3 7
4 8
5 9
6 10];

Dados.geometria = [ones(size(Dados.elementos,1),1).*area_anterior];
Dados.material = [ones(size(Dados.elementos,1),1).*10^7];
Dados.gdlfixos = [19 20 21 22 23 24 25 26 27 28 29 30]';
Dados.cargapontual = [1 10 -10 0 10 -10 0.5 0 0 0 0 0 0 0 0 0.6 0 0 0 0 0 0 0 0 0 0 0 0 0 0]';
Dados.cargadistrib=[];

[node_disp,deslocamentos] = FEMSolver(Dados);
% drawingMesh(Dados,10,deslocamentos);
d = sqrt(4*area_anterior/pi);
I = (pi*d^4)/32; % Momento de Inércia [m^4] 
[Tensoes,Pcrit] = stresses3Dtruss(Dados,deslocamentos,I);
k = 1; % k para pino-pino (flambagem)
E = 10^7; %[Pa]
rho = 0.1; % Densidade [kg/m^3]
Lbar = 84.0030603382706*39.3701; % comprimento total de barras [m]
SecForce = Tensoes./area_anterior;
Massa = rho*area_anterior*Lbar;  % massa total das barras [m^2]

end

