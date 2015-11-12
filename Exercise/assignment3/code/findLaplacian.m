function [ lcorners ] = findLaplacian( x,sigma )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

lcorners = zeros(size(x));

Dx = [1 0 -1; 1 0 -1; 1 0 -1];
Dy = [-1 -1 -1;0 0 0;1 1 1];

x = imgaussfilt(x,s);

Lx = conv2(x,Dx,'same');
Ly = conv2(x,Dy,'same');

Lxx = conv2(imgaussfilt(Lx,s),Dx,'same');
Lyy = conv2(imgaussfilt(Ly,s),Dy,'same');

for i = 1:numel(x)
    lcorners(i)= s^2*abs(Lxx(i)+Lyy(i));
end
end





end

