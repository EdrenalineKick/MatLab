function Draq7Counter()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\');

areaStore = zeros(96,9,3);
wells = ['E','F','G'];

for i = 1:3
    currentWell = wells(i);
    i
    wellString = strcat('\*',currentWell,'10*\');
    for t = 1:2
        
        
        day = string(t);
        
        
        
        dayString = strcat('*Day',day);
        for j = 1:9
            
            
            
            field = string(j);
            fieldString = strcat(dayString,'\*',wellString,'*F00',field,'*C03*.tif');
            fieldString = char(fieldString);
            files = dir(fieldString);
            
            if t == 1
                k = 1;
            end
            
            if t ==2
                k = 49;
            end
            
            
            for file = files'
                fullFile = fullfile(file.folder,file.name);
                im = imread(fullFile);
                
                % smooth and bg remove
                imFilt = medfilt2(im);
                imFilt = max(imFilt,0);
                imFilt = im2uint8(imFilt);
                
                % Fluorescence (FUCCI) Segmentation
                bwFluor = imbinarize(imFilt);
                
                se=strel('disk',3);
                bwCell=imdilate(bwFluor,se);
                
                cellArea = regionprops(bwCell,'Area');
                numObjects = numel(cellArea);
                
                areaStore(k,j,i) = numObjects;
                
                k = k+1;
                %         i
                %         j
                %         k
                %         fullFile
                %         numObjects
            end
        end
    end
end
