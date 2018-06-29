function main()
%Closes all previous figures%
close all

%Reads a specified image file%
I=imread('r20oct98.phal.10--1---2.tif');
%Generates a 8-by-8 Laplace of Gaussian filter%
Log=fspecial('log',[8 8],1);
%Filters the image%
filteredimage=imfilter(I,Log);
%Converts a grayscale image to a binary image through thresholding%
cutoffimage= filteredimage>2;
figure;imshow(cutoffimage);
%Saves the binary image produced%
imwrite(cutoffimage,'10.tif')
%Computes a Distance transform of the Binary image%
D=bwdist(cutoffimage);
%Calculates the mean value of the distance transform%
meanrow=mean(D);
meandistance=mean(meanrow);