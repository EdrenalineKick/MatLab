function StretchedRedTrackLinearRegressor()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*\*Red*.csv');

lengths = zeros(1,length(csvfiles));
i=1;
for file = csvfiles'
    table = readtable(file.name);
    lengths(i) = height(table);
    i = i+1;
end
maxLength = max(lengths);

store = zeros(1,length(csvfiles));
i=1;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    
    timeValues = table2array(table(:,{'Var1'}));
    maxTimeValue = max(timeValues);
    timeValues = (timeValues.*(maxLength/maxTimeValue));
    %scale time
    fluorValues = table2array(table(:,{'Mean'}));
    
    [maxFluorescence,maxIndex] = max(fluorValues(:));
           
    minToMax = fluorValues(1:maxIndex,:);
    
    time = timeValues(1:maxIndex,:);
    p = polyfit(time,minToMax,1);
    
    
    
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

