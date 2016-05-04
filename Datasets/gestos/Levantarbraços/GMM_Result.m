function [GMR_Data , GMR_Sigma]=GMM_Result(PC_number,Data,N_Clusters,printflag)
%% 
% Inputs:

% Data  -  Data [MxN] where we want to apply GMM, line 1xN should be the
% temporal constraint 
% N_Cluster - number of clusters used by gmm
% printflag - Flag to decide if we want to print the results or just return
% them.

% Output: 
% GMR_Data - Matriz with the resulting concatenation of all the regressions
%%Data concatenated 
Data=cat(2,[Data(1,:) ; Data(2,:)],[Data(1,:) ; Data(3,:)],[Data(1,:) ; Data(4,:)],[Data(1,:) ; Data(5,:)],[Data(1,:) ; Data(6,:)],[Data(1,:) ; Data(7,:)]);
subplot(5,1,3)
      hold on
plot(Data(1,:),Data(2,:),'*');
nbStates=N_Clusters; % number of clusters used by gmm
nbVar = size(Data,1);
x_max=(size(Data,2)/6)*100*10^-3;
xlabel('Time - (100ms each point)','fontsize',12); ylabel('joint values','fontsize',13);
      grid on
      axis ([0 x_max -3 3]);
          title('Data concatenated after PCA and DTW');
      

%% Training of GMM by EM algorithm, initialized by k-means clustering.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Priors, Mu, Sigma] = EM_init_kmeans(Data, nbStates);
[Priors, Mu, Sigma] = EM(Data, Priors, Mu, Sigma);


%% Use of GMR to retrieve a generalized version of the data and associated
%% constraints. A sequence of temporal values is used as input, and the 
%% expected distribution is retrieved. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
expData(1,:) = linspace(min(Data(1,:)), max(Data(1,:)), 100);
[expData(2:nbVar,:), expSigma] = GMR(Priors, Mu, Sigma,  expData(1,:), [1], [2:nbVar]);
x_size=size(Data,2)/6;
if printflag 
    %% Plot of the GMM encoding results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    for n=1:nbVar-1
      subplot(5,1,4)
      hold on
      plotGMM(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [0 .8 0], 1);
      %axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('Time - (100ms each point)','fontsize',12); ylabel('joint values','fontsize',12);
      grid on
      axis ([0 x_size/10 -3 3]);
      if(n==1)
          title(['Gaussian Mixture Model Results, number of clusters used -  ' num2str(N_Clusters)],'fontsize',10);
      end
          
    end


    %% Plot of the GMR regression results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    for n=1:nbVar-1

      subplot(5,1,5)
      hold on
      plotGMM(expData([1,n+1],:), expSigma(n,n,:), [0 0 .8], 3);
      %axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('Time - (100ms each point)','fontsize',12); ylabel('joint values','fontsize',12);
      grid on
      axis ([0 x_size/10 -3 3]);
      if(n==1)
             title(['Gaussian Mixture Regression for Principal Component number ' num2str(PC_number)],'fontsize',10);

      end
    end
end

%% Here we concatenate the GMR regressions into one.
GMR_Data=0;

    
   
for n=2:nbVar
    GMR_Data=expData(n,:)+GMR_Data;
    if(n==nbVar)
        GMR_Data=GMR_Data/(nbVar-1);
        
    end
end
GMR_Data=[expData(1,:); GMR_Data];

GMR_Sigma=0;
for n=1:nbVar-1
    GMR_Sigma=expSigma(n,n,:)+GMR_Sigma;
    if(n==nbVar)
        GMR_Sigma=GMR_Sigma/(nbVar-1);
    end
end

