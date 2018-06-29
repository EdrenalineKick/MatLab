function ChasteFakeFrame()
run('C:\Program Files\DIPimage 2.9\dipstart.m')

cd('F:\ChasteVideos\CellCycleWriterTest');
csvfiles = dir('*.csv');

%generate random numbers for each index
randTime = randn(3000)*30;
time = 1;

%set frequency of oscillations of FUCCI, 15 hours = 30 timesteps.
frequency = 1/30;
%Scale of original images
oSize = 60;
%Scale factor
sFactor = 20;

file = csvfiles(end);
m = csvread(file.name);

green_image = zeros(oSize*sFactor,oSize*sFactor);
red_image = zeros(oSize*sFactor,oSize*sFactor);

for i = 1:length(m)
    %x and y coordinates + offset and * scaling
    x_centre = floor((m(i,1)+5)*sFactor);
    y_centre = floor((m(i,2)+5)*sFactor);
    
    green_mask = zeros(oSize*sFactor,oSize*sFactor);
    red_mask = zeros(oSize*sFactor,oSize*sFactor);

    
    I = generate_nucleus_shape((1/3000)*oSize*sFactor,(1/3000)*oSize*sFactor);
    I = imbinarize(dip_array(I));
    
    psz = size(I);
    x_bit = (x_centre-floor(psz(1)/2)):(x_centre+ceil(psz(1)/2)-1);
    y_bit = (y_centre-floor(psz(2)/2):y_centre+ceil(psz(2)/2)-1);
    
    green_mask(x_bit,y_bit) = I;
    red_mask(x_bit,y_bit) = I;
    
    %generate sine wave with positive offset to bias populations
    %fucci_phase = (sin(2*pi*frequency*time+randTime(m(i,3)))+0.5);
    %if fucci_phase >= 0 
    %    green_image(green_mask==1) = fucci_phase;
    %else
    %    red_image(red_mask==1) = abs(fucci_phase);
    %end
    
    if m(i,4) == 1
        green_image(green_mask == 1) = 1;
    else
        red_image(red_mask == 1) = 1;
    end

end
image = zeros(oSize*sFactor,oSize*sFactor,3);
green_image = mat2gray(green_image);
red_image = mat2gray(red_image);
green_image = imnoise(green_image,'gaussian');
red_image = imnoise(red_image,'gaussian');

image(:,:,2) = green_image;
image(:,:,1) = red_image;
image = imgaussfilt(image,4);
imwrite(image,[file.name(1:end-4),'.png']);
imshow(image)

