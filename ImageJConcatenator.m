time = 1;

cd('F:\MicroscopyData\20180123 FUCCI new polyclonal single cells mTeSR vs E8 plus stem beads\G7F009');
tifFiles = dir('*.tif*');
tifFiles.name
firstImage = imread(tifFiles(1).name);
s = size(firstImage);

image = zeros(s(1),s(2),3);
image = im2uint16(image);

for file = tifFiles'
     I = imread(file.name);
     
     if (contains(file.name,'C04'))
        image(:,:,2) = I;    
     elseif (contains(file.name,'C08'))
        image(:,:,3) = I;
     else
        image(:,:,1) = I;
        name = sprintf('Time%03d',time);
        name = strcat(name,'.tif');
        imwrite(image,name,'tif')
        time = time+1;
     end
      
end     
