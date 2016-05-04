close all;
clearvars;
clc;




%% with this we decide if we want to print the data before warping or not
printflag=1;
printflag2=1;
printflag3=1;

printflag4=1;
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

%% On a first aproach i resized data to the smallest Data vector and performed DTW on the 
% resulting mean of all the vectors. First i select the smallest size from all the vectors size 
% then i resized the rest of the vectors to that size.
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



if printflag3 % with this we decide if we want to print the data after warping the vectors or not
    
    figure('Name','Data Warping after DTW');
    title('Data after time warping -  DTW');
    
    [m,n]=size(vector1_w);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    
    subplot(6,1,1)
    plot(t,vector1_w,'b-*')
    axis on;
    xlabel('Time');
    grid on;
    hold on;

    [m,n]=size(vector2_w);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    subplot(6,1,2)

    plot(t,vector2_w,'r-x')
    axis on;
    xlabel('Time');
    grid on;
    hold on;

    [m,n]=size(vector3_w);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    subplot(6,1,3)
    plot(t,vector3_w,'b-*')
    axis on;
    xlabel('Time');
    grid on;
    hold on;

    [m,n]=size(vector4_w);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    subplot(6,1,4)

    plot(t,vector4_w,'r-x')
    axis on;
    xlabel('Time');
    grid on;
    hold on;

    [m,n]=size(vector5_w);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    subplot(6,1,5)

    plot(t,vector5_w,'b-x')
    axis on;
    xlabel('Time');
    grid on;
    hold on;

    [m,n]=size(vector6_w);
    T=n*100/10^3;
    t=0:100/10^3:T-100/10^3;
    subplot(6,1,6)

    plot(t,vector6_w,'r-x')
    axis on;
    xlabel('Time');
    grid on;
    hold on;
end

%% Here after warping the vectors there's the need to decide the approach to take since the warped
% vectors have bigger diferent sizes 



% In a first approach after vectors warping i decided to resize them again to the size of smallest
% sized vector  again
approach=2;

if approach==1
        [m1,n]=size(vector1_w');
        [m2,n]=size(vector2_w');
        [m3,n]=size(vector3_w');
        [m4,n]=size(vector4_w');
        [m5,n]=size(vector5_w');
        [m6,n]=size(vector6_w');

        vector1=Resizer(vector1_w',aux,m1);
        vector2=Resizer(vector2_w',aux,m2);
        vector3=Resizer(vector3_w',aux,m3);
        vector4=Resizer(vector4_w',aux,m4);
        vector5=Resizer(vector5_w',aux,m5);
        vector6=Resizer(vector6_w',aux,m6);


    if printflag4 % with this its possible to decide if there is the need to print the data after 
        % resizing the warped vectors  or not
        
        figure('Name','Data after vector resizing');

       

        subplot(6,1,1)
        plot(time,vector1,'r-x')
        axis([0 x_axis_time -2 2])
        axis on;
         title('Data after vector resizing');
        xlabel(g1);
        grid on;


        subplot(6,1,2)
        plot(time,vector2,'b-*')
        axis([0 x_axis_time -2 2])
        axis on;
        xlabel(g2);
        grid on;


        subplot(6,1,3)
        plot(time,vector3,'r-x')
        axis([0 x_axis_time -2 2])
        axis on;
        
        xlabel(g3);
        grid on;


        subplot(6,1,4)
        plot(time,vector4,'b-*')
        axis([0 x_axis_time -2 2])
        axis on;
       
        xlabel(g4);
        grid on;


        subplot(6,1,5)
        plot(time,vector5,'r-x')
        axis([0 x_axis_time -2 2])
        axis on;
       
        xlabel(g5);
        grid on;


        subplot(6,1,6)
        plot(time,vector6,'b-*')
        axis([0 x_axis_time -2 2])
        axis on;
       
        xlabel(g6);
        grid on;


    end
end

% In a second approach after vectors warping i decided to add points to the begining since the 
% robot is stopped for a some time before starting the movement



if approach==2
        [m1,n]=size(vector1_w');
        [m2,n]=size(vector2_w');
        [m3,n]=size(vector3_w');
        [m4,n]=size(vector4_w');
        [m5,n]=size(vector5_w');
        [m6,n]=size(vector6_w');

        
        
        aux=m6;
        if aux<m1
           aux=m1;
        end
        if aux<m2
           aux=m2;
        end
        if aux<m3
           aux=m3;
        end
        if aux<m4
           aux=m4;
        end
        if aux<m5
           aux=m5;
        end
        
        
        value=aux-m1;
        while(value>0)
            vector1_w=[vector1_w(1) vector1_w]; 
            value=value -1 ;     
        
        end
        value=aux-m2;
        while(value>0)
            vector2_w=[vector2_w(1) vector2_w]; 
            value=value -1 ;     
        
        end
        value=aux-m3;
        while(value>0)
            vector3_w=[vector3_w(1) vector3_w]; 
            value=value -1 ;     
        
        end
        value=aux-m4;
        while(value>0)
            vector4_w=[vector4_w(1) vector4_w]; 
            value=value -1 ;     
        
        end
        value=aux-m5;
        while(value>0)
            vector5_w=[vector5_w(1) vector5_w]; 
            value=value -1 ;     
        
        end
        value=aux-m6;
        while(value>0)
            vector6_w=[vector6_w(1) vector6_w]; 
            value=value -1 ;     
        
        end
        
        
    if printflag4 % with this we decide if we want to print the data or not

        figure('Name','Data Warping after DTW');
        

        [m,n]=size(vector1_w);
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;

        subplot(6,1,1)
        plot(t,vector1_w,'b-*')
        title('Data after time warping and adding points in the begining -  DTW');
        axis on;
        xlabel('Time');
        grid on;
        hold on;

        [m,n]=size(vector2_w);
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;
        subplot(6,1,2)

        plot(t,vector2_w,'r-x')
        axis on;
        xlabel('Time');
        grid on;
        hold on;

        [m,n]=size(vector3_w);
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;
        subplot(6,1,3)
        plot(t,vector3_w,'b-*')
        axis on;
        xlabel('Time');
        grid on;
        hold on;

        [m,n]=size(vector4_w);
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;
        subplot(6,1,4)

        plot(t,vector4_w,'r-x')
        axis on;
        xlabel('Time');
        grid on;
        hold on;

        [m,n]=size(vector5_w);
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;
        subplot(6,1,5)

        plot(t,vector5_w,'b-x')
        axis on;
        xlabel('Time');
        grid on;
        hold on;

        [m,n]=size(vector6_w);
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;
        subplot(6,1,6)

        plot(t,vector6_w,'r-x')
        axis on;
        xlabel('Time');
        grid on;
        hold on;
    end
        
        
        
end


%%
%X = [vector1_w ; vector2_w ;vector3_w; vector4_w; vector5_w; vector6_w]';
X=Data1;





[w, pc, ev] = pca(X);
% pc is the matrix of principal components.


%% The combination pc * w' will recreate the original data, minus its mean.
% The mean is always subtracted prior to performing PCA. Therefore to get 
% the original data we do
mu = mean(X);
xhat = bsxfun(@minus,X,mu); % subtract the mean
norm(pc * w' - xhat);


% Because w is orthogonal, you also have Xhat * w = pc, 
% or schematically   (X - mean) * w = pc     <=>      X = mean + pc * w'



Relevance=ev/sum(ev)*100
num_pc=1;% number of principal components to use
while(num_pc<=size(ev,1))
    
    performance=0;

    for i=1:num_pc
    performance=Relevance(i)+performance;
    end
    if performance>99.9 % In this case we are satisfied with 99.9% of precision in data recovery
        % with this we select the number of PC needed to accomplish that
    break;
    
    end
    num_pc=num_pc+1;
    
end
performance
num_pc

%% To get an approximation to the original data, we can start dropping 
% columns from the computed principal components. To get an idea of which
% columns to drop, we examine the ev variable
Xapprox = pc(:,1:5) * w(:,1:5)';
Xapprox = bsxfun(@plus,mu,Xapprox); % add the mean back in
figure;
plot(Xapprox(:,2),'*b'); hold on; plot(X(:,2),'.r')

xlabel('Approximation - blue '); ylabel('Actual value -  red'); grid on;


