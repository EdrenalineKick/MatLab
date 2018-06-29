% this script is an introduction to principal component analysis (PCA)

% make a 2D set of correlated data
x = randn(1000, 1);
y = 1.5*x + randn(1000, 1);

% what does the data look like?
plot(x, y, 'o')

% what will the covariance matrix of these data look like?  How big will it
% be?
cov(x, y)

% note that it's symmetric.  Why?

% see how the covariance matrix changes if we change our function
y = -3*x + randn(1000, 1);


% plot the new data and calculate the covariance matrix
plot(x, y, 'o')
a = cov(x, y);


% now let's look at the principal components
[PCmat, eigVals] = eig(a);

% plot the PC with the largest eigenvalue on the same axes
hold on
plot([-15, 15]*PCmat(1, 2), [-15, 15]*PCmat(2, 2), 'color', 'r')
hold off


% let's find the distribution of data along the first PC.  Projecting onto
% a PC is as simple as calculating the dot product.
projectedValues = NaN(size(x));
for ii = 1:1000
    projectedValues(ii) = sum(PCmat(:, 2) .* [x(ii), y(ii)]');
end

% or, equivalently
projectedValues2 = [x, y] * PCmat(:, 2);

% look at the distribution
figure; hist(projectedValues, 30)


% how does this compare to the results of the MATLAB function in the stats
% toolbox?
coeff = pca([x, y]);





% load the happy and sad faces
load('sadHappy.mat')


% make a matrix, with each image as a row and convert to double
imageData = [sad1(:)'; sad2(:)'; sad3(:)'; sad4(:)'; ...
    smile1(:)'; smile2(:)'; smile3(:)'; smile4(:)'];
imageData = double(imageData);


% get the principal components of the image data
[PCmat2, eigVals2] = eig(cov(imageData));


% Sort according to eigenvalues to select the PC that explains
% the most variance.
[sortedEigVals, sortIndices] = sort(diag(eigVals2), 'descend');

% plot the eigenFace that accounts for the most variance
eigenFace1 = reshape(PCmat2(:, sortIndices(1)), 40, 40);
figure
imagesc(eigenFace1)
colormap('gray')
axis image



% a little on reshape.  try the following to see how it works:
figure
imagesc(smile1); axis image; colormap('gray');

smileReshaped = reshape(smile1, 80, 20);
figure
imagesc(smileReshaped); axis image; colormap('gray');

smileReshaped = reshape(smile1, 20, 80);
figure
imagesc(smileReshaped); axis image; colormap('gray');


