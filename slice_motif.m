function sliced_array = slice_motif(input_image, patch_width)

tiles = floor(size(input_image) / patch_width);

sliced_array = zeros(patch_width, patch_width, 3, tiles(1)*tiles(2));
counter = 1;
for y = 1:patch_width:size(input_image, 2)
    for x = 1:patch_width:size(input_image, 1)
        if x+patch_width < size(input_image,1) & y+patch_width < size(input_image,2)
            sliced_array(:,:,:,counter) = input_image(x:(x+patch_width-1),y:(y+patch_width-1),:);
        end
        counter = counter + 1;
    end
end

end