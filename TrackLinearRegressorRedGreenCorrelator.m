function TrackLinearRegressorRedGreenCorrelator()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
greenFiles = dir('*\*Green*.csv');

store = zeros(length(greenFiles),2);
store
i=1;
for file = greenFiles'
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
    store(i,1) = p(1);
    i = i+1;
        
end


redFiles = dir('*\*Red*.csv');
j = 1;
for file = redFiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    fluorValues = table2array(table(:,{'Var1','Mean'}));
    
    [maxFluorescence,maxIndex] = max(fluorValues(:,2));
    
    localMinima = islocalmin(fluorValues);
    localMinimaIndex = find(localMinima(:,2));
    secondMinima = localMinimaIndex(2);
    
    drop = fluorValues(maxIndex:secondMinima,:);
    drop;
    p = polyfit(drop(:,1),drop(:,2),1);
    
    store(j,2) = p(1);
    j = j+1;
        
end

store(~any(~isnan(store), 2),:)=[];

figure;
plot(store);
figure;
hold on 
xlabel('Gradient of Green Increase')
ylabel('Gradient of Red Decrease')
title('Pooled Gradient Correlation')

p = polyfit(store(:,1),store(:,2),1);
xFit = linspace(0, 50, 50);
yFit = polyval(p,xFit);
plot(xFit,yFit)

scatter(store(:,1),store(:,2));

[R P] = corrcoef(store);
R
P

legendString = "y = " + p(1) + "x + " + p(2);
correlationString = "R = " + R(1,2) + " P = " + P(1,2);
legend(legendString,correlationString);
