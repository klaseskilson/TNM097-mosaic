function [mosaic] = mosaic(img)
%MOSAIC(img) Create an mosaic of the RGB image img
%   Taking the RGB image `img`, an mosaic image is created using the image
%   database in palette.mat
    addpath('helpers');
    load('palette.mat'); % loads db
    
    
    tile_width = 20;
    img = rgb2lab(img);
    [stacked_image, dimensions] = stack_image(img, tile_width);
%     for i = 1:numel(db)
%         db{i} = imresize(db{i}, [tile_width tile_width]);
%     end
    mean_values = get_mean(palette, tile_width);
    
    for i = 1:size(stacked_image, 4)
        % find best fitting small image
        index = find_match(mean_lab(stacked_image(:,:,:,i)), mean_values);
        mosaic_stack(:,:,:,i) = imresize(palette{index}, [tile_width tile_width]);
    end;

    mosaic = lab2rgb(unstack_image(mosaic_stack, dimensions));
end
