function fuccilevertest()
visibleChannel = imread('Im1.tif');
greenChannel = imread('Im2.tif');
redChannel = imread('Im3.tif');



MIN_CELL_RADIUS_um=10; % um
LOG_RADIUS = 0.25;



% Read image
im = visibleChannel;
imOG = greenChannel;
imOR = redChannel;

% smooth and bg remove fucci's
imG=medfilt2(imOG);

imG=max(imG,0);
imR=medfilt2(imOR);
imR=max(imR,0);
% normalize phase only (keep fucci relative)
im = mat2gray(im);

% Define parameters
resolution_um=0.3; % um per pixel
min_radius_pixels = MIN_CELL_RADIUS_um / resolution_um;

windSize = 11;
imEnt = entropyfilt(im, ones(windSize));
figure,imshow(imEnt,[])
bwCell = im2bw(mat2gray(imEnt), graythresh(mat2gray(imEnt)));


% Fluorescence (FUCCI) Segmentation
imR = imR*100;
bwFluorG = imbinarize(imG,graythresh(imG));
bwFluorR = imbinarize(imR,graythresh(imR));
bwFluorGR = bwFluorG | bwFluorR;
figure;imshow(bwFluorR,[]);
figure;imshow(bwFluorGR,[]);


[LFluor]=bwlabel(bwFluorGR,8);

% Add cells according to FUCCI
bwOnlyFluor = logical(LFluor);
bwCell = bwCell | bwOnlyFluor;

figure,imshow(bwCell,[])
se=strel('disk',ceil(min_radius_pixels/2));
bwCell=imopen(bwCell,se);
figure,imshow(bwCell,[])




