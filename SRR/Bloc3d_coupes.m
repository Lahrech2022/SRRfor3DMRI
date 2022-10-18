function [C,S,A]=Bloc3d_coupes(X,c,s,a)
%Cette fonction joue le le role de la wrapping matrix M dans l'article.
%Elle permet de passer de l'espace des coupes coronales, sagittales,
%axiales dans l'espace de la reconstruction HR.
%Elle permet aussi de faire le sens inverse

%Si l'on veut passer de l'espace de la reconstruction HR vers nos coupes
%On ne rentre dans la fonction qu'un seul argument
%[C,S,A]=Bloc3d_coupes(X);


if length(size(X))==3   %Cas où on oriente matrice 3D comme matrices 2D -> Mk x)
   
 C=permute(X,[3 1 2]); % M1 (x)
 
 S=permute(X,[3 2 1]); % M2 (x)

 A=permute(X,[2 1 3]);    % M3 (x)


%Si l'on veut transformer nos coupes C,S,A dans l'espace X:
%[Cx,Sx,Ax]=Bloc3d_coupes(0,c,s,a)

else    % Cas où on oriente matrices 2D sur matrice 3D -> Mk (Dk.yk)

 C=c;
 C=permute(C,[2 3 1]); % Mt1 (D1.y1)
 
 S=s;
 S=permute(S,[3 2 1]); % Mt2 (D2.y2)
 
 A=a;
 A=permute(A,[2 1 3]);    % Mt3 (D3.y3). Attention car dans SRR, on a déjà effectué un flipdim sur les axiales
end

end

%On ne passe par des matrices, ça prendrait beaucoup plus de temps.