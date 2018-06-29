function TrackMeanSquareDisplacement()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*\*Red*.csv');

timeLengths = zeros(numel(csvfiles),1);
j = 1;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    timeLengths(j) = height(table);
    j = j+1;
end

maxLength = max(timeLengths);

eStore = zeros(maxLength,length(csvfiles));
i = 1;

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    coordValues = table2array(table(:,{'X' 'Y'}));
    initialCoords = coordValues(1,:);
    
    difference = coordValues - initialCoords;
    hourlyShift = sqrt(difference(:,1).^2+difference(:,2).^2)*0.268;
    %Microscope Scale Factor
    eStore(1:length(hourlyShift),i) = hourlyShift;
    i = i+1;
end

erowMean = sum(eStore,2) ./ sum(eStore~=0,2);

csvfiles = dir('F10*\*Red*.csv');

timeLengths = zeros(numel(csvfiles),1);
j = 1;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    timeLengths(j) = height(table);
    j = j+1;
end

maxLength = max(timeLengths);

fStore = zeros(maxLength,length(csvfiles));
i = 1;

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    coordValues = table2array(table(:,{'X' 'Y'}));
    initialCoords = coordValues(1,:);
    
    difference = coordValues - initialCoords;
    hourlyShift = sqrt(difference(:,1).^2+difference(:,2).^2)*0.268;
    %Microscope Scale Factor
    fStore(1:length(hourlyShift),i) = hourlyShift;
    i = i+1;
end

frowMean = sum(fStore,2) ./ sum(fStore~=0,2);

csvfiles = dir('G10*\*Red*.csv');

timeLengths = zeros(numel(csvfiles),1);
j = 1;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    timeLengths(j) = height(table);
    j = j+1;
end

maxLength = max(timeLengths);

gStore = zeros(maxLength,length(csvfiles));
i = 1;

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    coordValues = table2array(table(:,{'X' 'Y'}));
    initialCoords = coordValues(1,:);
    
    difference = coordValues - initialCoords;
    hourlyShift = sqrt(difference(:,1).^2+difference(:,2).^2)*0.268;
    %Microscope Scale Factor
    gStore(1:length(hourlyShift),i) = hourlyShift;
    i = i+1;
end

growMean = sum(gStore,2) ./ sum(gStore~=0,2);
plot(1:length(erowMean),erowMean,1:length(frowMean),frowMean,1:length(growMean),growMean)
xlim([0 60])

end