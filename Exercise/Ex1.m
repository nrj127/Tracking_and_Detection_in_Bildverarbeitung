% matlab code to find convolution of an image using mean filter

I = imread('lena.gif') ; % read image
[rows,columns] = size(I) ;

kernel = ones(11);
[kr, kc] = size(kernel);

figure(3)
imshow(I)


convoluted_image = convolution(I,kernel,'mirror');
imwrite(uint8(convoluted_image) , strcat('convolved_img_mirror.jpg'));
figure(1)
imshow(uint8(convoluted_image))
title('Mean Filter with Mirror treatment')

convoluted_image = convolution(I,kernel,'border');
imwrite(uint8(convoluted_image) , strcat('convolved_img_border.jpg'));
figure(2)
imshow(uint8(convoluted_image));
title('Mean Filter with Border treatment')
