function [GMR_Data , GMR_Sigma]=GMM_Result(joint_number,Data,N_Clusters,printflag,Data1,Data2,Data3,Data4,Data5,Data6,g1,g2,g3,g4,g5,g6)
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
number_datasets=6;
x_size=size(Data,2)/number_datasets;
if printflag 
    
    figure('Name','Plot of Original Data, GMM AND GMR results ');
    subplot(4,1,1)
    hold on
    
    aux=max([size(Data1(:,joint_number),1) size(Data2(:,joint_number),1) size(Data3(:,joint_number),1) size(Data4(:,joint_number),1) size(Data5(:,joint_number),1) size(Data6(:,joint_number),1)]);
        % aux before this line is equal to the number of samples from the vector that took more time to 
        % perform the movement. Then for ploting it interest us that all the time
        % axis have the same right limit so we multiply the biggest amount of
        % samples with the period of sampling P=100*10^-3 s;
    aux=aux*100*10^-3; 
   printingFunction(aux,Data1(:,joint_number)',Data2(:,joint_number)',Data3(:,joint_number)',Data4(:,joint_number)',Data5(:,joint_number)',Data6(:,joint_number)',['Original Data from the 6 datasets, data corresponding to the joint number -  ' num2str(joint_number)],'Joint values','Time - 100ms each point',1,g1,g2,g3,g4,g5,g6);
 
    %% Plot of the GMM encoding results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    subplot(4,1,2)
    plot(Data(1,:),Data(2,:),'*')
    xlabel('t','fontsize',16); ylabel('joint values');
    axis ([0 x_size/10 -2.5 2.5]);
    grid on
    title('Concatenated Data.  ','fontsize',10)
    hold on
    
 for n=1:nbVar-1
      subplot(4,1,3)
      hold on
      plotGMM(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [0 .8 0], 1);
      xlabel('t','fontsize',16); ylabel('joint values');
      grid on
      axis ([0 x_size/10 -2.5 2.5]);
      title(['GMM Results, number of clusters used -  ' num2str(N_Clusters)],'fontsize',10);
    
 end 
 


    %% Plot of the GMR regression results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %plot 1D
    for n=1:nbVar-1

      subplot(4,1,4)
      hold on
      plotGMM(expData([1,n+1],:), expSigma(n,n,:), [0 0 .8], 3);
      %axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
      xlabel('t','fontsize',16); ylabel('joint values','fontsize',10);
      grid on
      axis ([0 x_size/10 -2.5 2.5]);
          title(['GMR signature result  '],'fontsize',12);
     
    end
end
GMR_Data=expData;
GMR_Sigma=expSigma;
    

  

