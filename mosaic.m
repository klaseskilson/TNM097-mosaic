function [mosaic] = mosaic(img, distance)
%MOSAIC(img, distance) Create an mosaic of the RGB image img
%   Taking the RGB image `img`, an mosaic image is created using the image
%   database in palette.mat
    addpath('helpers');
    addpath('helpers/scielab');
    load('palette.mat'); % loads palette
    
    ppi = 120;
    sampPerDeg = 5;
    tile_width = ceil((ppi  * (distance / 2.54) * tan(pi/180)) / sampPerDeg)
    db_im_width = size(palette{1}, 1);
    
    % convert color space and stack image
    img = rgb2xyz(img);
    disp(['Stacking image...'])
    [stacked_image, dimensions] = stack_image(img, tile_width, db_im_width);
    disp(['Getting mean values for palette...'])
    [palette_mean_xyz, palette_mean_lab] = get_mean(palette);
    
    % only match on ab channels
    match_range = 1:3;
    
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
        % index = find_match(stacked_mean(i, :), palette_mean_lab, match_range);
        index = find_match(diffused(i, :), palette_mean_lab, match_range);
        tile_img = palette{index};
        mosaic_stack(:,:,:,i) = lab2xyz(compensate_light(xyz2lab(stacked_mean(i, :)), xyz2lab(tile_img)));
        % mosaic_stack(:,:,:,i) = tile_img;
    end;

    disp(['Unstacking image...'])
    unstacked_result = unstack_image(mosaic_stack, dimensions);
    unstacked_original = unstack_image(stacked_image, dimensions);
    
    disp(['Finding quality...'])
    clab = quality(unstacked_original, unstacked_result, ppi / db_im_width);
    disp(['Quality: SCieLab: ' num2str(clab)])
    mosaic = xyz2rgb(unstacked_result);
end
