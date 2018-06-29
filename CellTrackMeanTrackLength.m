 function CellTrackMeanTrackLength()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*/*.csv');
store = zeros(1,length(csvfiles));
i = 1;
for file = csvfiles'
    table = readtable(file.name);
    store(i) = height(table);
    i = i + 1;
end
mean(store)*0.5
std(store)*0.5
end