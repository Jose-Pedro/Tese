close all;
clearvars;
clc;
Y = randn(100,2);
W = [1 1; 1 -1; 2 1; 2 -1]';
X = Y * W + 0.1 * randn(100,4);

g='medeiros-adeus2015-12-7-16-42-35';
Dados1=leDados(g);
g='medeiros-adeus2015-12-7-16-42-49';
Dados2=leDados(g);
g='medeiros-adeus2015-12-7-16-43-4';
Dados3=leDados(g);
g='rui-adeus2015-12-7-16-40-55';
Dados4=leDados(g);
g='rui-adeus2015-12-7-16-41-18';
Dados5=leDados(g);
g='rui-adeus2015-12-7-16-42-2';
Dados6=leDados(g);

[w, pc, ev] = pca(X);


%% How should you interpret these? Well, pc is the matrix of principal  
% components.It should pull out factors very close to the original Y 
% variables. You can check this:
corr(pc(:,1),Y(:,1));
corr(pc(:,2),Y(:,2)); 
%Here we can evaluate the precision of the factors


%% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu = mean(X);
xhat = bsxfun(@minus,X,mu); % subtract the mean
norm(pc * w' - xhat);


%% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically (i.e. this code won't execute) 
% (X - mu) * w = pc     <=>      X = mu + pc * w'


%% To get an approximation to your original data, you can start dropping 
%columns from the computed principal components. To get an idea of which
% columns to drop, we examine the ev variable

Relevancia=ev/sum(ev)*100


Xapprox = pc(:,1:2) * w(:,1:2)';
Xapprox = bsxfun(@plus,mu,Xapprox); % add the mean back in

 plot(Xapprox(:,1),'*b'); hold on; plot(X(:,1),'.r')

xlabel('Approximation '); ylabel('Actual value -  red'); grid on;


