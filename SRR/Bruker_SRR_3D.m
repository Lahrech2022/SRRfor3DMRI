function [ B ] = Bruker_SRR_3D(A,Option )
%Fonction qui permet de passer de l'orientation SRR à l'orientation 3D Bruker,
%et inversement

%Option1 Bruker -> SRR
if Option==1
B=permute(A,[2 3 1]);   
    
end



%Option2 SRR ->Bruker

if Option==2
    B=permute(A,[3 1 2]);
end

end

