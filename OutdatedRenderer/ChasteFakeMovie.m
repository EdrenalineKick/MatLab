function ChasteFakeMovie()

cd('F:\ChasteVideos\testoutput\Force08Linear15Killer1\results_from_time_0');
csvfiles = dir('*.csv');

%generate random numbers for each index
randn1 = rand(3000);
randn2 = rand(3000);
rand1 = randn(3000);
rand2 = randn(3000)*30;
time = 1;

%set frequency of oscillations of FUCCI, 15 hours = 30 timesteps.
frequency = 1/30;
%Scale of original images
oSize = 60;
%Scale factor
sFactor = 50;

for file = csvfiles'
    time = time+1;
    m = csvread(file.name);
    green_mask = zeros(oSize*sFactor,oSize*sFactor);
    red_mask = zeros(oSize*sFactor,oSize*sFactor);

for i = 1:length(m)
    %x and y coordinates + offset and * scaling
    x_centre = (m(i,1)+5)*sFactor;
    y_centre = (m(i,2)+5)*sFactor;
    %flat radius + fixed random number + additional noise
    x_radius = (0.25 + randn1(m(i,3))*0.15+0.02*randn)*sFactor;
    y_radius = (0.25 + randn2(m(i,3))*0.15+0.02*randn)*sFactor;
    theta = 0 : 0.01 : 2*pi;
    
    angle = rand1(m(i,3))*2*pi+randn*pi/6;
    p=[(x_radius .* cos(theta))' (y_radius .* sin(theta))'];

    alpha=[cos(angle) -sin(angle)
    sin(angle) cos(angle)];
    
    p1 = p*alpha;
    
    x = p1(:,1) + x_centre;
    y = p1(:,2) + y_centre;
    ROI = poly2mask(x,y,oSize*sFactor,oSize*sFactor);
    
    fucci_phase = (sin(2*pi*frequency*time+rand2(m(i,3)))+0.5);
    if fucci_phase >= 0 
        green_mask(ROI) = fucci_phase;
    else
        red_mask(ROI) = abs(fucci_phase);
    end
end
image = zeros(oSize*sFactor,oSize*sFactor,3);
green_mask = mat2gray(green_mask);
red_mask = mat2gray(red_mask);

image(:,:,2) = green_mask;
image(:,:,1) = red_mask;
image = imgaussfilt(image,10);
%image = imnoise(image,'gaussian');
imwrite(image,['testframe','.png']);
end
