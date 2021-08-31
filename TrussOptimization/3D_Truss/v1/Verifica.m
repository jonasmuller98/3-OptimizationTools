function [fp1,fp2] = Verifica(node_disp,Tensoes)

for inode = 1:size(node_disp,1)
    if node_disp(inode,1) > 0.058 || node_disp(inode,1) < -0.058
        fp1 = exp(abs(node_disp(inode,1)));
        if fp1 == 0
           disp('aaa') 
        end
    elseif node_disp(inode,2) > 0.058 || node_disp(inode,2) < -0.058
        fp1 = exp(abs(node_disp(inode,2)));
        if fp1 == 0
           disp('bbb') 
            
        end
    else
        fp1=1;
    end
end

for itensao = 1:size(Tensoes,1)
    if Tensoes(itensao) > 173.36e6 || Tensoes(itensao) < -173.36e6
        fp2 = exp(abs(Tensoes(itensao)));
        if fp2 == 0
           disp('ccc') 
            disp(num2str(Tensoes(itensao)))
        end
    else
        fp2=1;
    end
end


end
