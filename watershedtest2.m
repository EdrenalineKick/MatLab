function watershedtest2()

% import and convert image to grayscale%
rgb = imread('Testimage.tif');
I = rgb;


%calculate local image gradient%
filtery = fspecial('sobel');
filterx = filtery';
Iy = imfilter(double(I),filtery,'replicate');
Ix = imfilter (double(I),filterx,'replicate');
gradient = sqrt(Iy.^2 + Ix.^2);
% smoothing out image to remove blemishes and noise%
se = strel('disk',4);
Ie = imerode(I,se);
Ier = imreconstruct(Ie,I);
Ierd = imdilate(Ier,se);
Ierdc = imreconstruct(imcomplement(Ierd),imcomplement(Ier));
Ierdc = imcomplement(Ierdc);

figure, imshow(Ierdc);

% calculating regional maxima and removing stray pixels + shrinking%
rm = imregionalmax(Ierdc);
se2 = strel(ones(5,5));
rm2 = imclose(rm,se2);
rm3 = imerode (rm2 , se2);
rm4 = bwareaopen(rm3 , 20);
I2 = Ierdc;
I2(rm4)= 255;

figure, imshow(I2,[]);

%calculating background%
bg = imbinarize(I2,0.52);


D = bwdist(bg);
DW = watershed(D);
bgskele = DW ==0;

gradient2 = imimposemin(gradient,bgskele | rm4);

h = watershed(gradient2);
figure, imshow(h,[]);
