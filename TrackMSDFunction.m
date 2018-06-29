function TrackMSDFunction()
cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\CellTracks');
csvfiles = dir('*\*Red*.csv');


Store = cell(length(csvfiles),1);
i = 1;

for file = csvfiles'
    csvName = fullfile(file.folder,file.name);
    table = readtable(csvName);
    coordValues = table2array(table(:,{'X' 'Y'}));
    
    coordValues = coordValues*0.268;
    
    time = 0:0.5:(length(coordValues)-1)/2;
    matrix = cat(2,time',coordValues);
    
    
%     if length(coordValues) > 61
%         time = 0:0.5:30;
%         coordValues = coordValues(1:61,:);
%     else
%         time = 0:0.5:(length(coordValues)-1)/2;
%     end
    
    matrix = cat(2,time',coordValues);
    
    %Microscope Scale Factor
    Store{i,1} = matrix;
    i = i+1;
end

Store

ma = msdanalyzer(2,'µm', 'h');
ma = ma.addAll(Store);
ma = ma.computeMSD;
ma.plotMeanMSD(gca,'true')
[fo, gof] = ma.fitMeanMSD;
plot(fo)
ma.labelPlotMSD;
legend off

ma = ma.fitMSD;
good_enough_fit = ma.lfit.r2fit > 0.8;
Dmean = mean( ma.lfit.a(good_enough_fit) ) / 2 / ma.n_dim;
Dstd  =  std( ma.lfit.a(good_enough_fit) ) / 2 / ma.n_dim;

fprintf('Estimation of the diffusion coefficient from linear fit of the MSD curves:\n')
fprintf('D = %.3g ± %.3g (mean ± std, N = %d)\n', ...
    Dmean, Dstd, sum(good_enough_fit));

trackV = ma.getVelocities;

% Pool track data together
 TV = vertcat( trackV{:} );

 % Velocities are returned in a N x (nDim+1) array: [ T Vx Vy ...]. So the
 % velocity vector in 2D is:
 V = TV(:, 2:3);

 dT = 0.5;
 % Compute diffusion coefficient
varV = var(V);
mVarV = mean(varV); % Take the mean of the two estimates
Dest = mVarV / 2 * dT
end
