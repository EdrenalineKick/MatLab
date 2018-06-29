function TrackStackedHistogramPlotter()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('G10*\*Green*.csv');
wells = ['E','F','G'];

store = zeros(1,length(csvfiles));
i = 1;
histogramEdges = 0:2:26;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    coordValues = table2array(table(:,{'X' 'Y'}));
    shiftCoords = diff(coordValues,2);
    
    store(i,j) = shiftCoords;

end
figure;
hold on
xlim([0 26])
ylim([0 40])
xlabel('Mean Hourly Displacement')
ylabel('Number of Cells')
title('G10 Displacement Histogram')

histogram(store,histogramEdges)
end