function CellTrackFluorescencePlotter()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('*/*.csv');

for file = csvfiles'
    table = readtable(file.name);
    
    if (contains(file.name,'Green'))
        green = table(:,{'Var1' 'Mean'});
        green.Properties.VariableNames{'Mean'} = 'Green';
    elseif (contains(file.name, 'Red'))
        red = table(:,{'Var1' 'Mean'});
        red.Properties.VariableNames{'Mean'} = 'Red';
        file.name
        fluorescence = join(green,red);
        f = figure;
        plot((fluorescence.Var1)/2,fluorescence.Green,'g',(fluorescence.Var1)/2,fluorescence.Red,'r');
        xlim([0 25])
        ylim([0 1000])
        xlabel('Time (Hours)')
        ylabel('Pixel value')
        saveas(f,file.name(1:end-7),'png');
    end
    
    end
close all;
end