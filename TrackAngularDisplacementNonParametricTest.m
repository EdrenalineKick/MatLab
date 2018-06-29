function TrackAngularDisplacementNonParametricTest()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
g10files = dir('G10*\*Green*.csv');

g10Angles = [];

for file = g10files'
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
    
    g10Angles = cat(1,g10Angles,shiftAngle);
%     g10Angles(g10Angles < 0) = g10Angles(g10Angles < 0)*-1;
end

f10files = dir('F10*\*Green*.csv');

f10Angles = [];

for file = f10files'
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
    
    f10Angles = cat(1,f10Angles,shiftAngle);
%     f10Angles(f10Angles < 0) = f10Angles(f10Angles < 0)*-1;
end

e10files = dir('E10*\*Green*.csv');

e10Angles = [];

for file = e10files'
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
    
    e10Angles = cat(1,e10Angles,shiftAngle);
%     e10Angles(e10Angles < 0) = e10Angles(e10Angles < 0)*-1;
end

efTest = ranksum(e10Angles,f10Angles)
egTest = ranksum(e10Angles,g10Angles)
fgTest = ranksum(f10Angles,g10Angles)
[h,p,ci,stats] = ttest(e10Angles)
[h,p,ci,stats] = ttest(f10Angles)
[h,p,ci,stats] = ttest(g10Angles)

kstest(e10Angles)
kstest(f10Angles)
kstest(g10Angles)

mean(e10Angles)
mean(f10Angles)
mean(g10Angles)
end