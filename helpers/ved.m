function [output] = ved(img)
%VED(img) Perform vector error diffusion on image img
%   Detailed explanation goes here

    weights = [1 3 5 3 1;
               3 5 7 5 3;
               5 7 0 0 0];
    weights = weights / sum(weights);


end

