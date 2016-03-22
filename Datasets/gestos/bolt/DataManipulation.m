close all;
clearvars;
clc;




%% with this we decide if we what data to plot
printflag=4;

approach=1;
% with this we decide if we want to print the data after resizing the warped vectors or not
%% Since we are reading the values of 12 joints here we chooose the one to
%  evaluate
joint_number=1;

%% Here we choosed to analyse the Data from bolt movement (ReadData is a simple function that reads 
% the formatted data from txt files. We have in total 6 samples from two people (3 samples each) 
% perfoming the same movement.
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




%% So we can have perception and comparison of the data we need to introduce the time constant since 
% we acquire data at a frequency of 10 hz(100 miliseconds per sample) we use that information to 
% generate the time vectors. For example we take the size of "Data1" and from a specific joint 
% number into the variable m1 -- [m1,n1]=size(Data1(:,joint_number)); and use that information to 
% build vector t1(time 1) -- t1=0:100/10^3:m1*100/10^3-100/10^3;
if (printflag==1 || printflag==0)
    for i=1:6 % for the first 6 joints
        joint_number=i;
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

                       str = sprintf('Data corresponding to the %i joint from the 6 datasets. ',joint_number);

            printingFunction(Data1(:,joint_number)',Data2(:,joint_number)',Data3(:,joint_number)',Data4(:,joint_number)',Data5(:,joint_number)',Data6(:,joint_number)','Data Warping before DTW',str,'Joint values','Time - 100ms each point',1,g1,g2,g3,g4,g5,g6);

    end
    clearvars aux1 t1 t2 t3 t4 t5 t6 m1 m2 m3 m4 m5 m6 n1 n2 n3 n4 n5 n6
end


%% In this section i applied PCA to the six Datasets:

%% Dataset number 1
disp('Dataset:  ' );
disp(g1);
[w1, pc1, ev1] = pca(Data1);
% pc is the matrix of principal components.
% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu1 = mean(Data1);
xhat1 = bsxfun(@minus,Data1,mu1); % subtract the mean
norm(pc1 * w1' - xhat1);
% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically   (Data1 - mean) * w = pc     <=>      Data1 = mean1 + pc1 * w1'
Relevance1=ev1/sum(ev1)*100;
num_pc1=1;% number of principal components to use
while(num_pc1<=size(ev1,1))
    
    performance1=0;

    for i=1:num_pc1
    performance1=Relevance1(i)+performance1;
    end
    if performance1>99 % In this case we are satisfied with 99% of precision in data recovery
        % with this we select the number of PC needed to accomplish that
    break;
    
    end
    num_pc1=num_pc1+1;
    
end
performance1
num_pc1


%% Dataset number 2
disp('Dataset:  ' );
disp(g2);
[w2, pc2, ev2] = pca(Data2);
% pc is the matrix of principal components.
% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu2 = mean(Data2);
xhat2 = bsxfun(@minus,Data2,mu2); % subtract the mean
norm(pc2 * w2' - xhat2);
% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically   (Data2 - mean) * w = pc     <=>      Data2 = mean2 + pc2 * w2'
Relevance2=ev2/sum(ev2)*100;
num_pc2=1;% number of principal components to use
while(num_pc2<=size(ev2,1))
    
    performance2=0;

    for i=1:num_pc2
    performance2=Relevance2(i)+performance2;
    end
    if performance2>99 % In this case we are satisfied with 99% of precision in data recovery
        % with this we select the number of PC needed to accomplish that
    break;
    
    end
    num_pc2=num_pc2+1;
    
end
performance2
num_pc2


%% Dataset number 3
disp('Dataset: ' );
disp(g3);
[w3, pc3, ev3] = pca(Data3);
% pc is the matrix of principal components.
% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu3 = mean(Data3);
xhat3 = bsxfun(@minus,Data3,mu3); % subtract the mean
norm(pc3 * w3' - xhat3);
% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically   (Data3 - mean) * w = pc     <=>      Data3 = mean3 + pc3 * w3'
Relevance3=ev3/sum(ev3)*100;
num_pc3=1;% number of principal components to use
while(num_pc3<=size(ev3,1))
    
    performance3=0;

    for i=1:num_pc3
    performance3=Relevance3(i)+performance3;
    end
    if performance3>99 % In this case we are satisfied with 99% of precision in data recovery
        % with this we select the number of PC needed to accomplish that
    break;
    
    end
    num_pc3=num_pc3+1;
    
end
performance3
num_pc3

%% Dataset number 4
disp('Dataset: ' );
disp(g4);

[w4, pc4, ev4] = pca(Data4);

% pc is the matrix of principal components.
% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu4 = mean(Data4);
xhat4 = bsxfun(@minus,Data4,mu4); % subtract the mean
norm(pc4 * w4' - xhat4);
% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically   (Data4 - mean) * w = pc     <=>      Data4 = mean4 + pc4 * w4'
Relevance4=ev4/sum(ev4)*100;
num_pc4=1;% number of principal components to use
while(num_pc4<=size(ev4,1))
    
    performance4=0;

    for i=1:num_pc4
    performance4=Relevance4(i)+performance4;
    end
    if performance4>99 % In this case we are satisfied with 99% of precision in data recovery
        % with this we select the number of PC needed to accomplish that
    break;
    
    end
    num_pc4=num_pc4+1;
    
end
performance4
num_pc4



%% Dataset number 5
disp('Dataset: ' );
disp(g5);

[w5, pc5, ev5] = pca(Data5);

% pc is the matrix of principal components.
% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu5 = mean(Data5);
xhat5 = bsxfun(@minus,Data5,mu5); % subtract the mean
norm(pc5 * w5' - xhat5);
% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically   (Data5 - mean) * w = pc     <=>      Data5 = mean5 + pc5 * w5'
Relevance5=ev5/sum(ev5)*100;
num_pc5=1;% number of principal components to use
while(num_pc5<=size(ev5,1))
    
    performance5=0;

    for i=1:num_pc5
    performance5=Relevance5(i)+performance5;
    end
    if performance5>99% In this case we are satisfied with 99% of precision in data recovery
        % with this we select the number of PC needed to accomplish that
    break;
    
    end
    num_pc5=num_pc5+1;
    
end
performance5
num_pc5


%% Dataset number 6
disp('Dataset: ' );
disp(g6);
[w6, pc6, ev6] = pca(Data6);
% pc is the matrix of principal components.
% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu6 = mean(Data6);
xhat6 = bsxfun(@minus,Data6,mu6); % subtract the mean
norm(pc6 * w6' - xhat6);
% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically   (Data6 - mean) * w = pc     <=>      Data6 = mean6 + pc6 * w6'
Relevance6=ev6/sum(ev6)*100;
num_pc6=1;% number of principal components to use
while(num_pc6<=size(ev6,1))
    
    performance6=0;

    for i=1:num_pc6
    performance6=Relevance6(i)+performance6;
    end
    if performance6>99 % In this case we are satisfied with 99% of precision in data recovery
        % with this we select the number of PC needed to accomplish that
    break;
    
    end
    num_pc6=num_pc6+1;
    
end
performance6
num_pc6

%% We reach here and we check the performance that uses the higher number of principal components
%  to reach the 99% and and we use that number of pca for all other
%  datasets in this case performance3 used 4 p.c. being the max number of
%  p.c. used among the datasets.
number_pc=4;

Data=zeros(7,70);
GMR_Data=zeros(4,2,100);
GMR_Sigma=zeros(4,1,1,100);
for i=1:number_pc
    
    Data=pcvectorwarping(pc1(:,i),pc2(:,i),pc3(:,i),pc4(:,i),pc5(:,i),pc6(:,i),g1,g2,g3,g4,g5,g6,i,0);

    [GMR_Data(i,:,:) , GMR_Sigma(i,1,1,:)]=GMM_Result(Data,6,0);
end




%% % To get an approximation to the original data, we can start dropping 
% % columns from the computed principal components. To get an idea of which
% % columns to drop, we examine the ev variable
% Xapprox = pc1(:,1:num_pc1) * w1(:,1:num_pc1)';
% Xapprox = bsxfun(@plus,mu1,Xapprox); % add the mean back in
% figure;
% plot(Xapprox(:,2),'*b'); hold on; plot(Data1(:,2),'.r')
% 
% xlabel('Approximation - blue '); ylabel('Actual value -  red'); grid on;


