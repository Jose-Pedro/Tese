close all;
clearvars;
clc;



%% with this we decide if we what data to plot
printflag=4;


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

        aux=max([size(Data1(:,joint_number),1) size(Data2(:,joint_number),1) size(Data3(:,joint_number),1) size(Data4(:,joint_number),1) size(Data5(:,joint_number),1) size(Data6(:,joint_number),1)]);
        % aux before this line is equal to the number of samples from the vector that took more time to 
        % perform the movement. Then for ploting it interest us that all the time
        % axis have the same right limit so we multiply the biggest amount of
        % samples with the period of sampling P=100*10^-3 s;
        aux=aux*100*10^-3; 
      

                       str = sprintf('Data corresponding to the joint number %i  from the 6 datasets. ',joint_number);
            figure('name',str);
            printingFunction(aux,Data1(:,joint_number)',Data2(:,joint_number)',Data3(:,joint_number)',Data4(:,joint_number)',Data5(:,joint_number)',Data6(:,joint_number)','Original Data','Joint values','Time - 100ms each point',1,g1,g2,g3,g4,g5,g6);

    end
    clearvars aux 
end


n1=size(Data1,1);
T=n1*100/10^3;
t1=0:100/10^3:T-100/10^3;
n2=size(Data2,1);
T=n2*100/10^3;
t2=0:100/10^3:T-100/10^3;
n3=size(Data3,1);
T=n3*100/10^3;
t3=0:100/10^3:T-100/10^3;
n4=size(Data4,1);
T=n4*100/10^3;
t4=0:100/10^3:T-100/10^3;
n5=size(Data5,1);
T=n5*100/10^3;
t5=0:100/10^3:T-100/10^3;
n6=size(Data6,1);
T=n6*100/10^3;
t6=0:100/10^3:T-100/10^3;
a=[Data1(:,1) ;  Data2(:,1) ; Data3(:,1);Data4(:,1);Data5(:,1);Data6(:,1)];
b=[t1';t2';t3';t4';t5';t6'];
H=[b a];

GMM_Result(1,H',5,1,Data1,Data2,Data3,Data4,Data5,Data6,g1,g2,g3,g4,g5,g6); 

