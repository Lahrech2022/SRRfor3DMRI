function [ C,S,A ] = orientation_c_spm(c,s,a,Option)
%Fonction qui permet de passer de l'orientation Siemens à l'orientation
%Bruker


if Option == 1
    
% Bruker
% COronal(HB,GD,AV-AR)
% Sagital(HB,AV-AR,GD)
% Axial(AR-AV,GD,BH)  

k=input('Entrer le nombre = directions+A0 \n');

if k ==1
    
C=c;
C=reshape(repmat(C,[1 3]),size(C,1),size(C,2),3*size(C,3));


 S=s;
 S=reshape(repmat(S,[1 3]),size(S,1),size(S,2),3*size(S,3));
 S=permute(S,[1 3 2]); 
 
 A=a;
 A=reshape(repmat(A,[1 3]),size(A,1),size(A,2),3*size(A,3));
 A=permute(A,[3 2 1]);
 A=flipdim(A,1);
 A=flipdim(A,3);
  
else
        
        
C=c;
C=reshape(repmat(C,[1 3]),size(C,1),size(C,2),3*size(C,3),size(C,4));


 S=s;
 S=reshape(repmat(S,[1 3]),size(S,1),size(S,2),3*size(S,3),size(S,4));
 S=permute(S,[1 3 2 4]); 
 
 A=a;
 A=reshape(repmat(A,[1 3]),size(A,1),size(A,2),3*size(A,3),size(A,4));
 A=permute(A,[3 2 1 4]);
 A=flipdim(A,1);
  A=flipdim(A,3);
  

    
end


end








if Option == 2
    
%On ne sait pas si GD ou DG, mais sagital inversée par rapport aux autres
%
% Bruker
% COronal(HB,GD,AV-AR)
% Sagital(HB,AV-AR,GD)
% Axial(AR-AV,GD,BH)  
i=0;


k=input('Entrer le nombre = directions+A0 \n');

if k ==1
    
Cor=c;

 Sag=s;
 Sag=permute(Sag,[1 3 2]); 
 
 Axi=a;
 Axi=permute(Axi,[3 2 1]);
 Axi=flipdim(Axi,1);
  Axi=flipdim(Axi,3);
  
  for i=1:size(c,3)/3
      C(:,:,i)=(Cor(:,:,(3*i))+Cor(:,:,(3*i)-1)+Cor(:,:,(3*i)-2))/3;
      S(:,:,i)=(Sag(:,:,(3*i))+Sag(:,:,(3*i)-1)+Sag(:,:,(3*i)-2))/3;
      A(:,:,i)=(Axi(:,:,(3*i))+Axi(:,:,(3*i)-1)+Axi(:,:,(3*i)-2))/3;
      
      
      
  end
  
  
  
  
else
    
 Cor=c;

 Sag=s;
 Sag=permute(Sag,[1 3 2 4]); 
 
 Axi=a;
 Axi=permute(Axi,[3 2 1 4]);
 Axi=flipdim(Axi,1);
  Axi=flipdim(Axi,3);
  
  for i=1:size(Cor,3)/3
      C(:,:,i,:)=(Cor(:,:,(3*i),:)+Cor(:,:,(3*i)-1,:)+Cor(:,:,(3*i)-2,:))/3;
  end
  for i=1:size(Sag,3)/3
      S(:,:,i,:)=(Sag(:,:,(3*i),:)+Sag(:,:,(3*i)-1,:)+Sag(:,:,(3*i)-2,:))/3;
  end
  
  for i=1:size(Axi,3)/3
      A(:,:,i,:)=(Axi(:,:,(3*i),:)+Axi(:,:,(3*i)-1,:)+Axi(:,:,(3*i)-2,:))/3;
  end
  
      
      
  

end
end


if Option == 10
    
            
C=c;
C=reshape(repmat(C,[1 3]),size(C,1),size(C,2),3*size(C,3),size(C,4));


 S=s;
 S=reshape(repmat(S,[1 3]),size(S,1),size(S,2),3*size(S,3),size(S,4));
 S=permute(S,[1 3 2 4]); 
 
 A=a;
 A=reshape(repmat(A,[1 3]),size(A,1),size(A,2),3*size(A,3),size(A,4));
 A=permute(A,[3 2 1 4]);
 A=flipdim(A,1);
  A=flipdim(A,3);
end





if Option == 12
    
    Cor=c;

 Sag=s;
 Sag=permute(Sag,[1 3 2 4]); 
 
 Axi=a;
 Axi=permute(Axi,[3 2 1 4]);
 Axi=flipdim(Axi,1);
  Axi=flipdim(Axi,3);
  
  for i=1:size(Cor,3)/3
      C(:,:,i,:)=(Cor(:,:,(3*i),:)+Cor(:,:,(3*i)-1,:)+Cor(:,:,(3*i)-2,:))/3;
  end
  for i=1:size(Sag,3)/3
      S(:,:,i,:)=(Sag(:,:,(3*i),:)+Sag(:,:,(3*i)-1,:)+Sag(:,:,(3*i)-2,:))/3;
  end
  
  for i=1:size(Axi,3)/3
      A(:,:,i,:)=(Axi(:,:,(3*i),:)+Axi(:,:,(3*i)-1,:)+Axi(:,:,(3*i)-2,:))/3;
  end
  
      
      
  

end

end