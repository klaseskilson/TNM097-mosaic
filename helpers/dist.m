function [ res ] = dist(a, b, range)
%DIST(a, b, range) Calculate eucledian distance between a and b
%   Both a and b are 1xN vectors
%   range specifies which elements to use
    res = sqrt(sum((a(range) - b(range)) .^ 2));
end

