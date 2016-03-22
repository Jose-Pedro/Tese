function [GMR_Data , GMR_Sigma]=GMM_Result(Data,N_Clusters,printflag)
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

if printflag 
    %% Plot of the GMM encoding results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    figure('Name','Plot of the GMM encoding results');
    for n=1:nbVar-1
      subplot(nbVar-1,1,n)
      hold on
      plotGMM(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [0 .8 0], 1);
      %axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
    end


    %% Plot of the GMR regression results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    figure('Name','Plot of the GMR regression results for the six datasets');
    for n=1:nbVar-1

      subplot(nbVar-1,1,n)
      hold on
      plotGMM(expData([1,n+1],:), expSigma(n,n,:), [0 0 .8], 3);
      %axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('t','fontsize',16); ylabel(['x_' num2str(n)],'fontsize',16);
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
if printflag
    figure('Name','Plot of the GMR regression concatenated');
    plotGMM(GMR_Data([1,2],:), GMR_Sigma(1,1,:), [0 0 .8], 3);
end
