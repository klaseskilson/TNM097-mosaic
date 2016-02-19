function [stacked_image, dimesions] = stack_image(input_image, patch_width)

dimesions = floor(size(input_image) / patch_width);

stacked_image = zeros(patch_width, patch_width, 3, dimesions(1)*dimesions(2));
counter = 1;
for y = 1:patch_width:size(input_image, 2)
    for x = 1:patch_width:size(input_image, 1)
        x_range = x:(x+patch_width-1);
        y_range = y:(y+patch_width-1);
        if x+patch_width < size(input_image,1) & y+patch_width < size(input_image,2)
            stacked_image(:,:,:,counter) = input_image(x_range,y_range,:);
        end
        counter = counter + 1;
    end
end

end