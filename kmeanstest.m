function kmeanstest()
rng default;
x = [randn(100,2)*0.75+ones(100,2);randn(100,2)*0.5-ones(100,2)];


[idx,C] = kmeans(x,2);
figure, hold on;
plot(x(idx==1,1),x(idx==1,2),'b.');
plot(x(idx==2,1),x(idx==2,2),'g.');
plot(C(:,1),C(:,2),'x');
