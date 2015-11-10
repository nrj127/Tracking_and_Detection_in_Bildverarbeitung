function [ G ] = gaussian( u,v,sigma )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
G = exp(-0.5*(u.^2 + v.^2)/sigma^2);
%G = exp(-(u.^2 + v.^2)/(2*sigma^2));
G = G./(sum(G(:))); %Normalization
end

