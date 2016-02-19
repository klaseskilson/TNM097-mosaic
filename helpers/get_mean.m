function [mean_values] = get_mean(db, widht)
%GET_MEAN(db, widht) Calculate mean LAB values for images in db
%   db - the cell array containing images
%   widht - the width to resize the images to before 
    l = numel(db);
    mean_values = zeros(l,3);
    for i = 1:l;
        clear img;
        img = imresize(db{i}, [widht widht]);
        mean_values(i,:) = mean_lab(img);
    end
end
