function CellTrackFluorescenceStretchedPlotter()

cd('F:\MicroscopyData\20171129 SFH FUCCI 2x9 exp7 M2 1\AssayPlate_PerkinElmer_CellCarrier-96');
csvfiles = dir('**\*.csv');

fig = figure;
left_color = [1 0 0];
right_color = [0 1 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);


hold on
xlim([0 28])
xlabel('Time (Hours)')
ylabel('Pixel value')
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
            yyaxis right;
            green = table(:,{'Var1' 'Mean'});
            green.Properties.VariableNames{'Mean'} = 'Green';
            plot(timeValues./2,green.Green,'g');
    elseif (contains(file.name, 'Red'))
            yyaxis left;
            red = table(:,{'Var1' 'Mean'});
            red.Properties.VariableNames{'Mean'} = 'Red';
            plot(timeValues./2,red.Red,'r');
    end
end
end