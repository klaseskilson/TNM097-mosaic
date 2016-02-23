function [mosaic] = mosaic(img, distance)
%MOSAIC(img, distance) Create an mosaic of the RGB image img
%   Taking the RGB image `img`, an mosaic image is created using the image
%   database in palette.mat
    addpath('helpers');
    load('palette.mat'); % loads db
    
    % calculate number of tiles per degree
    tilePerDeg = 3;
    ppi = 120;
    side = size(img, 2);
    sampPerDeg = side * (distance / 2.54) * tan(pi/180);
    % s = atan((side / ppi) / (distance / 2.54)) * (180 / pi);
    tile_width = min([floor(sampPerDeg / tilePerDeg) side]);
    
    % convert color space and stack image
    img = rgb2lab(img);
    disp(['Stacking image...'])
    [stacked_image, dimensions] = stack_image(img, tile_width);
    disp(['Getting mean values for palette...'])
    mean_values = get_mean(palette, tile_width);
    
    disp(['Matching patches...'])
    stacked_lab = zeros(size(mean_values));
    stacked_mean = zeros(size(mean_values));
    mosaic_stack = zeros(size(stacked_image));
    for i = 1:size(stacked_image, 4)
        % find best fitting small image
        stacked_lab(i, :) = mean_lab(stacked_image(:,:,:,i));
        index = find_match(stacked_lab(i, :), mean_values);
        stacked_mean(i, :) = mean_values(index, :);
    end;

    % apply vector error diffusion
    correct = reshape(stacked_lab, [dimensions(1) dimensions(2) 3]);
    estimated = reshape(stacked_mean, [dimensions(1) dimensions(2) 3]);
    diffused = ved(correct, estimated);
    diffused = reshape(diffused, [(dimensions(1) * dimensions(2)) 3]);
    
    for i = 1:size(stacked_image, 4)
        % find best fitting small image
        index = find_match(diffused(i, :), mean_values);
        mosaic_stack(:,:,:,i) = imresize(palette{index}, [tile_width tile_width]);
    end;

    disp(['Unstacking image...'])
    unstacked = unstack_image(mosaic_stack, dimensions);
    [mse, snrval] = quality(img, unstacked);
    disp(['Quality: MSE: ' num2str(mse) ' SNR: ' num2str(snrval)])
    mosaic = lab2rgb(unstacked);
end
