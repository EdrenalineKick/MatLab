function YokogawaGreenSegmentation()
im = imread('GreenYokoImage.tif');
% threshold = graythresh(im);
% bw = imbinarize(im,threshold);
% max_value = max(im(:));
% im(bw) = max_value;
% imshow(im,[])

I = imgaussfilt(im);
se = strel('disk',2);
gradientDilate = imdilate(I,se);
gradientErode = imerode(I,se);
imageGradient = gradientDilate - gradientErode;

dbI = double(imageGradient);
dbI = dbI/max(max(dbI));
level = graythresh(dbI);
bw = im2bw(dbI, 0.06);

imageCopy = I;
imageCopy(bw) = max(imageCopy(:));
figure,imshow(imageCopy,[])

disk = strel('disk',10);
bigDisk = strel('disk',3);
stuff = imclose(bw,disk);
figure,imshow(stuff);
stuff = imopen(stuff, bigDisk);
figure,imshow(stuff);
% fill = imclose(bw,disk);
% figure, imshow(fill,[]);
% fill = imopen(fill,disk);
% figure,imshow(fill,[]);
% I(fill) = max(I(:));
% figure, imshow(I,[]);





