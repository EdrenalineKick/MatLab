function CellCycleLengthPlotter()
cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
g10Files = dir('G10*\*Red*.csv');
g10Store = zeros(1,length(g10Files));

i=1;
for file = g10Files'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    fluorValues = table2array(table(:,{'Var1','Mean'}));
       
    g10Store(i) = length(fluorValues)*0.5;
    i = i+1;
        
end

f10Files = dir('F10*\*Red*.csv');
f10Store = zeros(1,length(f10Files));
j = 1;

for file = f10Files'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    fluorValues = table2array(table(:,{'Var1','Mean'}));
    
    
    if length(fluorValues) < 30
        csvName
    end
    f10Store(j) = length(fluorValues)*0.5;
    j = j+1;
        
end

e10Files = dir('E10*\*Red*.csv');
e10Store = zeros(1,length(e10Files));
k = 1;

for file = e10Files'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    fluorValues = table2array(table(:,{'Var1','Mean'}));
       
    e10Store(k) = length(fluorValues)*0.5;
    k = k+1;
        
end

e10Median = median(e10Store);
f10Median = median(f10Store);
g10Median = median(g10Store);

e10Mean = mean(e10Store);
f10Mean = mean(f10Store);
g10Mean = mean(g10Store);

e10Stdev = std(e10Store);
f10Stdev = std(f10Store);
g10Stdev = std(g10Store);

e10Coeff = e10Stdev/e10Mean;
f10Coeff = f10Stdev/f10Mean;
g10Coeff = g10Stdev/g10Mean;

means = [e10Mean, f10Mean, g10Mean];
medians = [e10Median, f10Median, g10Median];
% coeffs = [e10Coeff, f10Coeff, g10Coeff];
stdevs = [e10Stdev, f10Stdev, g10Stdev];

barNames=categorical({'1x'; '0.5x'; '0.25x' });

figure; hold on
bar(barNames,medians);
errorbar(medians,stdevs);

xlabel('Plating density')
ylabel('Median Cell Cycle Length')
hold off

figure; hold on
bar(barNames,means);
errorbar(means,stdevs);

xlabel('Plating density')
ylabel('Mean Cell Cycle Length')
hold off

histogramEdges = 0:5:50;


figure; hold on
xlim([0 50])
ylim([0 35])
xlabel('Cell Cycle Length')
ylabel('Number of Cells')
title('E10 Cell Cycle Length')
histogram(e10Store,histogramEdges);
hold off

figure; hold on
xlim([0 50])
ylim([0 0.5])
xlabel('Cell Cycle Length')
ylabel('Probability density estimate')
title('E10 Cell Cycle Length')
histogram(e10Store,histogramEdges);
hold off

figure; hold on
xlim([0 50])
ylim([0 35])
xlabel('Cell Cycle Length')
ylabel('Number of Cells')
title('F10 Cell Cycle Length')
histogram(f10Store,histogramEdges);
hold off

figure; hold on
xlim([0 50])
ylim([0 35])
xlabel('Cell Cycle Length')
ylabel('Number of Cells')
title('G10 Cell Cycle Length')
histogram(g10Store,histogramEdges);
hold off

figure; hold on
xlim([0 50])
ylim([0 0.2])
xlabel('Cell Cycle Length')
ylabel('Probability Density Estimate')
title('G10 Cell Cycle Length')
[f,xi] = ksdensity(g10Store); 
plot(xi,f);
hold off

figure; hold on
xlim([0 50])
ylim([0 0.2])
xlabel('Cell Cycle Length')
ylabel('Probability Density Estimate')
title('F10 Cell Cycle Length')
[f,xi] = ksdensity(f10Store); 
plot(xi,f);
hold off

figure; hold on
xlim([0 50])
ylim([0 0.2])
xlabel('Cell Cycle Length')
ylabel('Probability Density Estimate')
title('E10 Cell Cycle Length')
[f,xi] = ksdensity(e10Store); 
plot(xi,f);
hold off


p = ranksum(e10Store,f10Store)
q = ranksum(f10Store,g10Store)
z = ranksum(e10Store,g10Store)

a = kstest2(e10Store,f10Store)
b = kstest2(f10Store,g10Store)
c = kstest2(e10Store,g10Store)

end
