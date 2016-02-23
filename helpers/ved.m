function [output] = ved(correct, estimated)
%VED(correct, estimated) Perform vector error diffusion on `correct` based on
%estimated
%   Detailed explanation goes here

    weights = [1 3 5 3 1;
               3 5 7 5 3;
               5 7 0 0 0];
    weights = weights / sum(weights);

    err = correct - estimated;
    
    output = correct;
end

