close all;
clearvars;
clc;
Y = randn(100,2);
W = [1 1; 1 -1; 2 1; 2 -1]';
X = Y * W + 0.1 * randn(100,4);
joint_number=1;
g='medeiros-bolt2015-12-7-17-4-31';
Dados1=leDados(g);
g='medeiros-bolt2015-12-7-17-5-12';
Dados2=leDados(g);
g='medeiros-bolt2015-12-7-17-5-24';
Dados3=leDados(g);
g='rui-bolt2015-12-7-17-5-49';
Dados4=leDados(g);
g='rui-bolt2015-12-7-17-6-3';
Dados5=leDados(g);
g='rui-bolt2015-12-7-17-6-14';
Dados6=leDados(g);

% XNorm = X;
% mu = zeros(1, size(X, 2));
% stddev = zeros(1, size(X, 2));
% 
% % Calculates mean and std dev for each feature
% for i=1:size(mu,2)
%     mu(1,i) = mean(X(:,i)); 
%     stddev(1,i) = std(X(:,i));
%     XNorm(:,i) = (X(:,i)-mu(1,i))/stddev(1,i);
% end
% 



%% Para termos de perceção e comparação de resultados é importante comparar
% as variáveis temporalmente
% Sabendo que as amostras têm uma frequência 10 hz(100 milisegundos por amostra) e a maior recolha de
% dados foi de entre os Dados1 e Dados2 foi 104:




figure('Name','Data Warping before DTW');
[m,n]=size(Dados1(:,joint_number));
t1=0:100/10^3:m*100/10^3-100/10^3;
[m,n]=size(Dados2(:,joint_number));
t2=0:100/10^3:m*100/10^3-100/10^3;
[m,n]=size(Dados3(:,joint_number));
t3=0:100/10^3:m*100/10^3-100/10^3;
[m,n]=size(Dados4(:,joint_number));
t4=0:100/10^3:m*100/10^3-100/10^3;
[m,n]=size(Dados5(:,joint_number));
t5=0:100/10^3:m*100/10^3-100/10^3;
[m,n]=size(Dados6(:,joint_number));
t6=0:100/10^3:m*100/10^3-100/10^3;


title('Data before time warping');

subplot(6,1,1)
plot(t1,Dados1(:,joint_number),'r-x')
axis([0 11 -2 2])
axis on;
ylabel('Dados1');
xlabel('Time');
grid on;


subplot(6,1,2)
plot(t2,Dados2(:,joint_number),'b-*')
axis([0 11 -2 2])
axis on;
ylabel('Dados2');
xlabel('Time');
grid on;


subplot(6,1,3)
plot(t3,Dados3(:,joint_number),'r-x')
axis([0 11 -2 2])
axis on;
ylabel('Dados3');
xlabel('Time');
grid on;


subplot(6,1,4)
plot(t4,Dados4(:,joint_number),'b-*')
axis([0 11 -2 2])
axis on;
ylabel('Dados4');
xlabel('Time');
grid on;


subplot(6,1,5)
plot(t5,Dados5(:,joint_number),'r-x')
axis([0 11 -2 2])
axis on;
ylabel('Dados5');
xlabel('Time');
grid on;


subplot(6,1,6)
plot(t6,Dados6(:,joint_number),'b-*')
axis([0 11 -2 2])
axis on;
ylabel('Dados6');
xlabel('Time');
grid on;



pflag=0;

[dtw_Dist,D,dtw_k,w,s1w,s2w]=dtw(Dados1(:,joint_number),Dados3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s3w,s4w]=dtw(Dados2(:,joint_number),Dados3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s5w,s6w]=dtw(Dados3(:,joint_number),Dados3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s7w,s8w]=dtw(Dados4(:,joint_number),Dados3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s9w,s10w]=dtw(Dados5(:,joint_number),Dados3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s11w,s12w]=dtw(Dados6(:,joint_number),Dados3(:,joint_number),pflag);




[m,n]=size(s2w);
T_maior_amostra=n*100/10^3;
t=0:100/10^3:T_maior_amostra-100/10^3;
figure('Name','Data Warping after DTW');
title('Data after time warping -  DTW');
subplot(6,1,1)
plot(t,s1w,'b-*')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(s4w);
T_maior_amostra=n*100/10^3;
t=0:100/10^3:T_maior_amostra-100/10^3;
subplot(6,1,2)

plot(t,s3w,'r-x')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(s6w);
T_maior_amostra=n*100/10^3;
t=0:100/10^3:T_maior_amostra-100/10^3;
subplot(6,1,3)
plot(t,s5w,'b-*')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(s8w);
T_maior_amostra=n*100/10^3;
t=0:100/10^3:T_maior_amostra-100/10^3;
subplot(6,1,4)

plot(t,s7w,'r-x')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(s10w);
T_maior_amostra=n*100/10^3;
t=0:100/10^3:T_maior_amostra-100/10^3;
subplot(6,1,5)

plot(t,s9w,'b-x')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(s12w);
T_maior_amostra=n*100/10^3;
t=0:100/10^3:T_maior_amostra-100/10^3;
subplot(6,1,6)

plot(t,s11w,'r-x')
axis on;
xlabel('Time');
grid on;
hold on;


% 
% 
% 
% %Teste=[Dados1(:,1),Dados2(:,1),Dados3(:,1),Dados4(:,1),Dados5(:,1),Dados6(:,1)];
% [w, pc, ev] = pca(X);
% 
% 
% %% How should you interpret these? Well, pc is the matrix of principal  
% % components.It should pull out factors very close to the original Y 
% % variables. You can check this:
% corr(pc(:,1),Y(:,1));
% corr(pc(:,2),Y(:,2)); 
% %Here we can evaluate the precision of the factors
% 
% 
% %% The combination pc * w' will recreate the original data, minus its mean.
% % The mean is always subtracted prior to performing PCA. Therefore to get 
% % the original data we do
% mu = mean(X);
% xhat = bsxfun(@minus,X,mu); % subtract the mean
% norm(pc * w' - xhat);
% 
% 
% %% Because w is orthogonal, you also have Xhat * w = pc, 
% % or schematically (i.e. this code won't execute) 
% % (X - mu) * w = pc     <=>      X = mu + pc * w'
% 
% 
% %% To get an approximation to your original data, you can start dropping 
% %columns from the computed principal components. To get an idea of which
% % columns to drop, we examine the ev variable
% 
% Relevancia=ev/sum(ev)*100
% 
% 
% Xapprox = pc(:,1:2) * w(:,1:2)';
% Xapprox = bsxfun(@plus,mu,Xapprox); % add the mean back in
% figure;
%  plot(Xapprox(:,1),'*b'); hold on; plot(X(:,1),'.r')
% 
% xlabel('Approximation '); ylabel('Actual value -  red'); grid on;
% 
% 
