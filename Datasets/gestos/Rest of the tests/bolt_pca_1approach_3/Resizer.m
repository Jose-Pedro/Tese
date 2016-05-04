function vector=Resizer(x,num,den)
%% num/den give us a factor of resizing that is pretended for our vector x.
% input:
% x-Vector to be resized.
% num - final size pretended.
% den - size of x.

if num == den % ignore when the factor is equal to 1.
    vector=x; 
else

z=interp(x,num);
vector=decimate(z,den);
end