sigma = 3; % try with 3 also
I = imread('lena.gif');

[rows columns] = size(I);

mask = Gaussian2D(sigma);
convoluted_image = convolution(I,mask,'border');

figure(3)
imshow(I)
title('Original Image')

figure(4)
imshow(uint8(convoluted_image*128))
title('convoluted image with 2D Gaussian Kernel')

kernelyDirection = GaussianSeparate(sigma,'yDirection');
kernelxDirection = GaussianSeparate(sigma,'xDirection');

tic
convoluted_image_temp = convolution(padded_image,kernelxDirection);
convoluted_image_temp= do_padding(convoluted_image_temp,kernelyDirection,'border');
convoluted_image_final = convolution(convoluted_image_temp, kernelyDirection);
toc

figure(16)
imshow(uint8(convoluted_image_final))
title('convoluted image with 1D Gaussian')