function [new_image] = compensate_light(reference, image)
%COMPENSATE_LIGHT(reference, image) Compensate image's light based on
%reference's light
    light = image(:,:,1);
    mean_l = mean(light(:));
    reference_l = reference(1);
    
    ratio = reference_l / mean_l
    
    image(:,:,1) = light * ratio;
    new_image = image;
end

