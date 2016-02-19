function [mosaic] = mosaic(img)
%MOSAIC(img) Create an mosaic of the RGB image img
%   Taking the RGB image `img`, an mosaic image is created using the image
%   database in palette.mat
    addpath('helpers');
    load('palette.mat');
    
    patch_size = 20;
    
    for i = 1:numel(db)
        db(1,i) = imresize(db(1,i), [patch_size patch_size]);
    end
    
    img = rgb2lab(img);
    tiles = slice_motif(img, patch_size);
    
    
    for i = 1:size(tiles, 4)
        % find best fitting small image
        
    end;

    mosaic = img;
end
