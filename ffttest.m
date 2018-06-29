function ffttest()
M = 500;
N = 500;
r = 0:M-1;
c = 0:N-1;
[R C]= meshgrid(r,c);
sinimage = 5*sin(0.5*R + 0.5*C)+5*sin(0.3*R);
g = mat2gray(sinimage);
X = fft(g);
figure, imshow(g);
figure, imagesc(abs(fftshift(X)));
