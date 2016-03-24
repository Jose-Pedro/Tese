function Data=pcvectorwarping(pc1,pc2,pc3,pc4,pc5,pc6,g1,g2,g3,g4,g5,g6,i,printflag)


[m1,n1]=size(pc1);
[m2,n2]=size(pc2);
[m3,n3]=size(pc3);
[m4,n4]=size(pc4);
[m5,n5]=size(pc5);
[m6,n6]=size(pc6);

% On a first aproach i resized data to the smallest Data vector and performed DTW on the 
% resulting mean for all the vectors. First i select the smallest size from all the vectors size 
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
vector1_pc=Resizer(pc1',aux,m1);
vector2_pc=Resizer(pc2',aux,m2);
vector3_pc=Resizer(pc3',aux,m3);
vector4_pc=Resizer(pc4',aux,m4);
vector5_pc=Resizer(pc5',aux,m5);
vector6_pc=Resizer(pc6',aux,m6);

% Here we calculate the mean vector.
Vector_mean_pc= (vector1_pc + vector2_pc + vector3_pc + vector4_pc + vector5_pc + vector6_pc)/6;

% We use the function created by  Pau Micó to perform dtw and retrieve the warped vectors
% Link: http://www.mathworks.com/matlabcentral/fileexchange/16350-continuous-dynamic-time-warping


[dtw_Dist1,D1,dtw_k1,w1,vector1_pc_w,Vector_mean_w_1]=dtw(vector1_pc,Vector_mean_pc,0);
[dtw_Dist2,D2,dtw_k2,w2,vector2_pc_w,Vector_mean_w_2]=dtw(vector2_pc,Vector_mean_pc,0);
[dtw_Dist3,D3,dtw_k3,w3,vector3_pc_w,Vector_mean_w_3]=dtw(vector3_pc,Vector_mean_pc,0);
[dtw_Dist4,D4,dtw_k4,w4,vector4_pc_w,Vector_mean_w_4]=dtw(vector4_pc,Vector_mean_pc,0);
[dtw_Dist5,D5,dtw_k5,w5,vector5_pc_w,Vector_mean_w_5]=dtw(vector5_pc,Vector_mean_pc,0);
[dtw_Dist6,D6,dtw_k6,w6,vector6_pc_w,Vector_mean_w_6]=dtw(vector6_pc,Vector_mean_pc,0);

% with this we decide if we want to print the data after warping the
% vectors or not(if not just comment this line)
 str = sprintf(' %i Principal component. ',i);
if printflag
    printingFunction(aux*100/10^3,vector1_pc_w,vector2_pc_w,vector3_pc_w,vector4_pc_w,vector5_pc_w,vector6_pc_w,'Data Warping after PCA AND DTW','Data after principal component analysis and time warping ',str,'Time - 100ms each point',1,g1,g2,g3,g4,g5,g6);
end
clearvars aux
% In a first approach after vectors warping i decided to resize them again to the size of smallest
% sized vector .
approach=1;

if approach==1
        [m1,n]=size(vector1_pc_w');
        [m2,n]=size(vector2_pc_w');
        [m3,n]=size(vector3_pc_w');
        [m4,n]=size(vector4_pc_w');
        [m5,n]=size(vector5_pc_w');
        [m6,n]=size(vector6_pc_w');
        
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

        vector1_pc_w=Resizer(vector1_pc_w,aux,m1);
        vector2_pc_w=Resizer(vector2_pc_w,aux,m2);
        vector3_pc_w=Resizer(vector3_pc_w,aux,m3);
        vector4_pc_w=Resizer(vector4_pc_w,aux,m4);
        vector5_pc_w=Resizer(vector5_pc_w,aux,m5);
        vector6_pc_w=Resizer(vector6_pc_w,aux,m6);
        [m,n]=size(vector1_pc_w);% Here we define the temporal constraint
        T=n*100/10^3;
        t=0:100/10^3:T-100/10^3;
% with this we decide if we want to print the data after warping and resizing the pca
% vector or not(if not just comment this line)
if printflag
    
    printingFunction(T,vector1_pc_w,vector2_pc_w,vector3_pc_w,vector4_pc_w,vector5_pc_w,vector6_pc_w,'Data Warping after PCA, DTW and Resize','Data after  pca, time warping and resizing in the end',str,'Time - 100ms each point',1,g1,g2,g3,g4,g5,g6);
end
  
end
    clearvars aux m1 m2 m3 m4 m5 m6 n1 n2 n3 n4 n5 n6 n
Data=[t;vector1_pc_w;vector2_pc_w;vector3_pc_w;vector4_pc_w;vector5_pc_w;vector6_pc_w];

%