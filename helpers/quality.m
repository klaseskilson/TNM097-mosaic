function [mse, snrval] = quality(orig, img)
%QUALITY(orig, new) calculate quality of img compared to orig
%   Detailed explanation goes here
    scaled_im = zeros(size(orig));
    dim = size(img);
    scaled_im(1:dim(1), 1:dim(2), :) = img;
    
    diff = (orig - scaled_im) .^ 2;
    mse = mean(diff(:));
    snrval = snr(orig, orig - scaled_im);
end

