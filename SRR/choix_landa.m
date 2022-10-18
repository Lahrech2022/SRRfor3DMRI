% 
% [X_01,iteration(1)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.01);
% [X_02,iteration(2)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.02);
% [X_03,iteration(3)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.03);
% [X_04,iteration(4)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.04);
% [X_05,iteration(5)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.05);
% [X_06,iteration(6)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.06);
% [X_07,iteration(7)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.07);
% [X_08,iteration(8)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.08);
% [X_09,iteration(9)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.09);
% [X_1,iteration(10)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.1);
% [X_11,iteration(11)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.11);
% [X_12,iteration(12)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.12);
% [X_13,iteration(13)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.13);
% [X_14,iteration(14)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.14);
% [X_15,iteration(15)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.15);
% [X_16,iteration(16)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.16);
% [X_17,iteration(17)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.17);
% [X_18,iteration(18)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.18);
% [X_19,iteration(19)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.19);
% [X_20,iteration(20)] = SRR_MAP(B.coronal,B.sagital,B.axial,0.20);

function [ITER]=choix_landa(coronal,sagital,axial)


b=input('Entrer landa initial\n');
pas=input('Entrer le pas\n');
TOTAL=input('Entrer le nombre de tests\n');

for i=0:TOTAL
[~,ITER(1,i+1)] = SRR_MAP(coronal,sagital,axial,b+(i*pas));
ITER(2,i+1)=b+(i*pas);
end

demande=menu('afficher ?','oui','oui en log10','non');


if demande==1
    plot(ITER(2,:),ITER(1,:));
end

if demande==2
     plot(log10(ITER(2,:)),ITER(1,:));
end



end
