function [ C,S,A ] = TopupBruker_Bruker_2D(c,s,a)
%Fonction qui permet de passer de l'orientation Siemens à l'orientation
%Bruker


    
%Topup Bruker: 
% Coronal(BH, DG, AR-AV)
% Sagital(AR-AV, HB, GD)
% Axial(AV-AR, DG, BH)
%On ne sait pas si GD ou DG, mais sagital inversée par rapport aux autres
%
% Bruker
% COronal(HB,GD,AV-AR)
% Sagital(HB,AV-AR,GD)
% Axial(AR-AV,GD,BH)  

C=c;
 C=flipdim(C,1);
 C=flipdim(C,2);
 C=flipdim(C,3);
 
 S=s;
 S=permute(S,[2 1 3 4]); 
 S=flipdim(S,2);
 
 A=a;
  A=flipdim(A,2); 
 
end





