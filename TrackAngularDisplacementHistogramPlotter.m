function TrackAngularDisplacementHistogramPlotter()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*\*Green*.csv');
% figure;
% hold on
% xlim([0 25])
% ylim([0 7])
% xlabel('Time (Hours)')
% ylabel('Roofed Fluorescence Value')

cellAngles = [];

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    %scale time
    coordValues = table2array(table(:,{'X' 'Y'}));
    shiftCoords = diff(coordValues);
    
    angle = atan2(shiftCoords(:,2),shiftCoords(:,1));
    angle = angle.*(180/3.14159);
    angle(angle < 0) = angle(angle <0) + 360;
    shiftAngle = diff(angle);
    shiftAngle(shiftAngle > 180) = shiftAngle(shiftAngle > 180) - 360;
    shiftAngle(shiftAngle < -180) = shiftAngle(shiftAngle < -180) + 360;
    
    cellAngles = cat(1,cellAngles,shiftAngle);
%     cellAngles(cellAngles < 0) = cellAngles(cellAngles < 0)*-1;
end
cellAngles
stdeviation = std(cellAngles);
length(cellAngles)
figure;
histogram(cellAngles)
xlabel('Angular Deflection')
ylabel('Number of Occurences')
title('E10 Angular Deflection')

legendString = "Standard Deviation = " + stdeviation;
legend(legendString);

hold off
figure;
hold on
xlabel('Angular Deflection')
ylabel('Probability density estimate')
title('E10 Angular Deflection Kernel Estimate')
[f,xi] = ksdensity(cellAngles);
plot(xi,f)
end