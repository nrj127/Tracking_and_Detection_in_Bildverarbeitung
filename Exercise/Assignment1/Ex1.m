% matlab code to find convolution of an image using mean filter
addpath('helper_functions');
I = imread('lena.gif') ; % read image
[rows,columns] = size(I) ;

kernel = ones(9);
kernel = kernel./sum(sum(kernel)); %Normalization
[kr, kc] = size(kernel);

figure(1)

subplot(2,2,[1 2])
imshow(I)
title('Original image');

convoluted_image = convolution(I,kernel,'mirror');
imwrite(uint8(convoluted_image) , strcat('convolved_img_mirror.jpg'));
%figure(1)
subplot(2,2,3)
imshow(uint8(convoluted_image))
title(' Mirror treatment')

convoluted_image = convolution(I,kernel,'border');
imwrite(uint8(convoluted_image) , strcat('convolved_img_border.jpg'));
%figure(2)
subplot(2,2,4)
imshow(uint8(convoluted_image));
title('Border treatment')
suptitle('mean filter 3x3')

