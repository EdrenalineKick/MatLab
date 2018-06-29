% Collect nuclei
cd('C:\Users\EdRenaline\Documents\MATLAB\SyntheticImage\synthetic_pap_smear\')
addpath('C:\Users\EdRenaline\Documents\MATLAB\SyntheticImage\synthetic_pap_smear\Data');

I = imread('C:\Users\EdRenaline\Documents\MATLAB\SyntheticImage\synthetic_pap_smear\Data\watershed.tif');
% load squamous_subset
no_cells = 100;
no_points = 64;

shapes = zeros(no_cells,no_points);
scalings = zeros(no_cells,1);

ii = 1;

I = bwlabel(I);

while ii <= no_cells
    Im = I==ii;
    [shapes(ii,:),scalings(ii)] = fsd_special(Im,no_points);
    ii = ii + 1;
    
end

save('FUCCI_shapes.mat', 'shapes', 'scalings');