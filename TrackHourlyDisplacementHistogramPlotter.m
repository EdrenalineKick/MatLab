function TrackHourlyDisplacementHistogramPlotter()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*\*Green*.csv');

store = zeros(1,length(csvfiles));
i = 1;
histogramEdges = 0:2:26;

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    coordValues = table2array(table(:,{'X' 'Y'}));
    shiftCoords = lagmatrix(coordValues,2);
    
    difference = coordValues - shiftCoords;
    hourlyShift = sqrt(difference(:,1).^2+difference(:,2).^2)*0.268;
    hourlyShift
    %Microscope Scale Factor
    meanShift = nanmean(hourlyShift);
    store(i) = meanShift;
    i = i+1;
end
meanShift
figure;
hold on
xlim([0 26])
ylim([0 40])
xlabel('Mean Hourly Displacement')
ylabel('Number of Cells')
title('G10 Displacement Histogram')
store
histogram(store,histogramEdges)
end