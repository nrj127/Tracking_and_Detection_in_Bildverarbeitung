I = imread('bb.jpg');
I = rgb2gray(I);
sigma_d =15; sigma_r = 15;
bilateralFiltered = bilateralFilter(I,sigma_d,sigma_r,'mirror');

figure(1)
subplot(1,2,1)
imshow(uint8(I)) % Original
title('Original')

hold on
subplot(1,2,2)
imshow(uint8(bilateralFiltered)) % Median Filtered
title(strcat('Filter = ',num2str(3*sigma_d),'X',num2str(3*sigma_d)))
hold off
