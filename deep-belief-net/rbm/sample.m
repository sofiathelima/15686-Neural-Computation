function [ s] = sample( p )
%SAMPLE Summary of this function goes here
%   Detailed explanation goes here

s = double(rand(size(p)) < p);

end

