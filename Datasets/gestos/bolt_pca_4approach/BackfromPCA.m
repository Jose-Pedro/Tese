function Data = BackfromPCA(Data_pc1_w,Data_pc2_w,Data_pc3_w,Data_pc4_w,mu1,mu2,mu3,mu4,mu5,mu6,w1,w2,w3,w4,w5,w6,number_pc)

    numberofdatasets =6;
    Data=zeros(6,70,12);
for i=0:numberofdatasets-1
    
    s1=size(Data_pc1_w,2);
    s2=size(Data_pc2_w,2);
    s3=size(Data_pc3_w,2);
    s4=size(Data_pc4_w,2);
    min=s1;
    if s2<min
        min=s2;
    end
    if s3<min
        min=s3;
    end
    if s4<min
        min=s4;
    end


    dataset_number=i+1;
    Data_pc1_final=Resizer(Data_pc1_w(dataset_number+1,:),min,s1);
    Data_pc2_final=Resizer(Data_pc2_w(dataset_number+1,:),min,s2);
    Data_pc3_final=Resizer(Data_pc3_w(dataset_number+1,:),min,s3);
    Data_pc4_final=Resizer(Data_pc4_w(dataset_number+1,:),min,s4);
    
    Data_pc_final=[Data_pc1_final;Data_pc2_final;Data_pc3_final;Data_pc4_final]';
    % 
    % 
    % Dataapprox1 = Data(:,1:number_pc)* Signature_w(:,1:number_pc)';
    % Dataapprox1 = bsxfun(@plus,Signature_mean,Dataapprox); % add the mean back in
        if i==0
             Dataapprox=Data_pc_final(:,1:number_pc)*w1(:,1:number_pc)';
             Dataapprox= bsxfun(@plus,mu1,Dataapprox);
        end
        if i==1
             Dataapprox=Data_pc_final(:,1:number_pc)*w2(:,1:number_pc)';
             Dataapprox= bsxfun(@plus,mu2,Dataapprox);
        end
        if i==2
             Dataapprox=Data_pc_final(:,1:number_pc)*w3(:,1:number_pc)';
             Dataapprox= bsxfun(@plus,mu3,Dataapprox);
        end
        if i==3
             Dataapprox=Data_pc_final(:,1:number_pc)*w4(:,1:number_pc)';
             Dataapprox= bsxfun(@plus,mu4,Dataapprox);
        end
        if i==4
             Dataapprox=Data_pc_final(:,1:number_pc)*w5(:,1:number_pc)';
             Dataapprox= bsxfun(@plus,mu5,Dataapprox);
        end
        if i==5
             Dataapprox=Data_pc_final(:,1:number_pc)*w6(:,1:number_pc)';
             Dataapprox= bsxfun(@plus,mu6,Dataapprox);
        end
         Data(i+1,:,:)=Dataapprox;

end