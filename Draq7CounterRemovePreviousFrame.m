function Draq7CounterRemovePreviousFrame()

cd('C:\Users\Ed\Documents\MicroscopyData\20180403_SingleCell+Draq7+2wellsStemBeads\');

areaStore = zeros(96,9,3);
wells = ['E','F','G'];

for i = 1:3
    currentWell = wells(i);
    i
    wellString = strcat('\*',currentWell,'10*\');
    
    for j = 1:9
        field = string(j);
        j
        bwCell = zeros(2160,2560);
        for t = 1:2
            
            
            day = string(t);
            
            t
            
            dayString = strcat('*Day',day);
            
            
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
                bwFluor = imbinarize(imFilt);
                connectedFluor = bwconncomp(bwFluor);
                bwOverlap = bwFluor + bwCell;
                
                overlayMean = regionprops(connectedFluor,bwOverlap,'Mean','PixelIdxList');
                nonOverlayingROIs = overlayMean([overlayMean.MeanIntensity] <= 1);
                
                se=strel('disk',3);
                bwCell=imdilate(bwFluor,se);
                
%                 bwNonOverlay = zeros(size(bwFluor));
%                 bwNonOverlay(vertcat(nonOverlayingROIs.PixelIdxList)) = 1;
%                 
%                 bwNonOverlay = imdilate(bwNonOverlay,se);
%                 connectedComponents = 
%                 cellArea = regionprops(bwNonOverlay,'Area');
%                 numObjects = numel(cellArea);
%               
                numObjects = numel(nonOverlayingROIs);
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
    areaStore
end
