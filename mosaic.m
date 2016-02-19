function [mosaic] = mosaic(img)
%MOSAIC(img) Create an mosaic of the RGB image img
%   Taking the RGB image `img`, an mosaic image is created using the image
%   database in palette.mat
    addpath('helpers');
    load('palette.mat'); % loads db
    
    
    tile_width = 20;
    img = rgb2lab(img);
    tiles = slice_motif(img, tile_width);
    for i = 1:numel(db)
        db(1,i) = imresize(db(1,i), [tile_width tile_width]);
    end
    mean_values = get_mean(db, tile_width);
    
    for i = 1:size(tiles, 4)
        % find best fitting small image
        
    end;

    mosaic = img;
end
