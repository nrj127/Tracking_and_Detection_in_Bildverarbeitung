function [ G ] = gaussian( u,v,sigma )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
G = (1\(2*pi*sigma^2))*exp(-0.5*(u.^2 + v.^2)/sigma^2);
G = 1/(sum(G(:))) * G
end

