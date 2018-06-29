% Collect nuclei

addpath ../General_functions/

I = imread('C:\Users\EdRenaline\Documents\MATLAB\SyntheticImage\synthetic_pap_smear\Data\
% load squamous_subset

no_cells = 100;
no_points = 64;

shapes = zeros(no_cells,no_points);
scalings = zeros(no_cells,1);

rp = randperm(length(squamous_subset));
ii = 1;
jj = 1;
progressbar('Done')
while ii <= no_cells
    
    [shapes(ii,:),scalings(ii)] = fsd_special(squamous_subset{rp(jj)}.seg_mask,no_points);
    
    ii = ii + 1;
    jj = jj + 1;
    progressbar((ii-1)/no_cells)
    
end

save ../Data/shapes shapes scalings