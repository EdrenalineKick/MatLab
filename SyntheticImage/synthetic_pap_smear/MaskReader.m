cd('C:\Users\EdRenaline\Documents\MATLAB\SyntheticImage\synthetic_pap_smear');
I = imread('Data\watershed.tif');
cc = bwconncomp(I);
numNucleii = cc.NumObjects;
fourier = fsd_special(I,numNucleii);

scaling= 10000;
size_offset = 0.5;

image_size = round(sqrt(max(1.5*scaling*size_offset)/pi)*[2 2]);
scale = mean(scaling);

%% Generate the shape

% Calculate the means and std of the shapes in the repository
real_mean = mean(real(fourier));
imag_mean = mean(imag(fourier));
real_std = 1.0*std(real(fourier));
imag_std = 1.0*std(imag(fourier));

% Generate a new shape
nuc_shape = (real_mean + real_std.*randn(size(real_std)))+1j*(imag_mean + imag_std.*randn(size(imag_std)));
nuc_shape(5:end-4) = 0;

% Return to spacial domain
nuc_shape = ifft(nuc_shape);
nuc_shape = [real(nuc_shape)' imag(nuc_shape)'];


% Scale the coordinates
nuc_shape = nuc_shape.*scale*size_offset;
c = coord2image(round(nuc_shape+(image_size(1)-1)/2),image_size);
nuc_shape = fillholes(bskeleton(bdilation(c,2)));

nuc_shape