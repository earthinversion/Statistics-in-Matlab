clear; close all; clc;
load temp_month 

%% Making a matrix of data
p=[Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec];
pstring={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

[row, col]=size(p);
%% Plotting the data vs year
figure
for i=1:col
plot(Year,p(:,i))
grid on
hold on
end
title('Variation of temperature with year')
xlabel('Year'), ylabel('Months')
axis tight
saveas(gcf,"dataYear",'pdf')

%% Statistical Analysis
for i=1:col
    dd=p(:,i);
    mu(i)=mean(dd); %mean
    sd(i)=std(dd); %standard deviation
    med(i)=median(dd); %median
    x = min(dd):0.01:max(dd);
    ddsorted = sort(dd,'ascend'); %interquartile range
    e25=ceil(25/100*length(dd)); e75=ceil(75/100*length(dd));
    iqr_dd = ddsorted([e25, e75]);
    skew_dd=skewness(dd);
    kurt_dd = kurtosis(dd);
    
    
    %Plotting Figure
    figure
  %  subplot(2,2,[1 2])
     xlabel('Groups'), ylabel('Frequency'),grid on
    annotation('textbox',...
    [0.15 0.65 0.3 0.15],...
    'String',{'Skewness & Kurtosis respectively are ',[num2str(skew_dd),' & ', num2str(kurt_dd)]},...
    'FontSize',14,...
    'FontName','Arial')
    hold on
    h1=histogram(dd,'BinMethod','auto');
    binmax1(i) = max(h1.Values); %finding the maximum bin height
    plot(mu(i),binmax1(i),'ko','markerfacecolor','r', 'markersize',10); %plotting the location of mean
    plot([mu(i)-sd(i), mu(i)+sd(i)],[binmax1(i), binmax1(i)], '-r', 'linewidth', 2); %plotting the 1 std
    plot(med(i),binmax1(i)-1,'ko','markerfacecolor','c', 'markersize',7)
    plot(iqr_dd,[binmax1(i)-1, binmax1(i)-1], '-m', 'linewidth',2);
    legend('histogram','mean','std','median','interquartile range')
    saveas(gcf,sprintf("hist_Month%s",pstring{i}),'pdf')
end