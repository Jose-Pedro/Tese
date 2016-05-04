close all;
clearvars;
clc;



%% with this we decide if we what data to plot
printflag=1;

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
      

                       str = sprintf('Data corresponding to the joint number %i  from the 6 datasets. ',joint_number);

            printingFunction(aux1,Data1(:,joint_number)',Data2(:,joint_number)',Data3(:,joint_number)',Data4(:,joint_number)',Data5(:,joint_number)',Data6(:,joint_number)','Original Data',str,'Joint values','Time - 100ms each point',1,g1,g2,g3,g4,g5,g6);

    end
    clearvars aux1 t1 t2 t3 t4 t5 t6 m1 m2 m3 m4 m5 m6 n1 n2 n3 n4 n5 n6
end

joint=1;

    Data=vectorwarping(Data1(:,joint),Data2(:,joint),Data3(:,joint),Data4(:,joint),Data5(:,joint),Data6(:,joint),g1,g2,g3,g4,g5,g6,joint,0);
    [GMR_Data(i,:,:) , GMR_Sigma(i,1,1,:)]=GMR_Result2(joint,Data,6,1);
%     
% a=GMR_Data([1,2],:);
% Signature=a(:,:);    
% 
%     
% figure('Name','Original Datasets and final signature. Before resizing');
% plotGMM(GMR_Data([1,2],:), GMR_Sigma(1,1,:), [0 0 .8], 3);
% title(['Original Datasets and final signature from the joint number  ' num2str(joint)],'fontsize',16)
% hold on;
% h(2) = plot(Data1(:,joint),'y-*');
% hold on
% h(3)=plot(Data2(:,joint),'r-x');
% hold on; 
% h(4)=plot(Data3(:,joint),'m-.');
% hold on; 
% h(5)=plot(Data4(:,joint),'g-o');
% hold on; 
% h(6)=plot(Data5(:,joint),'c-+');
% hold on; 
% h(7)=plot(Data6(:,joint),'k-s');
% hold on; 
% grid on
% legend(h,'Signature', g1, g2, g3, g4, g5, g6);
% % 
% %         
% %         vectors=GMR_Data([1,2],:);
% %         vector1=Data1(:,joint);
% %         vector2=Data2(:,joint);
% %         vector3=Data3(:,joint);
% %         vector4=Data4(:,joint);
% %         vector5=Data5(:,joint);
% %         vector6=Data6(:,joint);
% %         
% %         
% % 
% %         [m1,n]=size(vector1);
% %         [m2,n]=size(vector2);
% %         [m3,n]=size(vector3);
% %         [m4,n]=size(vector4);
% %         [m5,n]=size(vector5);
% %         [m6,n]=size(vector6);
% %         [m7,n]=size(vectors);
% %         
% %         aux=m7;
% %         if aux>m1
% %             aux=m1;
% %         elseif aux>m2
% %             aux=m2;
% %         elseif aux>m3
% %             aux=m3;
% %         elseif aux>m4
% %             aux=m4;
% %         elseif aux>m5
% %             aux=m5;
% %         elseif aux>m6
% %             aux=m6;
% %         end
% % 
% %         vector1=Resizer(vector1,aux,m1);
% %         vector2=Resizer(vector2,aux,m2);
% %         vector3=Resizer(vector3,aux,m3);
% %         vector4=Resizer(vector4,aux,m4);
% %         vector5=Resizer(vector5,aux,m5);
% %         vector6=Resizer(vector6,aux,m6);
% %         vectors=Resizer(vectors,aux,m7);
% %         [m,n]=size(vector1);% Here we define the temporal constraint
% %         T=m*100/10^3;
% %         t=0:100/10^3:T-100/10^3;
% % 
% % figure('Name','Original Datasets and final signature. After resizing');
% % h(1)=plot(t,vectors,'^-b'); 
% % title(['Original Datasets and final signature from the joint number  ' num2str(joint)],'fontsize',16)
% % hold on;
% % h(2) = plot(t,vector1,'y-*');
% % hold on
% % h(3)=plot(t,vector2,'r-x');
% % hold on; 
% % h(4)=plot(t,vector3,'m-.');
% % hold on; 
% % h(5)=plot(t,vector4,'g-o');
% % hold on; 
% % h(6)=plot(t,vector5,'c-+');
% % hold on; 
% % h(7)=plot(t,vector6,'k-s');
% % hold on; 
% % grid on
% % axis ([0 aux/10 -2.5 2.5]);
% % legend(h,'Signature', g1, g2, g3, g4, g5, g6);
% % 
% % 
% % 
% % 
% %     
% %     
% %     
% %     
% %     
% %     
% %     
% %     
% %     
% %     
% %     
% %     