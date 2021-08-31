function [Dados] = Problema
    % Estrutura Treliçada P2.1 Khennane(2013) Pg. 28
    Dados.coordenadas = [0 0 0;0 360 0;180 180 0;360 0 0;360 360 0;540 180 0;720 0 0;720 360 0];
    Dados.elementos = [1 4;1 3;2 3;2 5;3 5;4 5;3 4;4 8;4 6;5 6;5 7;6 7;7 8;6 8];
    
    Dados.geometria = [0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1];
    Dados.material = [10^4;10^4;10^4;10^4;10^4;10^4;10^4;10^4;10^4;10^4;10^4;10^4;10^4;10^4];
    Dados.gdlfixos = [1 2 3 4 5 6]';
    Dados.cargapontual = [0 0 0 0 0 0 0 0 0 0 -150 0 0 50 0 0 0 0 0 -150 0 0 50 0]';
    Dados.cargadistrib=[];
end