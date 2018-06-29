function CellTrackFluorescenceStretchedRoofedPlotter()

cd('F:\MicroscopyData\20171129 SFH FUCCI 2x9 exp7 M2 1\AssayPlate_PerkinElmer_CellCarrier-96');
csvfiles = dir('**\*.csv');
figure;
hold on
xlim([0 25])
ylim([0 1.2])
xlabel('Time (Hours)')
ylabel('Roofed Fluorescence Value')
length = zeros(numel(csvfiles),1);
i = 1;
for file = csvfiles'
    table = readtable(file.name);
    length(i) = height(table);
    i = i+1;
end
maxLength = max(length);

for file = csvfiles'
    table = readtable(file.name);
    %scale time
    timeValues = table2array(table(:,{'Var1'}));
    maxTimeValue = max(timeValues);
    timeValues = (timeValues.*(maxLength/maxTimeValue));
    
    if (contains(file.name,'Green'))
            green = table(:,{'Var1' 'Mean'});
            green.Properties.VariableNames{'Mean'} = 'Green';
            maxGreen = max(green.Green);
            minGreen = min(green.Green);
            roofedGreen = (green.Green-minGreen)./(maxGreen-minGreen);
            plot(timeValues./2,roofedGreen,'g');
    elseif (contains(file.name, 'Red'))
            red = table(:,{'Var1' 'Mean'});
            red.Properties.VariableNames{'Mean'} = 'Red';
            maxRed = max(red.Red);
            minRed = min(red.Red);
            roofedRed = (red.Red-minRed)./(maxRed-minRed);
            plot(timeValues./2,roofedRed,'r');
    end
end
end