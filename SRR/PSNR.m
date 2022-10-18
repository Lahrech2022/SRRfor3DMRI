function [alpha,MSE]=PSNR(Image1,Image2)

%roi1 est tracée dans le signal, roi 2 est tracée dans le bruit.
s=size(Image1);
i=0;
j=0;
k=0;
MSE=0;
MAX=input('Entrer le maximum d intensité de l image \n');


for i=1:s(1)
    for j=1:s(2)
        for k=1:s(3)
           MSE=MSE+((Image1(i,j,k)-Image2(i,j,k))*(Image1(i,j,k)-Image2(i,j,k))); 
          
        end
    end
end
MSE=MSE/(s(1)*s(2)*s(3));


alpha=10*log10((MAX*MAX)/MSE);
end