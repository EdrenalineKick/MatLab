function FourierChasteMovie()
cd('F:\ChasteVideos\GhostSizeTest\StillGhostCell1');
csvfiles = dir('*.csv');


%Scale of original images
oSize = 60;
%Scale factor
sFactor = 33;

%Load Nuclear masks to generate fake nucleii
load FUCCI_shapes.mat;

% Calculate the means and std of the shapes in the repository
for file = csvfiles'
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
    
    x_bit = (x_centre-floor(psz(1)/2):x_centre+ceil(psz(1)/2)-1);
    y_bit = (y_centre-floor(psz(2)/2):y_centre+ceil(psz(2)/2)-1);
    
    coords = vertcat(x_bit,y_bit);
    
    figure;
    imshow(I)
    
    %Quality control; if cell pixels exceed image border then they are not
    %rendered
    isTooSmall = coords(:,1) <= 0;
    isTooSmall = sum(isTooSmall);
    isTooBig = coords(:,end) >= oSize*sFactor;
    isTooBig = sum(isTooBig);
    
    %Skip the loop of any nucleus outside image border
    if (isTooSmall >= 1)
        continue;
    end
    
    if(isTooBig >= 1)
        continue;
    end
    
    
    green_mask(coords(1,:),coords(2,:)) = I;
    red_mask(coords(1,:),coords(2,:)) = I;
    
    %generate sine wave with positive offset to bias populations
%         fucci_phase = (sin(2*pi*frequency*time+randTime(m(i,3)))+0.5);
%     if fucci_phase >= 0 
%         green_image(green_mask==1) = fucci_phase;
%     else
%         red_image(red_mask==1) = abs(fucci_phase);
%     end

    if m(i,4) == 0 || m(i,4) == 1
        red_image(red_mask == 1) = 1;
    else
        green_image(green_mask == 1) = 1;
    end
end


image = zeros(oSize*sFactor,oSize*sFactor,3);
green_image = mat2gray(green_image);
red_image = mat2gray(red_image);
%green_image = imnoise(green_image,'gaussian');
%red_image = imnoise(red_image,'gaussian');

image(:,:,2) = green_image;
image(:,:,1) = red_image;
%image = imgaussfilt(image,2);
imwrite(image,[file.name(1:end-4),'.png']);
end
