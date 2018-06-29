function TrackAngularDisplacementPlotter()

cd('F:\MicroscopyData\20180123 FUCCI new polyclonal single cells mTeSR vs E8 plus stem beads\');
csvfiles = dir('**\*Green*.csv');
% figure;
% hold on
% xlim([0 25])
% ylim([0 7])
% xlabel('Time (Hours)')
% ylabel('Roofed Fluorescence Value')
i = 1;

shiftCell = NaN(41,length(csvfiles)+1);
shiftCell(:,length(csvfiles)+1) = (rand(41,1).*(360))-180;
for file = csvfiles'
    table = readtable(file.name);
    %scale time
    coordValues = table2array(table(:,{'X' 'Y'}));
    shiftCoords = diff(coordValues);
    
    angle = atan2(shiftCoords(:,2),shiftCoords(:,1));
    angle = angle.*(180/3.14159);
    angle(angle < 0) = angle(angle <0) + 360;
    shiftAngle = diff(angle);
    shiftAngle(shiftAngle > 180) = shiftAngle(shiftAngle > 180) - 360;
    shiftAngle(shiftAngle < -180) = shiftAngle(shiftAngle < -180) + 360;
    
    for j = 1:length(shiftAngle)
        shiftCell(j,i) = shiftAngle(j);
    end
    i = i+1;
end
boxplot(shiftCell,'Labels',{csvfiles.name,'Random'})
xtickangle(45);
end