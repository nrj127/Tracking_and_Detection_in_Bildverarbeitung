addpath('helper_functions');

sigma = 1; % try with 3 also
I = double(imread('lena.gif'));

[rows, columns] = size(I);

mask = Gaussian2D(sigma); % sigma
tic
convoluted_image1 = convolution(I,mask,'mirror');
toc
figure(1)
subplot(1,2,1)
imshow(uint8(I)) % Original Image
title('Original')
hold on
subplot(1,2,2)
imshow(uint8(convoluted_image1)) % Original Image

title(strcat('2D Gaussian sigma = ',num2str(sigma)))
hold off


% 2D Gaussian; sigma = 3
sigma = 3;
mask = Gaussian2D(sigma);
tic 
convoluted_image2 = convolution(I,mask,'mirror');
toc
figure(2)
subplot(1,2,1)
imshow(uint8(I)) %Original Image
title('Original')
hold on
subplot(1,2,2)
imshow(uint8(convoluted_image2)) % Original Image

title(strcat('2D Gaussian sigma = ',num2str(sigma)))
hold off

%%%%%%%%%%%%%%%%%%%%%% SEPARABLE FILTERS IMPLEMENTATION %%%%%%%%%%%%%%%

kernelyDirection = GaussianSeparate([1 3*1],1,'yDirection');
kernelxDirection = GaussianSeparate([3*1 1],1,'xDirection');

tic
convoluted_image_temp = convolution(I,kernelxDirection,'mirror');
convoluted_image_final3 = convolution(convoluted_image_temp, kernelyDirection,'mirror');
toc

figure(3)
subplot(1,2,1)
imshow(uint8(I)) %Original Image
title('Original')
hold on
subplot(1,2,2)
imshow(uint8(convoluted_image_final3)) % Original Image

title(strcat('2 X 1D Gaussian sigma = 1'))
hold off

% sigma = 3

kernelyDirection = GaussianSeparate([1 3*3],3,'yDirection');
kernelxDirection = GaussianSeparate([3*3 1],3,'xDirection');

tic
convoluted_image_temp = convolution(I,kernelxDirection,'mirror');
convoluted_image_final4 = convolution(convoluted_image_temp, kernelyDirection,'mirror');
toc

figure(4)
subplot(1,2,1)
imshow(uint8(I)) %Original Image
title('Original')
hold on
subplot(1,2,2)
imshow(uint8(convoluted_image_final4)) % Original Image

title(strcat('2 X 1D Gaussian sigma = 3'))
hold off
error1 = (convoluted_image1 - convoluted_image_final).^2;
error3 = (convoluted_image2 - convoluted_image_final4).^2;

%error1 = sum(error1(:))
%error3 = sum(error3(:))