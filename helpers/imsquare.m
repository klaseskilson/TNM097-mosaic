function [cropped] = imsquare(img)
%cropped = IMSQUARE(img) Make an image's aspect ration 1:1
    dimensions = size(img(:,:,1));
    
    if dimensions(1) == dimensions(2)
        % square image, exit functions
        cropped = img;
        return;
    end
    
    if (dimensions(1) > dimensions(2))
        % landscape image
        xmin = 0;
        ymin = (dimensions(1) - dimensions(2)) / 2;
    else
        % portrait image
        xmin = (dimensions(2) - dimensions(1)) / 2;
        ymin = 0;
    end
    
    side = min(dimensions);
    cropped = imcrop(img, [round(xmin) round(ymin) side-1 side]);
end
