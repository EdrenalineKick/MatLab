function SeedingParametreDBSCANPlotter()

cd('C:\Users\Ed\Documents\BristolWork\ChasteSeedingDensityScan'),
csvfiles = dir('*.csv');

store = zeros(length(csvfiles),120);
i = 1;
for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    meanValue = table2array(table);
    
    store(i,:) = meanValue;
    i = i+1;
end
means = mean(store);
plot(means);