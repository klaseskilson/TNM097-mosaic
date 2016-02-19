function [ res ] = dist(a, b)
%DIST(a,b) Calculate eucledian distance between a and b
%   Both a and b are 1xN vectors
    res = sqrt(sum((a - b) .^ 2));
end

