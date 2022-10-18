function [CC,SS,AA] = Topup_recalage_Bruker(C,S,A )
%

directions=menu('Nombre de directions (A0 + diff)', '1,','7','16','31','65');

if directions ==1
    direc=1;
end
if directions ==2
    direc=7;
end
if directions ==3
    direc=16;
end
if directions ==4
    direc=31;
end
if directions ==5
    direc=65;
end

Cor_r=zeros(84,102,114,direc);
Sag_r=zeros(84,102,114,direc);
Axi_r=zeros(84,102,114,direc);

%ca marche pour toutes les dimnesions ? 
[c,s,a] = TopupBruker_Bruker_2D(C,S,A);
[ Cor,Sag,Axi ] = orientation_c_spm(c,s,a,10);
RECAL(:,:,:,:,1)=Cor;
RECAL(:,:,:,:,2)=Sag;
RECAL(:,:,:,:,3)=Axi;
RECAL=permute(RECAL,[1 2 3 5 4]);
Cor_r=zeros(84,102,114,3,direc);

for i=1:direc
    save_nii(make_nii(squeeze(RECAL(:,:,:,:,i))),'C:\Users\gin7\Documents\MATLAB\Recal');
%      save_nii(make_nii(squeeze(RECAL(:,:,:,2,i))),'C:\Users\gin7\Documents\MATLAB\Recal02');
%     save_nii(make_nii(squeeze(RECAL(:,:,:,3,i))),'C:\Users\gin7\Documents\MATLAB\Recal03');
   P=spm_select('ExtList', 'C:\Users\gin7\Documents\MATLAB\','^Recal.img',1:3);
   spm_realign(P);
   spm_reslice(P);
   F=load_untouch_nii('C:\Users\gin7\Documents\MATLAB\rRecal.img');
   
   
   Cor_r(:,:,:,i)=F.img(:,:,:,1);   
   Sag_r(:,:,:,i)=F.img(:,:,:,2); 
   Axi_r(:,:,:,i)=F.img(:,:,:,3); 
   
end

%Vérifier les problemes orientations ?

ind1=find(isnan(Cor_r));
ind2=find(isnan(Sag_r));
ind3=find(isnan(Axi_r));

Cor_r(ind1)=0;
Sag_r(ind2)=0;
Axi_r(ind3)=0;


[ CC,SS,AA ] = orientation_c_spm(Cor_r,Sag_r,Axi_r,12);

   