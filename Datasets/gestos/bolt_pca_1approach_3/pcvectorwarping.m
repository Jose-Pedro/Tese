function Data=pcvectorwarping(pc1,pc2,pc3,pc4,pc5,pc6,g1,g2,g3,g4,g5,g6,i,printflag)


[m1,n1]=size(pc1);
[m2,n2]=size(pc2);
[m3,n3]=size(pc3);
[m4,n4]=size(pc4);
[m5,n5]=size(pc5);
[m6,n6]=size(pc6);
% On a first aproach data was resized to the smallest Data vector and performed DTW on the 
% resulting mean for all the vectors. First it was select the smallest size from all the vectors size 
% then i resized the rest of the vectors to that size.

aux=min([m1 m2 m3 m4 m5 m6]);

% Here we use the function Resizer so we resize all the vectors to the
% smallest one
vector1_pc=Resizer(pc1',aux,m1);
vector2_pc=Resizer(pc2',aux,m2);
vector3_pc=Resizer(pc3',aux,m3);
vector4_pc=Resizer(pc4',aux,m4);
vector5_pc=Resizer(pc5',aux,m5);
vector6_pc=Resizer(pc6',aux,m6);

        
        


% Here we calculate the mean vector.
T=aux*100/10^3;
t_mean=0:100/10^3:T-100/10^3;

Vector_mean_pc= (vector1_pc + vector2_pc + vector3_pc + vector4_pc + vector5_pc + vector6_pc)/6;


%% plot of the data
        T=m1*100/10^3;
        t1=0:100/10^3:T-100/10^3;
        T=m2*100/10^3;
        t2=0:100/10^3:T-100/10^3;
        T=m3*100/10^3;
        t3=0:100/10^3:T-100/10^3;
        T=m4*100/10^3;
        t4=0:100/10^3:T-100/10^3;
        T=m5*100/10^3;
        t5=0:100/10^3:T-100/10^3;
        T=m6*100/10^3;
        t6=0:100/10^3:T-100/10^3;
x_max=max([m1 m2 m3 m4 m5 m6])*100/10^3;
str = sprintf('Results from the DTW, GMM and GMR for the principal component number %i. ',i);
str2=sprintf('Original PCA data from the Principal component mumber  %i. ',i);
figure('Name',str);
subplot(5,1,1)
plot(t1,pc1,'*',t2,pc2,':',t3,pc3,'^',t4,pc4,'+',t5,pc5,'--',t6,pc6,'.',t_mean,Vector_mean_pc,'o')
grid on
axis ([0 x_max -2.5 2.5]);
title(str2)
xlabel('Time - (100 ms each point)','fontsize',12); ylabel('joint values');
legend(g1,g2,g3,g4,g5,g6,'Reference Vector used for DTW (Mean Vector)');
%% We use the function created by  Pau Micó to perform dtw and retrieve the warped vectors
% Link: http://www.mathworks.com/matlabcentral/fileexchange/16350-continuous-dynamic-time-warping


[dtw_Dist1,D1,dtw_k1,w1,vector1_pc_w,Vector_mean_w_1]=dtw(pc1,Vector_mean_pc,0);
[dtw_Dist2,D2,dtw_k2,w2,vector2_pc_w,Vector_mean_w_2]=dtw(pc2,Vector_mean_pc,0);
[dtw_Dist3,D3,dtw_k3,w3,vector3_pc_w,Vector_mean_w_3]=dtw(pc3,Vector_mean_pc,0);
[dtw_Dist4,D4,dtw_k4,w4,vector4_pc_w,Vector_mean_w_4]=dtw(pc4,Vector_mean_pc,0);
[dtw_Dist5,D5,dtw_k5,w5,vector5_pc_w,Vector_mean_w_5]=dtw(pc5,Vector_mean_pc,0);
[dtw_Dist6,D6,dtw_k6,w6,vector6_pc_w,Vector_mean_w_6]=dtw(pc6,Vector_mean_pc,0);


 
% In a first approach after vectors warping data was resize again to the size of smallest
% sized vector .

        [m1,n]=size(vector1_pc_w');
        [m2,n]=size(vector2_pc_w');
        [m3,n]=size(vector3_pc_w');
        [m4,n]=size(vector4_pc_w');
        [m5,n]=size(vector5_pc_w');
        [m6,n]=size(vector6_pc_w');
        
        aux=min([m1 m2 m3 m4 m5 m6]);

        vector1_pc_w=Resizer(vector1_pc_w,aux,m1);
        vector2_pc_w=Resizer(vector2_pc_w,aux,m2);
        vector3_pc_w=Resizer(vector3_pc_w,aux,m3);
        vector4_pc_w=Resizer(vector4_pc_w,aux,m4);
        vector5_pc_w=Resizer(vector5_pc_w,aux,m5);
        vector6_pc_w=Resizer(vector6_pc_w,aux,m6);
        [m,n]=size(vector1_pc_w);% Here we define the temporal constraint
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;


subplot(5,1,2)
plot(t,vector1_pc_w,'*',t,vector2_pc_w,':',t,vector3_pc_w,'^',t,vector4_pc_w,'+',t,vector5_pc_w,'--',t,vector6_pc_w,'.')
title('DTW -  Original Principal component data warped to the reference (mean vector) resized after time warp. ');
grid on 
axis ([0 T -2.5 2.5]);
legend(g1,g2,g3,g4,g5,g6);
xlabel('Time - (100 ms each point)','fontsize',12); ylabel('joint values','fontsize',10);

Data=[t;vector1_pc_w;vector2_pc_w;vector3_pc_w;vector4_pc_w;vector5_pc_w;vector6_pc_w];

%