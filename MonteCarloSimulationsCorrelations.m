%%Monte Carlo simulations of correlation values
clear; close all; clc;
% define
numsim = 10000;   % number of simulations to run
samplesize = 50;  % number of data points in each sample

% pre-allocate the results vector
results = zeros(1,numsim);

% loop over simulations
for num=1:numsim
  
  % draw two sets of random numbers, each from the normal distribution
  data = (randn(samplesize,2).^2)*10+20;
  
  % compute the correlation between the two sets of numbers and store the result
  results(num) = corr(data(:,1),data(:,2));
  
end
% visualize the results
figure; hold on;
hist(results,100);
% ax = axis;
% mx = max(abs(ax(1:2)));  % make the x-axis symmetric around 0
% axis([-mx mx ax(3:4)]);
xlabel('Correlation value');
ylabel('Frequency');
%%
val = prctile(abs(results),95);
val
%%

% visualize this on the figure
ax = axis;
h1 = plot([val val],ax(3:4),'r-');
h2 = plot(-[val val],ax(3:4),'r-');
legend(h1,'Central 95%');
title(sprintf('The values between which most of the correlation values lie is +/- %.4f',val));
saveas(gcf,"monteCarloSim",'pdf')
%%