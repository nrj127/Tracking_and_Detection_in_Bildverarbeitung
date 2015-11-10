addpath('helper_functions');

im = imread('sample2.jpg');
[~, ~, numberOfColorChannels] = size(im);
if(numberOfColorChannels ==3)
    im = rgb2gray(im);
end
n = 0;
k = 1.2;
s0 = 1.5;
alpha = 0.04;
threshold = 5e7;
ind = Harris_Detector(im,n,s0,k,alpha,threshold);


figure, imshow(uint8(im));
hold on;
for element = 1:size(ind)
        [x, y] = ind2sub( size(im), ind(element));
        plot(y, x, '.');
end