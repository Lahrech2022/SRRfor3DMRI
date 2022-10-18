function [] = afficher_SRR(Matrice1,Matrice2,Option)

%fonction à décrire
%Si on a 3 matrices, ce doit etre : 3D, 3D et 2D


%% 
if nargin==1
dimension=menu('Données à visualiser', 'Slices 2D','Image 3D')


if dimension==2
    Matrice1=pass2D(Matrice1); 
end




[Xsize,Ysize,Zsize]=size(Matrice1);
k=input('Entrer le numéro de la slice \n');
 
    if k<0
        k=1;
    elseif k>Zsize
        k=Zsize;
    end
    

button=3;
figure() %mettre numéro de slice
hold on



while (button~=2)
subplot(1,3,1);
imagesc(Matrice1(:,:,k-1));
title(['Slice n° ' num2str(k-1)])

subplot(1,3,2);
imagesc(Matrice1(:,:,k));
title(['Slice n° ' num2str(k)])

subplot(1,3,3);
imagesc(Matrice1(:,:,k+1));
title(['Slice n° ' num2str(k+1)])
colormap(gray)

    [~,~,button]=ginput(1); % Les tildes signifient que l'on se fiche des autres données    
    if button==28 %fleche gauche = click droit
        button=3;%fleche droite = click gauche
    end
    if button==29
        button=1;%fleche gauche = click droit
    end
    k=k+(1-button)/2-(button-3)/2;
    if k<1 % pour les 2 prochaines conditions, on considère que l'on regarde pas les slices 1, 9 et 10 car toutes les acquisitions ne l'ont pas
        k=1;
    elseif k>Zsize
        k=Zsize;
    end  
end


end

%% 


if nargin==2
Option=menu('Quel type d image à visualiser ? ','3D vs 3D','2D vs 3D','2D vs 2D'); %translations et rotations
end


if Option==1  %Cas 3D -3D   
    Matrice1=pass2D(Matrice1); % on se met dans l'orientation utilisée en SRR
    Matrice2=pass2D(Matrice2); % on se met dans l'orientation utilisée en SRR
end



if Option==2  % Cas 2D - 3D
        Matrice1=pass2D(Matrice1,1); % on met 2eme facteur, car slice 2D 
        Matrice2=pass2D(Matrice2); % on se met dans l'orientation utilisée en SRR

end



if Option==3  % Cas 2D-2D    
        Matrice1=pass2D(Matrice1,1); % on met 2eme facteur, car slice 2D 
        Matrice2=pass2D(Matrice2,1); % on met 2eme facteur, car slice 2D 
   
%     if orientation1-orientation2 ~= 0
%        
%         
%         A FINIR
%         
%     end
%     
        
end


if any([Option==1,Option==2,Option==3])
    
[Xsize,Ysize,Zsize]=size(Matrice1);
k=input('Entrer le numéro de la slice \n');
 
    if k<0
        k=1;
    elseif k>Zsize
        k=Zsize;
    end
    

button=3;
figure() 
hold on

while (button~=2)
subplot(2,3,1);
imagesc(Matrice1(:,:,k-1));
title(['Image 1 Slice n° ' num2str(k-1)])

subplot(2,3,2);
imagesc(Matrice1(:,:,k));
title(['Image 1 Slice n° ' num2str(k)])

subplot(2,3,3);
imagesc(Matrice1(:,:,k+1));
title(['Image 1 Slice n° ' num2str(k+1)])

subplot(2,3,4);
imagesc(Matrice2(:,:,k-1));
title(['Image 2 Slice n° ' num2str(k-1)])

subplot(2,3,5);
imagesc(Matrice2(:,:,k));
title(['Image 2 Slice n° ' num2str(k)])

subplot(2,3,6);
imagesc(Matrice2(:,:,k+1));
title(['Image 2 Slice n° ' num2str(k+1)])
colormap(gray)

    [~,~,button]=ginput(1); % Les tildes signifient que l'on se fiche des autres données    
    if button==28 %fleche gauche = click droit
        button=3;%fleche droite = click gauche
    end
    if button==29
        button=1;%fleche gauche = click droit
    end
    k=k+(1-button)/2-(button-3)/2;
    if k<1 % pour les 2 prochaines conditions, on considère que l'on regarde pas les slices 1, 9 et 10 car toutes les acquisitions ne l'ont pas
        k=1;
    elseif k>Zsize
        k=Zsize;
    end
end


else  %Dans ce cas, Option différent 1, 2 ou 3. On considère Option est une matrice
    %On considère Matrice 1, Matrice 1 sont 3D, et Option est 2D
    
%%    
    Matrice1=pass2D(Matrice1); % on se met dans l'orientation utilisée en SRR
    Matrice2=pass2D(Matrice2); % on se met dans l'orientation utilisée en SRR
    Option=reshape(repmat(Option,[1 3]),size(Option,1),size(Option,2),3*size(Option,3)); %D2.y2    
    
    [Xsize,Ysize,Zsize]=size(Matrice1);
k=input('Entrer le numéro de la slice \n');
 
    if k<0
        k=1;
    elseif k>Zsize
        k=Zsize;
    end
    

button=3;
figure() 
hold on

while (button~=2)
subplot(3,3,1);
imagesc(Option(:,:,k-1));
title(['Image 1 Slice n° ' num2str(k-1)])

subplot(3,3,2);
imagesc(Option(:,:,k));
title(['Image 1 Slice n° ' num2str(k)])

subplot(3,3,3);
imagesc(Option(:,:,k+1));
title(['Image 1 Slice n° ' num2str(k+1)])

subplot(3,3,4);
imagesc(Matrice1(:,:,k-1));
title(['Image 2 Slice n° ' num2str(k-1)])

subplot(3,3,5);
imagesc(Matrice1(:,:,k));
title(['Image 2 Slice n° ' num2str(k)])

subplot(3,3,6);
imagesc(Matrice1(:,:,k+1));
title(['Image 2 Slice n° ' num2str(k+1)])


subplot(3,3,7);
imagesc(Matrice2(:,:,k-1));
title(['Image 3 Slice n° ' num2str(k-1)])

subplot(3,3,8);
imagesc(Matrice2(:,:,k));
title(['Image 3 Slice n° ' num2str(k)])

subplot(3,3,9);
imagesc(Matrice2(:,:,k+1));
title(['Image 3 Slice n° ' num2str(k+1)])
colormap(gray)

    [~,~,button]=ginput(1); % Les tildes signifient que l'on se fiche des autres données    
    if button==28 %fleche gauche = click droit
        button=3;%fleche droite = click gauche
    end
    if button==29
        button=1;%fleche gauche = click droit
    end
    k=k+(1-button)/2-(button-3)/2;
    if k<1 % pour les 2 prochaines conditions, on considère que l'on regarde pas les slices 1, 9 et 10 car toutes les acquisitions ne l'ont pas
        k=1;
    elseif k>Zsize
        k=Zsize;
    end
end
    
end




function [N]=pass2D(M,option2D) %D'une image 3D, renvoie l'image 2D dans l'orientation voulue.

if nargin ==2 %On envoie une matrice 2D en entrée, renvoie dans l'orientation voulue avec 
                M=reshape(repmat(M,[1 3]),size(M,1),size(M,2),3*size(M,3));
                
    orientation_entree=menu('Orientation volume 2D en entree', 'coronal','sagital','axial');
        
    if orientation_entree==1
        [C,S,A]=Bloc3d_coupes(0,M,M,M);
        M=C;
    end
    if orientation_entree==2
        [C,S,A]=Bloc3d_coupes(0,M,M,M);
        M=S;
    end
    if orientation_entree==3
    M=flipdim(M,1);  % fait partie de Mt3
    M=flipdim(M,3);  % fait partie de Mt3
    [C,S,A]=Bloc3d_coupes(0,M,M,M);
    M=A;
    end
    
   M=Bruker_SRR_3D(M,2);
    
    end
    
    
        
        
    M=Bruker_SRR_3D(M,1); % on se met dans l'orientation utilisée en SRR
    [C,S,A]=Bloc3d_coupes(M); % on sépare les 3 types de volume
    orientation=menu('Orientation à visualiser', 'coronal','sagital','axial');

    if orientation==1
        N=C;
    end
    
    if orientation==2
       N=S;
    end
    
    if orientation==3
    A=flipdim(A,1);  % fait partie de Mt3
    A=flipdim(A,3);  % fait partie de Mt3
       N=A;
    end


