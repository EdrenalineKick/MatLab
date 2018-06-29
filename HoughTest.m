function HoughTest()
close all;
RGB = imread('cranes.jpg');
I = rgb2gray(RGB);
bw = edge(I,'canny');
figure, imshow(bw);

[H,T,R] = hough(bw);

P = houghpeaks(H,5,'threshold',ceil(0.001*max(H(:))));
lines = houghlines(bw,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(I), hold on
for i = 1:length(lines)
    xy = [lines(i).point1; lines(i).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end