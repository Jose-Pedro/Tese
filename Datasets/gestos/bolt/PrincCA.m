close all;
clearvars;
clc;
%% Since we are reading the values of 12 joints here we chooose the one to
%%evaluate
joint_number=1;

%% Data reading from bolt movement (leData is a simple function that reads the formatted data 
% from txt files. We have in total six samples from two people (3 samples
% each) 
g1='medeiros-bolt2015-12-7-17-4-31';
Data1=leData(g1);
g2='medeiros-bolt2015-12-7-17-5-12';
Data2=leData(g2);
g3='medeiros-bolt2015-12-7-17-5-24';
Data3=leData(g3);
g4='rui-bolt2015-12-7-17-5-49';
Data4=leData(g4);
g5='rui-bolt2015-12-7-17-6-3';
Data5=leData(g5);
g6='rui-bolt2015-12-7-17-6-14';
Data6=leData(g6);

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



%% So we can have perception and comparison of the data we need to introduce the time constant since 
% we acquire data at a frequency of 10 hz(100 miliseconds per sample) we use that information to 
% generate the time vectors. For example we take the size of "Data1" and from a specific joint 
% number into the variable m1 -- [m1,n1]=size(Data1(:,joint_number)); and use that information to 
% build vector t1(time 1) -- t1=0:100/10^3:m1*100/10^3-100/10^3;

figure('Name','Data Warping before DTW');
[m1,n1]=size(Data1(:,joint_number));
t1=0:100/10^3:m1*100/10^3-100/10^3;
[m2,n2]=size(Data2(:,joint_number));
t2=0:100/10^3:m2*100/10^3-100/10^3;
[m3,n3]=size(Data3(:,joint_number));
t3=0:100/10^3:m3*100/10^3-100/10^3;
[m4,n4]=size(Data4(:,joint_number));
t4=0:100/10^3:m4*100/10^3-100/10^3;
[m5,n5]=size(Data5(:,joint_number));
t5=0:100/10^3:m5*100/10^3-100/10^3;
[m6,n6]=size(Data6(:,joint_number));
t6=0:100/10^3:m6*100/10^3-100/10^3;

%% On a first aproach we want to resize data to the smallest Data vector so we first select the 
% smallest size from all the vectors size then we resize the rest of the
% vectors to that size.
aux=m6;
if aux>m1
    aux=m1;
elseif aux>m2
    aux=m2;
elseif aux>m3
    aux=m3;
elseif aux>m4
    aux=m4;
elseif aux>m5
    aux=m5;
end
% Here we use the function resizer so we resize all the vectors to the
% smallest one
vector1=resizer(Data1(:,joint_number)',aux,m1);
vector2=resizer(Data2(:,joint_number)',aux,m2);
vector3=resizer(Data3(:,joint_number)',aux,m3);
vector4=resizer(Data4(:,joint_number)',aux,m4);
vector5=resizer(Data5(:,joint_number)',aux,m5);
vector6=resizer(Data6(:,joint_number)',aux,m6);


%% 
Vector_mean= (vector1 + vector1 + vector1 + vector1 + vector1 + vector1)*6;


%%
title('Data before time warping');

subplot(6,1,1)
plot(t1,Data1(:,joint_number),'r-x')
axis([0 11 -2 2])
axis on;
ylabel('Data1');
xlabel('Time');
grid on;


subplot(6,1,2)
plot(t2,Data2(:,joint_number),'b-*')
axis([0 11 -2 2])
axis on;
ylabel('Data2');
xlabel('Time');
grid on;


subplot(6,1,3)
plot(t3,Data3(:,joint_number),'r-x')
axis([0 11 -2 2])
axis on;
ylabel('Data3');
xlabel('Time');
grid on;


subplot(6,1,4)
plot(t4,Data4(:,joint_number),'b-*')
axis([0 11 -2 2])
axis on;
ylabel('Data4');
xlabel('Time');
grid on;


subplot(6,1,5)
plot(t5,Data5(:,joint_number),'r-x')
axis([0 11 -2 2])
axis on;
ylabel('Data5');
xlabel('Time');
grid on;


subplot(6,1,6)
plot(t6,Data6(:,joint_number),'b-*')
axis([0 11 -2 2])
axis on;
ylabel('Data6');
xlabel('Time');
grid on;



pflag=0;

[dtw_Dist,D,dtw_k,w,s1w,s2w]=dtw(Data1(:,joint_number),Data3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s3w,s4w]=dtw(Data2(:,joint_number),Data3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s5w,s6w]=dtw(Data3(:,joint_number),Data3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s7w,s8w]=dtw(Data4(:,joint_number),Data3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s9w,s10w]=dtw(Data5(:,joint_number),Data3(:,joint_number),pflag);
[dtw_Dist,D,dtw_k,w,s11w,s12w]=dtw(Data6(:,joint_number),Data3(:,joint_number),pflag);




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
% %Teste=[Data1(:,1),Data2(:,1),Data3(:,1),Data4(:,1),Data5(:,1),Data6(:,1)];
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
