function [ kernel ] = Gaussian2D(sigma )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

radius = ceil(3*sigma);

range = -floor(radius/2):floor(radius/2);

[u,v] = meshgrid(range,range);

kernel = gaussian(u,v,sigma);

end

