close all;
clearvars;
clc;
printflag=1;
% with this we decide if we want to print the data before warping or not
printflag2=1;
%% Since we are reading the values of 12 joints here we chooose the one to
%%evaluate
joint_number=1;

%% Data reading from bolt movement (ReadData is a simple function that reads the formatted data 
% from txt files. We have in total 6 samples from two people (3 samples
% each) perfoming the same movement.
g1='medeiros-bolt2015-12-7-17-4-31';
Data1=ReadData(g1);
g2='medeiros-bolt2015-12-7-17-5-12';
Data2=ReadData(g2);
g3='medeiros-bolt2015-12-7-17-5-24';
Data3=ReadData(g3);
g4='rui-bolt2015-12-7-17-5-49';
Data4=ReadData(g4);
g5='rui-bolt2015-12-7-17-6-3';
Data5=ReadData(g5);
g6='rui-bolt2015-12-7-17-6-14';
Data6=ReadData(g6);

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

aux1=m6;
if aux1<m1
    aux1=m1;
end
if aux1<m2
    aux1=m2;
end
if aux1<m3
    aux1=m3;
end
if aux1<m4
    aux1=m4;
end
if aux1<m5
    aux1=m5;
end
% aux1 before this line is equal to the number of samples from the vector that took more time to 
% perform the movement. Then for ploting it interest us that all the time
% axis have the same right limit so we multiply the biggest amount of
% samples with the period of sampling P=100*10^-3 s;
aux1=aux1*100*10^-3; 

if printflag % with this we decide if we want to print the data before warping or not
    figure('Name','Data Warping before DTW');
    title('Data before time warping');

    subplot(6,1,1)
    plot(t1,Data1(:,joint_number),'r-x')
    axis([0 aux1 -2 2])
    axis on;
    ylabel('Data1');
    xlabel('Time');
    grid on;


    subplot(6,1,2)
    plot(t2,Data2(:,joint_number),'b-*')
    axis([0 aux1 -2 2])
    axis on;
    ylabel('Data2');
    xlabel('Time');
    grid on;


    subplot(6,1,3)
    plot(t3,Data3(:,joint_number),'r-x')
    axis([0 aux1 -2 2])
    axis on;
    ylabel('Data3');
    xlabel('Time');
    grid on;


    subplot(6,1,4)
    plot(t4,Data4(:,joint_number),'b-*')
    axis([0 aux1 -2 2])
    axis on;
    ylabel('Data4');
    xlabel('Time');
    grid on;


    subplot(6,1,5)
    plot(t5,Data5(:,joint_number),'r-x')
    axis([0 aux1 -2 2])
    axis on;
    ylabel('Data5');
    xlabel('Time');
    grid on;


    subplot(6,1,6)
    plot(t6,Data6(:,joint_number),'b-*')
    axis([0 aux1 -2 2])
    axis on;
    ylabel('Data6');
    xlabel('Time');
    grid on;
end

%% On a first aproach we want to resize data to the smallest Data vector and perform DTW on the 
% resulting mean of all the vectors. We first select the smallest size from all the vectors size 
% then we resize the rest of the vectors to that size.
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

% Here we use the function Resizer so we resize all the vectors to the
% smallest one
vector1=Resizer(Data1(:,joint_number)',aux,m1);
vector2=Resizer(Data2(:,joint_number)',aux,m2);
vector3=Resizer(Data3(:,joint_number)',aux,m3);
vector4=Resizer(Data4(:,joint_number)',aux,m4);
vector5=Resizer(Data5(:,joint_number)',aux,m5);
vector6=Resizer(Data6(:,joint_number)',aux,m6);
time=0:100/10^3:aux*100*10^-3-100/10^3;
x_axis_time=aux*100*10^-3;

% Here we calculate the mean vector.
Vector_mean= (vector1 + vector2 + vector3 + vector4 + vector5 + vector6)/6;

if printflag2 % with this we decide if we want to print the data after resizing the vectors or not
   figure('Name','Data after vector resizing');

    title('Data after vector resizing');

    subplot(7,1,1)
    plot(time,vector1,'r-x')
    axis([0 x_axis_time -2 2])
    axis on;
    ylabel('Data1');
    xlabel('Time');
    grid on;


    subplot(7,1,2)
    plot(time,vector2,'b-*')
    axis([0 x_axis_time -2 2])
    axis on;
    ylabel('Data2');
    xlabel('Time');
    grid on;


    subplot(7,1,3)
    plot(time,vector3,'r-x')
    axis([0 x_axis_time -2 2])
    axis on;
    ylabel('Data3');
    xlabel('Time');
    grid on;


    subplot(7,1,4)
    plot(time,vector4,'b-*')
    axis([0 x_axis_time -2 2])
    axis on;
    ylabel('Data4');
    xlabel('Time');
    grid on;


    subplot(7,1,5)
    plot(time,vector5,'r-x')
    axis([0 x_axis_time -2 2])
    axis on;
    ylabel('Data5');
    xlabel('Time');
    grid on;


    subplot(7,1,6)
    plot(time,vector6,'b-*')
    axis([0 x_axis_time -2 2])
    axis on;
    ylabel('Data6');
    xlabel('Time');
    grid on;
    
    subplot(7,1,7)
    plot(time,Vector_mean,'b-*')
    axis([0 x_axis_time -2 2])
    axis on;
    ylabel('Vector Mean');
    xlabel('Time');
    grid on;
end

%% We use the function created by  Pau Micó to perform dtw and retrieve the warped vectors
% Link: http://www.mathworks.com/matlabcentral/fileexchange/16350-continuous-dynamic-time-warping


pflag=0;

[dtw_Dist,D,dtw_k,w,vector1_w,Vector_mean_w_1]=dtw(vector1,Vector_mean,pflag);
[dtw_Dist,D,dtw_k,w,vector2_w,Vector_mean_w_2]=dtw(vector2,Vector_mean,pflag);
[dtw_Dist,D,dtw_k,w,vector3_w,Vector_mean_w_3]=dtw(vector3,Vector_mean,pflag);
[dtw_Dist,D,dtw_k,w,vector4_w,Vector_mean_w_4]=dtw(vector4,Vector_mean,pflag);
[dtw_Dist,D,dtw_k,w,vector5_w,Vector_mean_w_5]=dtw(vector5,Vector_mean,pflag);
[dtw_Dist,D,dtw_k,w,vector6_w,Vector_mean_w_6]=dtw(vector6,Vector_mean,pflag);




[m,n]=size(Vector_mean_w_1);
T=n*100/10^3;
t=0:100/10^3:T-100/10^3;
figure('Name','Data Warping after DTW');
title('Data after time warping -  DTW');
subplot(6,1,1)
plot(t,vector1_w,'b-*')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(Vector_mean_w_2);
T=n*100/10^3;
t=0:100/10^3:T-100/10^3;
subplot(6,1,2)

plot(t,vector2_w,'r-x')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(Vector_mean_w_3);
T=n*100/10^3;
t=0:100/10^3:T-100/10^3;
subplot(6,1,3)
plot(t,vector3_w,'b-*')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(Vector_mean_w_4);
T=n*100/10^3;
t=0:100/10^3:T-100/10^3;
subplot(6,1,4)

plot(t,vector4_w,'r-x')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(Vector_mean_w_5);
T=n*100/10^3;
t=0:100/10^3:T-100/10^3;
subplot(6,1,5)

plot(t,vector5_w,'b-x')
axis on;
xlabel('Time');
grid on;
hold on;

[m,n]=size(Vector_mean_w_6);
T=n*100/10^3;
t=0:100/10^3:T-100/10^3;
subplot(6,1,6)

plot(t,vector6_w,'r-x')
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
