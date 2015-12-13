function [newpts,T] = normalize(pts)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

c = mean(pts(1:2, :)')';
newp(1,:) = pts(1,:) - c(1);
newp(2,:) = pts(2,:) - c(2);

dist = sqrt(newp(1,:).^2 + newp(2,:).^2);
meandist = mean(dist(:));

scale = sqrt(2)/meandist;

T = [scale 0 -scale*c(1)
     0     scale   -scale*c(2)
     0    0         1];
 
 newpts = T*pts;
