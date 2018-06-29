function main()
close all
pic=imread('fiber1.tif');
small=subim(pic, 80, 80, 150, 50);
imshow(small,[]);
size(small)
end