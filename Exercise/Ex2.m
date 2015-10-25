sigma = 3; % try with 3 also
I = imread('lena.gif');

[rows columns] = size(I);


%radius = ceil(3*sigma)
%width  = 2*radius+1;
%height = 2*radius+1;

mask = Gaussian2D(sigma);
padded_image = do_padding(I,mask,'border');
convoluted_image = convolution(padded_image,mask);


figure(3)
imshow(I)
title('Original Image')

figure(4)
imshow(uint8(convoluted_image))
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