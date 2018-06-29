function StretchedTrackLinearRegressor()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('G10*\*Green*.csv');

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
    %scale time
    timeValues = table2array(table(:,{'Var1'}));
    maxTimeValue = max(timeValues);
    timeValues = (timeValues.*(maxLength/maxTimeValue));
    
    fluorValues = table2array(table(:,{'Mean'}));
    
    [maxFluorescence,maxIndex] = max(fluorValues(:));
    
    localMinima = islocalmin(fluorValues);
    localMinimaIndex = find(localMinima(:));
    firstMinima = localMinimaIndex(1);
    
    time = timeValues(firstMinima:maxIndex,:);
    minToMax = fluorValues(firstMinima:maxIndex,:);
    p = polyfit(time,minToMax,1);
    
    store(i) = p(1);
    i = i+1;
        
end
figure;
hold on
% xlim([0])
ylim([0 50])
xlabel('Gradient')
ylabel('Number of Cells')
title('G10 Green Stretched Regression Histogram')
histogramEdges = 0:5:50;
histogram(store,histogramEdges)
hold off

figure;
hold on
ylim([0 0.5])
xlim([0 50])
xlabel('Gradient')
ylabel('Probability density estimate')
title('G10 Stretched Green Rise Kernel Estimate')
[f,xi] = ksdensity(store);
plot(xi,f)

end


