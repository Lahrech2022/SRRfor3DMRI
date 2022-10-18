function [ C,S,A ] = Siemens_Bruker_2D(c,s,a,Option)
%Fonction qui permet de passer de l'orientation Siemens à l'orientation
%Bruker


if Option ==1
    
%Siemens : 
% Coronal(GD?,BH,AV-AR)
% Sagital(AV-AR,BH,DG?)
% Axial(GD?,AR-AV,BH)
%On ne sait pas si GD ou DG, mais sagital inversée par rapport aux autres
%
% Bruker
% COronal(HB,GD,AV-AR)
% Sagital(HB,AV-AR,GD)
% Axial(AR-AV,GD,BH)  

C=c;
 C=permute(C,[2 1 3]);
 C=flipdim(C,1);
 
 S=s;
 S=permute(S,[2 1 3]); 
 S=flipdim(S,1);
  S=flipdim(S,3);
 
 A=a;
 A=permute(A,[2 1 3]);   
 
end









if Option == 2
    
    %Siemens : 
% Coronal(BH,GD?,AV-AR???)
% Sagital(BH,AV-AR,DG?)
% Axial(AR-AV,GD?,BH)




%On ne sait pas si GD ou DG, mais sagital inversée par rapport aux autres
%
% Bruker
% COronal(HB,GD,AV-AR)
% Sagital(HB,AV-AR,GD)
% Axial(AR-AV,GD,BH)  
C=c;
  C=flipdim(C,1);

 
 S=s;
  S=flipdim(S,1);
  S=flipdim(S,3);
  
 A=a;

 
end



 