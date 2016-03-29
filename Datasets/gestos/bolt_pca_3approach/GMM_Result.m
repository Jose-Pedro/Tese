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
%%
nbStates=N_Clusters; % number of clusters used by gmm
nbVar = size(Data,1);


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
x_size=size(Data,2);
if printflag 
    %% Plot of the GMM encoding results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    figure('Name','Plot of the GMM encoding results (left) and GMR regression (right) and concatenated signature (bottom)');
    for n=1:nbVar-1
      subplot(nbVar,2,(2*n-1))
      hold on
      plotGMM(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [0 .8 0], 1);
      %axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',12);
      grid on
      axis ([0 x_size/10 -2.5 2.5]);
      if(n==1)
          title(['GMM Results, number of clusters used -  ' num2str(N_Clusters)],'fontsize',12);
      end
          
    end


    %% Plot of the GMR regression results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    for n=1:nbVar-1

      subplot(nbVar,2,2*n)
      hold on
      plotGMM(expData([1,n+1],:), expSigma(n,n,:), [0 0 .8], 3);
      %axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',12);
      grid on
      axis ([0 x_size/10 -2.5 2.5]);
      if(n==1)
          title(['GMR signature results  '],'fontsize',12);
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

    subplot(nbVar,2,(2*n+1):(2*n+2))
    %figure('Name','Plot of the GMR regression concatenated');
    plotGMM(GMR_Data([1,2],:), GMR_Sigma(1,1,:), [0 0 .8], 3);
    title(['Concatenated signature  from Principal Component number ' num2str(PC_number)],'fontsize',14);
    grid on
    axis ([0 x_size/10 -2.5 2.5]);

