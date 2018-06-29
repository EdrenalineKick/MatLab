function HoughCircleTest()
A = imread('Circles.png');

Rmin = 30;
Rmax = 65;

figure, imshow(A), hold on

[centresBright, radiiBright] = imfindcircles(A, [Rmin Rmax],'ObjectPolarity','bright','sensitivity',0.95);
[centresDark, radiiDark] = imfindcircles(A,[Rmin Rmax], 'ObjectPolarity', 'dark','sensitivity',0.9);
viscircles(centresBright,radiiBright,'Color','b');
viscircles(centresDark, radiiDark, 'Color', 'green');