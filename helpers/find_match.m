function [index] = find_match(reference, samples, range)
%FIND_MATCH Summary of this function goes here
%   Detailed explanation goes here
reference = xyz2lab(reference);

closest_value = dist(reference, samples(1,:), range);
index = 1;

for i = 2:size(samples, 1)
    value = dist(reference, samples(i,:), range);
    if value < closest_value
        % disp(['Best match: ' num2str(value) ' index: ' num2str(i)])
        index = i;
        closest_value = value;
    end
end
end

