function [ index ] = find_match( reference, samples )
%FIND_MATCH Summary of this function goes here
%   Detailed explanation goes here
closest_value = dist(reference, samples(1,:));
index = 1;

for i = 2:size(samples, 1)
    value = dist(reference, samples(i,:));
    if value < closest_value
        index = i;
        closest_value = value;
    end
end
end

