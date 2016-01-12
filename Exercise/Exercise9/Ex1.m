
clear all;
close all;
img = imread('data/seq/im000.pgm');

randomRange = [-30, 30];
topLeft = [152, 106];
bottomRight = [508, 464];

% random transformation function example
%[ original_intensities, warped_intensities, displacement_vector ] = randomTransform( img, randomRange, topLeft, bottomRight );

n = 10000;
A = learnTracker( img, randomRange, topLeft, bottomRight , n );