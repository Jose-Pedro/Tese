function Data=vectorwarping(vector1,vector2,vector3,vector4,vector5,vector6,resized,g1,g2,g3,g4,g5,g6)


% On a first aproach i resized data to the smallest Data vector and performed DTW on the 
% resulting mean for all the vectors. First i select the smallest size from all the vectors size 
% then i resized the rest of the vectors to that size.
aux=min([size(vector1,1) size(vector2,1) size(vector3,1) size(vector4,1) size(vector5,1) size(vector6,1)]);



            n1=size(vector1,1); % Here we define the temporal constraint
            T=n1*100/10^3;
            t1=0:100/10^3:T-100/10^3;
            n2=size(vector2,1); % Here we define the temporal constraint
            T=n2*100/10^3;
            t2=0:100/10^3:T-100/10^3;
            n3=size(vector3,1); % Here we define the temporal constraint
            T=n3*100/10^3;
            t3=0:100/10^3:T-100/10^3;
            n4=size(vector4,1); % Here we define the temporal constraint
            T=n4*100/10^3;
            t4=0:100/10^3:T-100/10^3;
            n5=size(vector5,1); % Here we define the temporal constraint
            T=n5*100/10^3;
            t5=0:100/10^3:T-100/10^3;
            n6=size(vector6,1); % Here we define the temporal constraint
            T=n6*100/10^3;
            t6=0:100/10^3:T-100/10^3;
% Here we use the function Resizer so we resize all the vectors to the
% smallest one

vector1=resizeVector([t1;vector1'],aux);
vector2=resizeVector([t2;vector2'],aux);
vector3=resizeVector([t3;vector3'],aux);
vector4=resizeVector([t4;vector4'],aux);
vector5=resizeVector([t5;vector5'],aux);
vector6=resizeVector([t6;vector6'],aux);

% Here we calculate the mean vector.
vector_mean=(vector1(2,:)+ vector2(2,:) + vector3(2,:) + vector4(2,:) + vector5(2,:) + vector6(2,:))/6;

% We use the function created by  Pau Micó to perform dtw and retrieve the warped vectors
% Link: http://www.mathworks.com/matlabcentral/fileexchange/16350-continuous-dynamic-time-warping

[dtw_Dist1,D1,dtw_k1,w1,vector1_w,vector_mean_w_1]=dtw(vector1(2,:),vector_mean,0);
[dtw_Dist2,D2,dtw_k2,w2,vector2_w,vector_mean_w_2]=dtw(vector2(2,:),vector_mean,0);
[dtw_Dist3,D3,dtw_k3,w3,vector3_w,vector_mean_w_3]=dtw(vector3(2,:),vector_mean,0);
[dtw_Dist4,D4,dtw_k4,w4,vector4_w,vector_mean_w_4]=dtw(vector4(2,:),vector_mean,0);
[dtw_Dist5,D5,dtw_k5,w5,vector5_w,vector_mean_w_5]=dtw(vector5(2,:),vector_mean,0);
[dtw_Dist6,D6,dtw_k6,w6,vector6_w,vector_mean_w_6]=dtw(vector6(2,:),vector_mean,0);

% In a first approach after vectors warping i decided to resize them again to the size of smallest
% sized vector .            
            

            
            
            n1=size(vector1_w,2) % Here we define the temporal constraint
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
            aux=min([size(vector1_w,2) size(vector2_w,2) size(vector3_w,2) size(vector4_w,2) size(vector5_w,2) size(vector6_w,2)]);

            vector1_w=resizeVector([t1;vector1_w],aux);
            vector2_w=resizeVector([t2;vector2_w],aux);
            vector3_w=resizeVector([t3;vector3_w],aux);
            vector4_w=resizeVector([t4;vector4_w],aux);
            vector5_w=resizeVector([t5;vector5_w],aux);
            vector6_w=resizeVector([t6;vector6_w],aux);
            
            n1=size(vector1_w(2,:),2); % Here we define the temporal constraint
            T=n1*100/10^3;
            t1=0:100/10^3:T-100/10^3;
            n2=size(vector2_w(2,:),2); % Here we define the temporal constraint
            T=n2*100/10^3;
            t2=0:100/10^3:T-100/10^3;
            n3=size(vector3_w(2,:),2); % Here we define the temporal constraint
            T=n3*100/10^3;
            t3=0:100/10^3:T-100/10^3;
            n4=size(vector4_w(2,:),2); % Here we define the temporal constraint
            T=n4*100/10^3;
            t4=0:100/10^3:T-100/10^3;
            n5=size(vector5_w(2,:),2); % Here we define the temporal constraint
            T=n5*100/10^3;
            t5=0:100/10^3:T-100/10^3;
            n6=size(vector6_w(2,:),2); % Here we define the temporal constraint
            T=n6*100/10^3;
            t6=0:100/10^3:T-100/10^3;



Data=cat(2,[t1; vector1_w(2,:)],[t2; vector2_w(2,:)],[t3; vector3_w(2,:)],[t4; vector4_w(2,:)],[t5; vector5_w(2,:)],[t6; vector6_w(2,:)]);


%