function [clab] = quality(orig, img, sampPerDeg)
%QUALITY(orig, new) calculate quality of img compared to orig
%   Detailed explanation goes here
    addpath('helpers/scielab');
    scaled_im = zeros(size(orig));
    dim = size(img);
    wp = [95.047 100 108.883];
    
    dims = size(img);
    
    cropped_orig = orig(1:dims(1), 1:dims(2), 1:dims(3));
    
    clab = scielab(sampPerDeg, cropped_orig, img, wp, 'xyz');
    clab = mean(clab(:));
end

