function DBScanCorrelator()

cd('C:\Users\Ed\Documents\BristolWork\ChasteAdhesionParametreScan');

csv = readtable("ChasteParametreScanDBScan.csv");
conditions = table2array(csv(:,1));
n = length(conditions);

meanColonySize = table2array(csv(:,3));

movement = zeros(n,1);
death = zeros(n,1);
spring = zeros(n,1);

for i = 1:n
string = conditions{i};
movement(i) = str2double(extractBetween(string,"Movement","Death"));
death(i) = str2double(extractBetween(string,"Death","Spring"));
spring(i) = str2double(extractBetween(string,"Spring","/"));
end

X = [ones(size(movement)) movement death spring movement.*spring movement.*death spring.*death movement.*spring.*death]
b = regress(meanColonySize,X)

scatter3(movement,death,meanColonySize,'filled')
hold on
x1fit = min(movement):0.1:max(movement);
x2fit = min(death):0.01:max(death);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(6)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('Diffusivity')
ylabel('Death Rate')
zlabel('Colony Size in Cells')
view(25,30)
hold off

figure;
scatter3(movement,spring,meanColonySize,'filled')
hold on
x1fit = min(movement):0.1:max(movement);
x2fit = min(spring):1:max(spring);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(4)*X2FIT + b(5)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('Movement')
ylabel('Spring')
zlabel('Colony Size')
view(30,10)
hold off

[movementR movementP] = corrcoef(movement,meanColonySize)

[deathR deathP] = corrcoef(death,meanColonySize)

[springR springP] = corrcoef(spring,meanColonySize)

parameters = cat(2,movement,death);
parameters = cat(2,parameters,spring);

stepwisefit(parameters,meanColonySize,...
            'penter',0.05,'premove',0.10);
% figure;
% scatter(movement,meanColonySize)
% 
% figure;
% scatter(death,meanColonySize)
% 
% figure;
% scatter(spring,meanColonySize)
