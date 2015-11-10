function [ kernel ] = GaussianSeparate( radius,sigma,mode )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here



if strcmp(mode,'xDirection')
    tempValue = [-floor(radius(1)/2): floor(radius(1)/2)];
end

if strcmp(mode, 'yDirection')
      tempValue = [-floor(radius(2)/2): floor(radius(2)/2)]';

end

kernel =  exp(-0.5*(tempValue.^2)/(sigma^2));

kernel = kernel/sum(kernel(:));
end
