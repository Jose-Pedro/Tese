function vector=resizer(x,num,den)


z=interp(x,num);
vector=decimate(z,den);