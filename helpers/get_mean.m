function [mean_values_xyz, mean_values_lab] = get_mean(db)
%GET_MEAN(db, widht) Calculate mean LAB values for images in db
%   db - the cell array containing images
%   widht - the width to resize the images to before 
    l = numel(db);
    mean_values_xyz = zeros(l,3);
    mean_values_lab = zeros(l,3);
    for i = 1:l;
        mean_values_xyz(i,:) = mean_color(db{i});
        mean_values_lab(i,:) = xyz2lab(mean_values_xyz(i,:));
    end
end
