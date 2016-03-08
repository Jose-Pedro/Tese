filename = 'trajectory.txt';
delimiterIn = ',';

A = importdata(filename,delimiterIn);

save data.mat A

A=load ('data.mat');
