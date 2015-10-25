function [ kernel ] = GaussianSeparate( sigma,mode )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
radius = 3*sigma;
range = floor(radius/2);
range = -range:range;

if strcmp(mode,'xDirection')
    tempValue = range;
end

if strcmp(mode, 'yDirection')
    tempValue = range';

end

kernel =  (1\(2*pi*sigma^2))*exp(-0.5*(tempValue.^2)/(sigma^2));

kernel = kernel/sum(kernel(:));
end
