function TrackLinearRegressor()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*\*Green*.csv');

store = zeros(1,length(csvfiles));
i=1;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    fluorValues = table2array(table(:,{'Var1','Mean'}));
    
    [maxFluorescence,maxIndex] = max(fluorValues(:,2));
    
    localMinima = islocalmin(fluorValues);
    localMinimaIndex = find(localMinima(:,2));
    firstMinima = localMinimaIndex(1);
    
    minToMax = fluorValues(firstMinima:maxIndex,:);
    p = polyfit(minToMax(:,1),minToMax(:,2),1);
    

%     minToMax = fluorValues(maxIndex:end,:);
%     p = polyfit(minToMax(:,1),minToMax(:,2),1);

%     localMinima = islocalmin(fluorValues);
%     localMinimaIndex = find(localMinima(:,2));
%     secondMinima = localMinimaIndex(2);
%     
%     minToMax = fluorValues(maxIndex:secondMinima,:)
%     p = polyfit(minToMax(:,1),minToMax(:,2),1);
%     
    store(i) = p(1);
    i = i+1;
        
end
figure;
hold on
% xlim([-100 0])
ylim([0 50])
xlabel('Gradient')
ylabel('Number of Cells')
title('G10 Red Regression Histogram')
histogramEdges = 0:10:100;


histogram(store,histogramEdges)
end


