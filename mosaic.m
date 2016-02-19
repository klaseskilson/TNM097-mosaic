function [mosaic] = mosaic(img)
%MOSAIC(img) Create an mosaic of the RGB image img
%   Taking the RGB image `img`, an mosaic image is created using the image
%   database in palette.mat
    addpath('helpers');
    load('palette.mat');
    
    img = rgb2lab(img);
    tiles = slice_motif(img, 20);
    
    
    
    for i = 1:size(tiles, 4)
        % find best fitting small image
    end;

    mosaic = img;
end
