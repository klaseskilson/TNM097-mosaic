function [ mosaic_image ] = unstack_image( stacked_image, dimensions )
%UNSTACK_IMAGE Summary of this function goes here
%   Detailed explanation goes here

patch_width = size(stacked_image, 1);
index = 1;
mosaic_image = zeros(patch_width*dimensions(1), patch_width*dimensions(2), 3);

for y = 1:dimensions(2)
    for x = 1:dimensions(1)
        x_range = ((x-1)*patch_width+1):(x*patch_width);
        y_range = ((y-1)*patch_width+1):(y*patch_width);
        mosaic_image(x_range, y_range,:) = stacked_image(:,:,:,index);
        index = index + 1;
   end
end

end

