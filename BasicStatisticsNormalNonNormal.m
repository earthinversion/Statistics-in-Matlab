%% Analysing random data to learn statistical skills
clear; close all; clc;

%% Normal Data
figure(1)
dataNormal=randn(100,1);
h1=histogram(dataNormal,15);
xlabel('Values'), ylabel('Frequency')
title('Histogram of Normal Data')
hold on
mu=mean(dataNormal);
sd=std(dataNormal);
binmax = max(h1.Values); %finding the maximum bin height
plot(mu,binmax,'ko','markerfacecolor','r', 'markersize',10); %plotting the location of mean
plot([mu-sd, mu+sd],[binmax, binmax], '-r', 'linewidth', 2); %plotting the 1 std
saveas(gcf,"normal_data_stats",'pdf')


%% Non-Normal Data
% generate some fake data
x = (randn(1,100).^2)*10 + 20;

% compute some simple data summary metrics
mn = mean(x);  % compute mean
sd = std(x);   % compute standard deviation
ptiles = prctile(x,[25 50 75]);  % compute percentiles (median and central 68%)

% make a figure
figure;
hold on;
histogram(x,20);  % plot a histogram using twenty bins
ax = axis;   % get the current axis bounds
  % plot lines showing mean and +/- 1 std dev
h1 = plot([mn mn],      ax(3:4),'r-','LineWidth',2);
h2 = plot([mn-sd mn-sd],ax(3:4),'r--','LineWidth',2);
h3 = plot([mn+sd mn+sd],ax(3:4),'r--','LineWidth',2);
  % plot lines showing percentiles
h4 = [];
for p=1:length(ptiles)
  h4(p) = plot(repmat(ptiles(p),[1 2]),ax(3:4),'g-','LineWidth',2);
end
legend([h1 h2 h4(1)],{'Mean' 'std dev' 'Percentiles'});
xlabel('Value');
ylabel('Frequency');
saveas(gcf,"non_normal_data_stats",'pdf')
