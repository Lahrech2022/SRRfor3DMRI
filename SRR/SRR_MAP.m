function [X_tomorrow,iterations,alphar,norme] = SRR_MAP(c,s,a,TRUE,Option)
% ON VIENT DE RAJOUTER OPTION, pour éviter de demander si on reconstruit



%prend en compte des images orientées dans le sens Bruker = 
%Coronal(HB,GD,AV-AR)
% Sagital(HB,AV-AR,GD)
% Axial(AR-AV,GD,BH)

% Si TRUE = chiffre , on fait pas affichage, et on stocke la variable.
%Ce chiffre correspond à landa

%on fait une itération avec l'équation :
%X(n+1)=X(n)-alpha*grad(X(n))

%//////////////ATTENTION////////////////
%penser si on ne prend pas les coupes classiques, coronales, sagittales et
%axiales que la fonction Bloc3d_coupes replace correctement les blocs BR et
%HR entre eux. La fonction Bloc3d_coupes remplace la matrice Mk. Ce la nous permet de
%gagner du temps.


%%
%DEFINITION DES PARAMETRES
iterations=0;
STOP=10^(-5);
alpha=0.0005;

lambda=0.001; % mettre un input
if nargin==4 & length(TRUE) ==1
    lambda=TRUE;
end


%Ici on calcule la matrice du laplacien.
L2=[0 1/2 0; 1/2 -2 1/2; 0 1/2 0]; %Laplacien en 2D
L_square=L2'*L2; %ici c'est le produit des laplaciens dans un plan; 
L31=zeros(3,3,3);
L31(:,:,2)=L_square; %laplacien pour une coupe
L32=zeros(3,3,3);
L32(:,2,:)=L_square; %pour une deuxième
L33=zeros(3,3,3);

L33(2,:,:)=L_square; % Pour une troisieme
L3=L31+L32+L33; %enfin c'est notre matrice QtQ de l'article en 3D qui filtera notre X.
clear L2 L_square L31 L32 L33; %on fait un peu de place dans la mémoire


coeff_PSF=[0.8;1;0.8]'/sqrt(2.6); %Correspond à la matrice B
%On a les trois coefficients de la PSF. 
%Ici on suppose que c'est la même PSF pour tous les plans.
%Pour accélerer l'algorithme on ne passe pas par la forme matricielle

PSF=coeff_PSF'*coeff_PSF; %Ici on couple les coefficients des PSF équivalent au BtDtDB de l'article


%%
%INITIALISATION
C=reshape(repmat(c,[1 3]),size(c,1),size(c,2),3*size(c,3)); %D1.y1
 %on triple la dernière dimension pour passer en HR

S=reshape(repmat(s,[1 3]),size(s,1),size(s,2),3*size(s,3)); %D2.y2
    %on triple la dernière dimension pour passer en HR

a=flipdim(a,1);  % fait partie de Mt3
a=flipdim(a,3);  % fait partie de Mt3
A=reshape(repmat(a,[1 3]),size(a,1),size(a,2),3*size(a,3)); %D3.y3
    %on triple la dernière dimension pour passer en HR



[Cx,Sx,Ax]=Bloc3d_coupes(0,C,S,A);   %Mk (Dk.yk)
%Lorsqu'on est dans l'espace du bloc HR reconstruit, on note avec le suffixe X

X_today=(Cx+Sx+Ax)/3; %Initialisation x0: moyenne des coupes BR

[C,S,A]=Bloc3d_coupes(X_today); %Mk x0
    %On repasse dans l'espace des coupes C,S,A pour appliquer la PSF.

%Pour initialiser les gradients à la bonne tailles
gradC=C; 
gradS=S;
gradA=A;

% Ici on calcule les gradients dans les trois directions C,S,A
for k=1:3
    
    for j=1:3:3*size(c,3)
        gradC(:,:,j+k-1)=PSF(k,1).*C(:,:,j)+PSF(k,2).*C(:,:,j+1)+PSF(k,3).*C(:,:,j+2)-coeff_PSF(k).*c(:,:,floor(j/3)+1);
    end %BtDtDB (Mk x0) - BtDt (yk)

    for j=1:3:3*size(s,3)   
        gradS(:,:,j+k-1)=PSF(k,1).*S(:,:,j)+PSF(k,2).*S(:,:,j+1)+PSF(k,3).*S(:,:,j+2)-coeff_PSF(k).*s(:,:,floor(j/3)+1);
    end %BtDtDB (Mk x0) - BtDt (yk)

    for j=1:3:3*size(a,3)
        gradA(:,:,j+k-1)=PSF(k,1).*A(:,:,j)+PSF(k,2).*A(:,:,j+1)+PSF(k,3).*A(:,:,j+2)-coeff_PSF(k).*a(:,:,floor(j/3)+1);
    end %BtDtDB (Mk x0) - BtDt (yk)

end

%On repasse dans l'espace X pour sommer les gradients ensemble
[gradCx,gradSx,gradAx]=Bloc3d_coupes(0,gradC,gradS,gradA);

%On filtre avec notre laplacien
X_laplacien=imfilter(X_today,L3);%QtQ.x

%On calcule notre gradient global
gradX_today=gradCx+gradSx+gradAx+lambda*X_laplacien;

%On met a jour notre X
X_tomorrow=X_today-alpha*gradX_today; %  x1

%%  
%ITERATIONS
tic
while sum(abs(X_tomorrow(:)-X_today(:)))>STOP %abs(sum(sum(sum(abs(D2-D)))))>STOP %ici, quelle norme ?

%On a besion de sauvegarder les gradients et le X de l'itération précédente
%pour la mise à jour du alpha
gradX_yesterday=gradX_today;
X_yesterday=X_today;
X_today=X_tomorrow;


[C,S,A]=Bloc3d_coupes(X_today); %Mk xn

for k=1:3
    
    for j=1:3:3*size(c,3) 
        gradC(:,:,j+k-1)=PSF(k,1).*C(:,:,j)+PSF(k,2).*C(:,:,j+1)+PSF(k,3).*C(:,:,j+2)-coeff_PSF(k).*c(:,:,floor(j/3)+1);
    end  %BtDtDB (Mk xn) - BtDt (yk)

    for j=1:3:3*size(s,3)   
        gradS(:,:,j+k-1)=PSF(k,1).*S(:,:,j)+PSF(k,2).*S(:,:,j+1)+PSF(k,3).*S(:,:,j+2)-coeff_PSF(k).*s(:,:,floor(j/3)+1);
    end %BtDtDB (Mk xn) - BtDt (yk)
    
    for j=1:3:3*size(a,3)
        gradA(:,:,j+k-1)=PSF(k,1).*A(:,:,j)+PSF(k,2).*A(:,:,j+1)+PSF(k,3).*A(:,:,j+2)-coeff_PSF(k).*a(:,:,floor(j/3)+1);
    end %BtDtDB (Mk xn) - BtDt (yk)
    
end


%On repasse dans l'espace X pour sommer les gradients ensemble 
[gradCx,gradSx,gradAx]=Bloc3d_coupes(0,gradC,gradS,gradA);

X_laplacien=imfilter(X_today,L3);%QtQ.x

gradX_today=gradCx+gradSx+gradAx+lambda*X_laplacien;%gradient global

% CALCUL ALPHA

%On fait la différence des X et des gradients et on met chaque résultat dans
%un vecteur ligne
DeltaX=reshape(X_today-X_yesterday,[],1);
Delta_gradX=reshape(gradX_today-gradX_yesterday,[],1);   

%Mise à jour de alpha par l'algorithme de Barzilai_Borwein
alpha=(Delta_gradX'*DeltaX)/(Delta_gradX'*Delta_gradX);



%Enfin on fait la mise à jour.
    X_tomorrow=X_today-alpha*gradX_today; %xn+1=xn-alpha.grad total
    
    iterations=iterations+1;
    alphar(iterations)=alpha;
    norme(iterations)=sum(abs(X_tomorrow(:)-X_today(:)));
   sum(abs(X_tomorrow(:)-X_today(:)))
 
end
toc

X_tomorrow=Bruker_SRR_3D(X_tomorrow,2);  % Ici, on renvoie notre X, mais dans l'orientation de la 3D Bruker

iterations;
% 
% figure()
% hold on
% plot(log10(norme));
% 
% figure()
% hold on
% plot(alphar);

%%
%POUR LA VISULISATION

if nargin~=5
    
if nargin==3 | length(TRUE) ~=1
    
orientation=menu('Voir visualisation ?','non', 'coronal','sagital','axial');


if nargin==3 & orientation ~=1

    
if orientation==2  
afficher_SRR(c,X_tomorrow,2);
elseif orientation==3
afficher_SRR(s,X_tomorrow,2);
elseif orientation==4
a=flipdim(a,1);  % fait partie de Mt3
a=flipdim(a,3);  % fait partie de Mt3
afficher_SRR(a,X_tomorrow,2);
end   
  
end

if nargin==4 & orientation ~=1


    
if orientation==2    
afficher_SRR(TRUE,X_tomorrow,c);
elseif orientation==3
afficher_SRR(TRUE,X_tomorrow,s);
elseif orientation==4
a=flipdim(a,1);  % fait partie de Mt3
a=flipdim(a,3);  % fait partie de Mt3
afficher_SRR(TRUE,X_tomorrow,a);
end
end
%

end

end
end





