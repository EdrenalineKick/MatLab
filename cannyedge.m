function cannyedge()
f=WIN_20170717_174647;
f=rgb2gray(f);
g=edge(f,'canny');
imshow(g)
end
