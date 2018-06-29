function SequentialChasteMovie()
cd('F:\ChasteVideos\GhostSizeTest\StillGhostCell1');
csvfiles = dir('*.csv');

%Scale of original images
oSize = 60;
%Scale factor
sFactor = 33;

%Load Nuclear masks to generate fake nucleii
load FUCCI_shapes.mat

% Calculate the means and std of the shapes in the repository
real_mean = mean(real(shapes));
imag_mean = mean(imag(shapes));
real_std = 1.0*std(real(shapes));
imag_std = 1.0*std(imag(shapes));
cellIndices = [];

for file = csvfiles'
    m = readtable(file.name);
    
    green_image = zeros(oSize*sFactor,oSize*sFactor);
    red_image = zeros(oSize*sFactor,oSize*sFactor);
    
    green_mask = zeros(oSize*sFactor,oSize*sFactor);
    red_mask = zeros(oSize*sFactor,oSize*sFactor);
    
    cell_parameters = cell(height(m),3);
    
for i = 1:height(m)
    
    %x and y coordinates + offset and * scaling
    x_centre = floor((m{i,{'Var1'}}+5)*sFactor);
    y_centre = floor((m{i,{'Var2'}}+5)*sFactor);
    
    cellIndex = m{i,{'Var3'}};
    %% Set parameters

    image_size = round(sqrt(max(1.5*scalings*(1/3000)*oSize*sFactor)/pi)*[2 2]);
    scale = mean(scalings);

    if (ismember(cellIndex,cellIndices) == 0)
    % Generate a new shape
        nuc_shape = (real_mean + real_std.*randn(size(real_std)))+1j*(imag_mean + imag_std.*randn(size(imag_std)));
        nuc_shape(5:end-4) = 0;
        
        cell_parameters{i,1} = cellIndex;
        cell_parameters{i,2} = real(nuc_shape);
        cell_parameters{i,3} = imag(nuc_shape);
        
    else        
        indices = cell2mat(store(i,1));
        cell_mean = store(indices == cellIndex,:);
        
        if (isempty(cell_mean))
            continue
        end
                
        nuc_shape = (cell_mean{2} + 0.2*real_std.*randn(size(real_std)))+1j*(cell_mean{3} + 0.2*imag_std.*randn(size(imag_std)));
        %nuc_shape = (real_mean + 0.8*real_std.*randn(size(real_std)))+1j*(imag_mean + 0.8*imag_std.*randn(size(imag_std)));
        nuc_shape(5:end-4) = 0;
        cell_parameters{i,1} = cellIndex;
        cell_parameters{i,2} = real(nuc_shape);
        cell_parameters{i,3} = imag(nuc_shape);
    end
    

    % Return to spacial domain
    nuc_shape = ifft(nuc_shape);
    nuc_shape = [real(nuc_shape)' imag(nuc_shape)'];

    % Scale the coordinates
    nuc_shape = nuc_shape.*scale*(1/3000)*oSize*sFactor;
    c = coord2image(round(nuc_shape+(image_size(1)-1)/2),image_size);

    I = fillholes(bskeleton(bdilation(c,2)));
    I = imbinarize(dip_array(I));
        
    psz = size(I);
    
    x_bit = (x_centre-floor(psz(1)/2):x_centre+ceil(psz(1)/2)-1);
    y_bit = (y_centre-floor(psz(2)/2):y_centre+ceil(psz(2)/2)-1);
    
    coords = vertcat(x_bit,y_bit);

    isTooSmall = coords(:,1) <= 0;
    isTooSmall = sum(isTooSmall);
    isTooBig = coords(:,end) >= oSize*sFactor;
    isTooBig = sum(isTooBig);
    
    
    if (isTooSmall >= 1)
        continue;
    end
    
    if(isTooBig >= 1)
        continue
    end
    
    green_mask(coords(1,:),coords(2,:)) = I;
    red_mask(coords(1,:),coords(2,:)) = I;
    
    if (m{i,{'Var4'}} == 0 || m{i,{'Var4'}} == 1)
        red_image(red_mask == 1) = 1;
    else
        green_image(green_mask == 1) = 1;
    end
    
end
store = cell_parameters;
%Record which cells have already appeared
cellIndices = unique(cat(1,cellIndices,m.Var3));

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
