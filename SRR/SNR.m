function [alpha]=SNR(roi1,roi2,time)

%roi1 est tracée dans le signal, roi 2 est tracée dans le bruit. Le temps
%doit être en secondes.
alpha=0;
if nargin==2
alpha=roi1.mean/std(roi2.vect);
end

if nargin==3
alpha=roi1.mean/(std(roi2.vect)*time);
end

end