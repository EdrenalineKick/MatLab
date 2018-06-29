function TrackHourlyDisplacementKSPlotter()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*\*Red*.csv');

eStore = zeros(1,length(csvfiles));
i = 1;

length(csvfiles)

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    coordValues = table2array(table(:,{'X' 'Y'}));
    shiftCoords = lagmatrix(coordValues,2);
    
    difference = coordValues - shiftCoords;
    hourlyShift = sqrt(difference(:,1).^2+difference(:,2).^2)*0.268;
    %Microscope Scale Factor
    meanShift = nanmean(hourlyShift);
    eStore(i) = meanShift;
    i = i+1;
end
figure;
hold on
xlim([0 26])
ylim([0 0.5])
xlabel('Mean Hourly Displacement')
ylabel('Probability density estimate')
title('Displacement Kernel Estimate')
[ef,exi] = ksdensity(eStore);


csvfiles = dir('F10*\*Red*.csv');

fStore = zeros(1,length(csvfiles));
i = 1;

length(csvfiles)

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    coordValues = table2array(table(:,{'X' 'Y'}));
    shiftCoords = lagmatrix(coordValues,2);
    
    difference = coordValues - shiftCoords;
    hourlyShift = sqrt(difference(:,1).^2+difference(:,2).^2)*0.268;
    %Microscope Scale Factor
    meanShift = nanmean(hourlyShift);
    fStore(i) = meanShift;
    i = i+1;
end

[ff,fxi] = ksdensity(fStore);

csvfiles = dir('G10*\*Red*.csv');

gStore = zeros(1,length(csvfiles));
i = 1;

length(csvfiles)

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    coordValues = table2array(table(:,{'X' 'Y'}));
    shiftCoords = lagmatrix(coordValues,2);
    
    difference = coordValues - shiftCoords;
    hourlyShift = sqrt(difference(:,1).^2+difference(:,2).^2)*0.268;
    %Microscope Scale Factor
    meanShift = nanmean(hourlyShift);
    gStore(i) = meanShift;
    i = i+1;
end

[gf,gxi] = ksdensity(gStore);
plot(exi,ef,fxi,ff,gxi,gf)
legend('3.2x10^4','1.6x10^4','0.8x10^4')

end