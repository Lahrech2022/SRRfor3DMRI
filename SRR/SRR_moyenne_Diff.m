function [X] = SRR_Moyenne_Diff(c,s,a)

k=input('Entrer le landa désiré \n');
directions=menu('Nombre de directions (A0 + diff)', '7','16','31','48','64','65','25');

if directions ==1
    
    for i=1:7
        X(:,:,:,i)=SRR_moyenne_pasiter(c(:,:,:,i),s(:,:,:,i),a(:,:,:,i),k,1);
    end
end

if directions ==2
    
    for i=1:16
        X(:,:,:,i)=SRR_moyenne_pasiter(c(:,:,:,i),s(:,:,:,i),a(:,:,:,i),k,1);
    end
end

if directions ==3
    
    for i=1:31
        X(:,:,:,i)=SRR_moyenne_pasiter(c(:,:,:,i),s(:,:,:,i),a(:,:,:,i),k,1);
    end
end


if directions ==4
    
    for i=1:48
        X(:,:,:,i)=SRR_moyenne_pasiter(c(:,:,:,i),s(:,:,:,i),a(:,:,:,i),k,1);
    end
end

if directions ==5
    
    for i=1:64
        X(:,:,:,i)=SRR_moyenne_pasiter(c(:,:,:,i),s(:,:,:,i),a(:,:,:,i),k,1);
    end
end

if directions ==6
    
    for i=1:65
        X(:,:,:,i)=SRR_moyenne_pasiter(c(:,:,:,i),s(:,:,:,i),a(:,:,:,i),k,1);
    end
end

if directions ==7
    
    for i=1:25
        X(:,:,:,i)=SRR_moyenne_pasiter(c(:,:,:,i),s(:,:,:,i),a(:,:,:,i),k,1);
    end
end


end
