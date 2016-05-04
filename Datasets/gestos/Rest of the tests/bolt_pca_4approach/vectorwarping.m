function Data=vectorwarping(vector1,vector2,vector3,vector4,vector5,vector6,resized,g1,g2,g3,g4,g5,g6)


% On a first aproach i resized data to the smallest Data vector and performed DTW on the 
% resulting mean for all the vectors. First i select the smallest size from all the vectors size 
% then i resized the rest of the vectors to that size.
aux=min([size(vector1,1) size(vector2,1) size(vector3,1) size(vector4,1) size(vector5,1) size(vector6,1)]);




% Here we use the function Resizer so we resize all the vectors to the
% smallest one
vector1_r=Resizer(vector1',aux,size(vector1,1));
vector2_r=Resizer(vector2',aux,size(vector2,1));
vector3_r=Resizer(vector3',aux,size(vector3,1));
vector4_r=Resizer(vector4',aux,size(vector4,1));
vector5_r=Resizer(vector5',aux,size(vector5,1));
vector6_r=Resizer(vector6',aux,size(vector6,1));

% Here we calculate the mean vector.
vector_mean=(vector1_r+ vector2_r + vector3_r + vector4_r + vector5_r + vector6_r)/6;

% We use the function created by  Pau Micó to perform dtw and retrieve the warped vectors
% Link: http://www.mathworks.com/matlabcentral/fileexchange/16350-continuous-dynamic-time-warping


[dtw_Dist1,D1,dtw_k1,w1,vector1_w,vector_mean_w_1]=dtw(vector1,vector_mean,0);
[dtw_Dist2,D2,dtw_k2,w2,vector2_w,vector_mean_w_2]=dtw(vector2,vector_mean,0);
[dtw_Dist3,D3,dtw_k3,w3,vector3_w,vector_mean_w_3]=dtw(vector3,vector_mean,0);
[dtw_Dist4,D4,dtw_k4,w4,vector4_w,vector_mean_w_4]=dtw(vector4,vector_mean,0);
[dtw_Dist5,D5,dtw_k5,w5,vector5_w,vector_mean_w_5]=dtw(vector5,vector_mean,0);
[dtw_Dist6,D6,dtw_k6,w6,vector6_w,vector_mean_w_6]=dtw(vector6,vector_mean,0);

% In a first approach after vectors warping i decided to resize them again to the size of smallest
% sized vector .
if resized % we decide if we want the data resized in the end or not
    aux=min([size(vector1_w',1) size(vector2_w',1) size(vector3_w',1) size(vector4_w',1) size(vector5_w',1) size(vector6_w',1)]);


            vector1_w=Resizer(vector1_w,aux,size(vector1_w',1));
            vector2_w=Resizer(vector2_w,aux,size(vector2_w',1));
            vector3_w=Resizer(vector3_w,aux,size(vector3_w',1));
            vector4_w=Resizer(vector4_w,aux,size(vector4_w',1));
            vector5_w=Resizer(vector5_w,aux,size(vector5_w',1));
            vector6_w=Resizer(vector6_w,aux,size(vector6_w',1));
            
            n1=size(vector1_w,2); % Here we define the temporal constraint
            T=n1*100/10^3;
            t1=0:100/10^3:T-100/10^3;
            n2=size(vector2_w,2); % Here we define the temporal constraint
            T=n2*100/10^3;
            t2=0:100/10^3:T-100/10^3;
            n3=size(vector3_w,2); % Here we define the temporal constraint
            T=n3*100/10^3;
            t3=0:100/10^3:T-100/10^3;
            n4=size(vector4_w,2); % Here we define the temporal constraint
            T=n4*100/10^3;
            t4=0:100/10^3:T-100/10^3;
            n5=size(vector5_w,2); % Here we define the temporal constraint
            T=n5*100/10^3;
            t5=0:100/10^3:T-100/10^3;
            n6=size(vector6_w,2); % Here we define the temporal constraint
            T=n6*100/10^3;
            t6=0:100/10^3:T-100/10^3;
else
            n1=size(vector1_w,2); % Here we define the temporal constraint
            T=n1*100/10^3;
            t1=0:100/10^3:T-100/10^3;
            n2=size(vector2_w,2); % Here we define the temporal constraint
            T=n2*100/10^3;
            t2=0:100/10^3:T-100/10^3;
            n3=size(vector3_w,2); % Here we define the temporal constraint
            T=n3*100/10^3;
            t3=0:100/10^3:T-100/10^3;
            n4=size(vector4_w,2); % Here we define the temporal constraint
            T=n4*100/10^3;
            t4=0:100/10^3:T-100/10^3;
            n5=size(vector5_w,2); % Here we define the temporal constraint
            T=n5*100/10^3;
            t5=0:100/10^3:T-100/10^3;
            n6=size(vector6_w,2); % Here we define the temporal constraint
            T=n6*100/10^3;
            t6=0:100/10^3:T-100/10^3;
end

printingFunction(t1,vector1_w,vector2_w,vector3_w,vector4_w,vector5_w,vector6_w,'Data warped','Joint values','Time - 100ms each point',1,g1,g2,g3,g4,g5,g6);

Data=cat(2,[t1; vector1_w],[t2; vector2_w],[t3; vector3_w],[t4; vector4_w],[t5; vector5_w],[t6; vector6_w]);


%