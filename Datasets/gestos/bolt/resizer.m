function vector=resizer(x,num,den)


z=decimate(x,num);
vector=interp(z,den);