addpath('helper_functions');

%im = imread('sample2.jpg');
%im = imread('checkerboard_tunnel.png');
im = imread('test.pgm');
[~, ~, numberOfColorChannels] = size(im);
if(numberOfColorChannels ==3)
    im = rgb2gray(im);
end


s0 = 0.7;
k = 1.4;
alpha = 0.04;

%n = [0 7 17];

n = 7;

   % th =  10000000; %10000
   % tl = 50  ;   %10
    th = 1000;
    tl = 10;
   f = Harris_Laplace(im,s0,k,alpha,th,tl,n)

   clc;close all;
   figure,imshow(im);
   hold on;
   
   for i = 1:size(f,1)
       circle_size = s0 * k^(f(i,3)) * 6;
       plot(f(i, 2), f(i, 1), 'o', 'MarkerSize', circle_size);
       
   end



 