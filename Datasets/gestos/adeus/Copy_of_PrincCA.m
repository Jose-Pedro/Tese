close all;
clearvars;
clc;
Y = randn(100,2);
W = [1 1; 1 -1; 2 1; 2 -1]';

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
X=Dados1(:,1);
XNorm = Dados1(:,1);
mu = zeros(1, size(X, 2));
stddev = zeros(1, size(X, 2));

% Calculates mean and std dev for each feature
for i=1:size(mu,2)
    mu(1,i) = mean(X(:,i)); 
    stddev(1,i) = std(X(:,i));
    XNorm(:,i) = (X(:,i)-mu(1,i))/stddev(1,i);
end




%% Para termos de perceção e comparação de resultados é importante comparar
% as variáveis temporalmente
% Sabendo que as amostras têm uma frequência 10 hz(100 milisegundos por amostra) e a maior recolha de
% dados foi de entre os Dados1 e Dados2 foi 104:
T_maior_amostra=89*100/10^3;
t=0:100/10^3:T_maior_amostra-100/10^3;
pflag=1;

[dtw_Dist,D,dtw_k,w,s1w,s2w]=dtw(Dados1(:,1),Dados4(:,1),pflag);


[m,n]=size(Dados1(:,1));
t1=0:100/10^3:m*100/10^3-100/10^3;
[m,n]=size(Dados4(:,1));
t2=0:100/10^3:m*100/10^3-100/10^3;


figure('Name','Normalization');
plot(t1,Dados1(:,1),'r-x')
hold on;
plot(t1,XNorm,'b-*')

figure('Name','Data Warping before and after');
subplot(2,1,1)

plot(t1,Dados1(:,1),'r-x')
hold on;
plot(t2,Dados4(:,1),'b-*')
axis on;
xlabel('Time');
grid on;
title('Data before time warping');

subplot(2,1,2)

plot(t,s1w,'r-x')
hold on;
plot(t,s2w,'b-*')
axis on;
xlabel('Time');
grid on;
title('Data after time warping -  DTW');



X = Y * W + 0.1 * randn(100,4);

%Teste=[Dados1(:,1),Dados2(:,1),Dados3(:,1),Dados4(:,1),Dados5(:,1),Dados6(:,1)];
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
figure;
 plot(Xapprox(:,1),'*b'); hold on; plot(X(:,1),'.r')

xlabel('Approximation '); ylabel('Actual value -  red'); grid on;


