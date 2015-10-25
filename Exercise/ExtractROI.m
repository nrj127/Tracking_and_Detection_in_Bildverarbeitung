function [ tempConv ] = ExtractROI(roi )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


tempConv(3,3) = 0;

for i = 1:3
    for j= 1:3
        tempConv(i,j) = roi(i,j);
    end
end
    
tempConv = [tempConv(1,:)';tempConv(2,:)';tempConv(3,:)'];



end

