function main()
    levels = struct('haloLevel',{[]},'igLevel',{[]});
    imageAlpha = 0.5;
    im = imread('Testimage.tif');

    levels.haloLevel = graythresh(im);
    level=imageAlpha*levels.haloLevel;
    
    level = min(level,0.95);
    level = max(level,0.05);
    
    bwHalo=im2bw(im,level);
    
    bwDark=0*im;
    seBig=strel('square',19);
    
    se=strel('square',3);
    gd=imdilate(im,se);
    ge=imerode(im,se);
    ig=gd-ge;
    levels.igLevel = graythresh(ig);
    lig=levels.igLevel;
    bwig=im2bw(ig,lig);
    
    bwmask=imclose(bwig,seBig);
    % find dark chewy centers
    CC = bwconncomp(bwmask,8);
    LHaloMask = labelmatrix(CC);
    num=max(LHaloMask(:));
    for n=1:num
        pix=find(LHaloMask==n & ~bwHalo);
        level=graythresh(im(pix));
        bwpix=im2bw(im(pix),level);
        bwDark(pix(find(~bwpix)))=1;
    end
    
    
    bwDarkCenters=(bwDark & bwmask );
    d=bwdist(~bwDarkCenters);
    bwDarkCenters(d<2)=0;

    bwHaloMask=imdilate(bwHalo,seBig);
    
    bwHaloHoles=imfill(bwHalo ,8,'holes') & ~bwHalo;
    bwDarkHoles=imfill(bwDarkCenters ,8,'holes') & ~bwDarkCenters;
    bwgHoles=bwmorph(bwig | bwDarkCenters,'close',1) ;
    bwgHoles=imfill(bwgHoles ,8,'holes') & ~(bwig | bwDarkCenters);
    
    bwHoles=bwHaloHoles | bwDarkHoles | bwgHoles;
    
    CC = bwconncomp(bwHoles,8);
    LHoles = labelmatrix(CC);
    stats = regionprops(CC, 'Area');
    idx = find([stats.Area] < 500);
    bwHoles = ismember(LHoles, idx);
    bwCells=bwDarkCenters | bwHoles;
    bwCells(~bwHaloMask)=0;
    
    bwCells(bwig)=0;
    
    bwTails=bwDarkCenters;
    bwTails(bwHalo)=0;
    CC = bwconncomp(bwTails,8);
    LTails = labelmatrix(CC);
    
    CC = bwconncomp(bwCells,8);
    LCenters = labelmatrix(CC);
    stats=regionprops(CC,'eccentricity');
    d=bwdist(~bwCells);
    
    imshow(bwDarkCenters,[])