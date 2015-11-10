I = imread('sample2.jpg');

%I = imread('test.pgm');
I = rgb2gray(I);
Harris_Detector(I,0,1.5,1.2,0.06,10);