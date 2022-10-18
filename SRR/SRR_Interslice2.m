function [X_tomorrow,iterations,alphar,norme] = SRR_Interslice2(V1,V2,TRUE)

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
STOP=10^(-10);
alpha=0.01;

lambda=0.05; % mettre un input
if nargin==3 & length(TRUE) ==1
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

% Ici, on considère pas besoin de PSF, car gain de résolution de 2

% coeff_PSF=[0.8;1;0.8]'/sqrt(2.6); %Correspond à la matrice B
% %On a les trois coefficients de la PSF. 
% %Ici on suppose que c'est la même PSF pour tous les plans.
% %Pour accélerer l'algorithme on ne passe pas par la forme matricielle
% 
% PSF=coeff_PSF'*coeff_PSF; %Ici on couple les coefficients des PSF équivalent au BtDtDB de l'article
% 

%%
%INITIALISATION

X_today=Bloc_SRR2D(V1,V2);%Initialisation x0: dimension 2n+1

V1est=Bloc_SRR2D(X_today,1); % On passe du bloc BR au HR
V2est=Bloc_SRR2D(X_today,2); % dimension n

gradV1=V1est-V1; %dimension n
gradV2=V2est-V2;


%On filtre avec notre laplacien
X_laplacien=imfilter(X_today,L3);%dimension 2n+1

%On calcule notre gradient global
gradX_today=Bloc_SRR2D(gradV1,gradV2)+lambda*X_laplacien;

%On met a jour notre X
X_tomorrow=X_today-alpha*gradX_today;  %  x1

%%  
%ITERATIONS
tic
while sum(abs(X_tomorrow(:)-X_today(:)))>STOP %abs(sum(sum(sum(abs(D2-D)))))>STOP %ici, quelle norme ?

%On a besion de sauvegarder les gradients et le X de l'itération précédente
%pour la mise à jour du alpha
gradX_yesterday=gradX_today;
X_yesterday=X_today;
X_today=X_tomorrow;


V1est=Bloc_SRR2D(X_today,1);
V2est=Bloc_SRR2D(X_today,2);

gradV1=V1est-V1; %dimension n
gradV2=V2est-V2;


X_laplacien=imfilter(X_today,L3);%QtQ.x


%On calcule notre gradient global
gradX_today=Bloc_SRR2D(gradV1,gradV2)+lambda*X_laplacien;
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

iterations;
% 
% figure()
% hold on
% plot(log10(norme));
% 
% figure()
% hold on
% plot(alphar);

% %%
% %POUR LA VISULISATION
% if nargin==3 | length(TRUE) ~=1
%     
% orientation=menu('Voir visualisation ?','non', 'coronal','sagital','axial');
% 
% 
% if nargin==3 & orientation ~=1
% 
%     
% if orientation==2  
% afficher_SRR(c,X_tomorrow,2);
% elseif orientation==3
% afficher_SRR(s,X_tomorrow,2);
% elseif orientation==4
% a=flipdim(a,1);  % fait partie de Mt3
% a=flipdim(a,3);  % fait partie de Mt3
% afficher_SRR(a,X_tomorrow,2);
% end   
%   
% end
% 
% if nargin==4 & orientation ~=1
% 
% 
%     
% if orientation==2    
% afficher_SRR(TRUE,X_tomorrow,c);
% elseif orientation==3
% afficher_SRR(TRUE,X_tomorrow,s);
% elseif orientation==4
% a=flipdim(a,1);  % fait partie de Mt3
% a=flipdim(a,3);  % fait partie de Mt3
% afficher_SRR(TRUE,X_tomorrow,a);
% end
% end
% %
% end

end


    

function [P]=Bloc_SRR2D(M,N) 

s=size(M);

if N==1 %c'est le cas HR -> BR, avec comme la dernière slice qui saute$*
    M(:,:,s(3))=[];
    for i=1:((s(3)-1)/2)
    P(:,:,i)=(M(:,:,2*i-1)+M(:,:,2*i))/2;
    end
end

if N==2
    M(:,:,1)=[];
    for i=1:((s(3)-1)/2)
    P(:,:,i)=(M(:,:,2*i-1)+M(:,:,2*i))/2;
    end
end

if length(N) ~= 1 % cas deux BR -> HR
    P=zeros(s(1),s(2),2*s(3)+1);
    P(:,:,1)=M(:,:,1);
    P(:,:,2*s(3))=(M(:,:,s(3))+N(:,:,s(3)))/2;
    P(:,:,2*s(3)+1)=N(:,:,s(3));
        
    for i=1:s(3)-1
        P(:,:,2*i)=(M(:,:,i)+N(:,:,i))/2;
        P(:,:,2*i+1)=(M(:,:,i+1)+N(:,:,i))/2;
        
    end
end
end

    
    
