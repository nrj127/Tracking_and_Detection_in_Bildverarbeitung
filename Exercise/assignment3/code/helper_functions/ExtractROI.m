function [ tempConv ] = ExtractROI(roi )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[roiR roiC] = size(roi);
tempConv(roiR,roiC) = 0;

for i = 1:roiR
    for j= 1:roiC
        tempConv(i,j) = roi(i,j);
    end
end
    
%tempConv = [tempConv(1,:)';tempConv(2,:)';tempConv(3,:)'];
tempConv = tempConv';
tempConv = tempConv(:);


end

