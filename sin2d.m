function image = sin2d(A, x0, y0, M, N);
r = 0:M-1;
c = 0:N-1;
[R C]= meshgrid(r,c);
sinimage = A*sin(x0*R + y0*C);
g = mat2gray(sinimage);
imshow(g)
end