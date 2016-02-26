function [color] = mean_color(img)
%color = MEAN_COLOR(img) Calculate mean color in `img`
%   Img is a MxNx3 matrix
    for i = 1:size(img, 3)
        im = img(:,:,i);
        color(i) = mean(im(:));
    end
end

