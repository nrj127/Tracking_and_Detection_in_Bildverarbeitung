
clear all;
close all;
img = imread('data/seq/im000.pgm');
A = cell(1,10);
topLeft = [152, 106];
bottomRight = [508, 464];

for i = 1:10
randomRange = [-30 + 2.5*i, 30 - 2.5*i];

% random transformation function example
%[ original_intensities, warped_intensities, displacement_vector ] = randomTransform( img, randomRange, topLeft, bottomRight );

n = 10000;
A{i} = learnTracker( img, randomRange, topLeft, bottomRight , n );
end

save A.mat A;
