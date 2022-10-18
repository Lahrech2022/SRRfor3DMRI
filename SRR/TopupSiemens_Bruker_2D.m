function [ C,S,A ] = TopupSiemens_Bruker_2D(c,s,a)
%Fonction qui permet de passer de l'orientation Siemens à l'orientation
%Bruker


    
%Topup Bruker: 
% Coronal(BH, DG, AV-AR)
% Sagital(BH, AV-AR, GD)
% Axial(AR-AV, DG, BH)
%On ne sait pas si GD ou DG, mais sagital inversée par rapport aux autres
%
% Bruker
% COronal(HB,GD,AV-AR)
% Sagital(HB,AV-AR,GD)
% Axial(AR-AV,GD,BH)  

C=c;
 C=flipdim(C,1);
 C=flipdim(C,2);
 
 S=s;
  S=flipdim(S,1);
 
 A=a;
  A=flipdim(A,2); 
 
end





