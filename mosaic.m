function [mosaic] = mosaic(img, distance)
%MOSAIC(img, distance) Create an mosaic of the RGB image img
%   Taking the RGB image `img`, an mosaic image is created using the image
%   database in palette.mat
    addpath('helpers');
    load('palette.mat'); % loads palette
    
    % calculate number of tiles per degree
    tilePerDeg = 3;
    ppi = 120;
    side = size(img, 2);
    sampPerDeg = side * (distance / 2.54) * tan(pi/180);
    % s = atan((side / ppi) / (distance / 2.54)) * (180 / pi);
    tile_width = min([floor(sampPerDeg / tilePerDeg) side]);
    
    % convert color space and stack image
    img = rgb2xyz(img);
    disp(['Stacking image...'])
    [stacked_image, dimensions] = stack_image(img, tile_width);
    disp(['Getting mean values for palette...'])
    [palette_mean_xyz, palette_mean_lab] = get_mean(palette, tile_width);
    
    % only match on ab channels
    match_range = 2:3;
    
    disp(['Matching patches...'])
    stacked_mean = zeros(size(palette_mean_xyz));
    stacked_palette = zeros(size(palette_mean_xyz));
    mosaic_stack = zeros(size(stacked_image));
    for i = 1:size(stacked_image, 4)
        % find best fitting small image for each tile
        stacked_mean(i, :) = mean_color(stacked_image(:,:,:,i));
        index = find_match(stacked_mean(i, :), palette_mean_lab, match_range);
        stacked_palette(i, :) = palette_mean_xyz(index, :);
    end;

    % apply vector error diffusion
    disp(['Applying VED...'])
    correct = reshape(stacked_mean, [dimensions(1) dimensions(2) 3]);
    estimated = reshape(stacked_palette, [dimensions(1) dimensions(2) 3]);
    diffused = ved(correct, estimated);
    diffused = reshape(diffused, [(dimensions(1) * dimensions(2)) 3]);
    
    for i = 1:size(stacked_image, 4)
        % find best fitting small image
        index = find_match(stacked_palette(i, :), palette_mean_lab, match_range);
        tile_img = imresize(palette{index}, [tile_width tile_width]);
%         mosaic_stack(:,:,:,i) = lab2xyz(compensate_light(palette_mean_lab(index, :), xyz2lab(tile_img)));
        mosaic_stack(:,:,:,i) = tile_img;
    end;

    disp(['Unstacking image...'])
    unstacked = unstack_image(mosaic_stack, dimensions);
    clab = quality(img, unstacked, sampPerDeg);
    disp(['Quality: SCieLab: ' num2str(clab)])
    mosaic = xyz2rgb(unstacked);
end
