function RedTrackLinearRegressor()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*\*Red*.csv');

store = zeros(1,length(csvfiles));
i=1;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    fluorValues = table2array(table(:,{'Var1','Mean'}));
    
    [maxFluorescence,maxIndex] = max(fluorValues(:,2));
           
    minToMax = fluorValues(1:maxIndex,:);
    p = polyfit(minToMax(:,1),minToMax(:,2),1);
    
    store(i) = p(1);
    i = i+1;
    
end
figure;
hold on
xlim([0 60])
ylim([0 25])
xlabel('Gradient')
ylabel('Number of Cells')
title('E10 Red Regression Histogram')
histogramEdges = 0:5:80;


histogram(store,histogramEdges)
end