function circlefinder()
A = imread('Circles.png');
bw = mat2gray(A);
edges = edge(bw(:,:,1),'canny');
imshow(edges)
stats = regionprops(edges,'centroid','eccentricity','EquivDiameter');
s = cat(1, stats.Centroid);
viscircles(s, [stats.EquivDiameter]);