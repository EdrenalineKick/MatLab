 function CellTrackFluorescenceOverlayPlotter()
cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('E10*/*.csv');
length(csvfiles)
% left_color = [1 0 0];
% right_color = [0 1 0];
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);

hold on
xlim([0 50])
ylim([0 1400])
xlabel('Time (Hours)')
ylabel('Pixel value')

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    
    if (contains(file.name,'Green'))
%             yyaxis right
            green = table(:,{'Var1' 'Mean'});
            green.Properties.VariableNames{'Mean'} = 'Green';
            plot((green.Var1)/2,green.Green,'g','Marker','none');
        elseif (contains(file.name, 'Red'))
%             yyaxis left
            red = table(:,{'Var1' 'Mean'});
            means = table2array(red(:,{'Mean'}));
            maximum = max(means);
            if maximum > 1000
                csvName
            end
            red.Properties.VariableNames{'Mean'} = 'Red';
            plot((red.Var1)/2,red.Red,'r','Marker','none');
            title("Cell Cycle Tracks");
    end
end
hold off;
end