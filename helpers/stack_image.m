function [stacked_image, dimesions] = stack_image(input_image, patch_width, db_im_width)

dimesions = floor(size(input_image) / patch_width);

% 4D matrix for stacked image
stacked_image = zeros(db_im_width, db_im_width, 3, dimesions(1) * dimesions(2));
counter = 1;
for y = 1:patch_width:size(input_image, 2)
    for x = 1:patch_width:size(input_image, 1)
        x_end = (x + patch_width - 1);
        y_end = (y + patch_width - 1);
        x_range = x:x_end;
        y_range = y:y_end;
        if x_end <= size(input_image, 1) & y_end <= size(input_image, 2)
            stacked_image(:, :, :, counter) = imresize(input_image(x_range, y_range, :), [db_im_width db_im_width], 'bicubic');
            counter = counter + 1;
        end
    end
end

end