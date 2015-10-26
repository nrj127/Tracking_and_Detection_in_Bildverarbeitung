%sigma = 3; % try with 3 also
I = imread('lena.gif');

[rows columns] = size(I);

mask = Gaussian2D(1); % sigma
convoluted_image = convolution(I,mask,'mirror');
figure(13)
subplot(3,2,1)
imshow(uint8(convoluted_image)) % convoluted_image*15
title('2D Gaussian;sigma = 1')
hold on


twodsigma1 = convoluted_image;

% 2D Gaussian; sigma = 3

mask = Gaussian2D(3);
convoluted_image = convolution(I,mask,'mirror');
subplot(3,2,2)
imshow(uint8(convoluted_image)) %*128
title('2D Gaussian;sigma = 3')

twodsigma3 = convoluted_image;

kernelyDirection = GaussianSeparate([1 3*1],1,'yDirection');
kernelxDirection = GaussianSeparate([3*1 1],1,'xDirection');

tic
convoluted_image_temp = convolution(I,kernelxDirection,'mirror');
%convoluted_image_temp= do_padding(convoluted_image_temp,kernelyDirection,'mirror');
convoluted_image_final = convolution(convoluted_image_temp, kernelyDirection,'mirror');
toc

subplot(3,2,3)
imshow(uint8(convoluted_image_final)) %*15
title('2x 1D Gaussians;sigma=1')

onedsigma1 = convoluted_image_final;
% sigma = 3

kernelyDirection = GaussianSeparate([1 3*3],3,'yDirection');
kernelxDirection = GaussianSeparate([3*3 1],3,'xDirection');

tic
convoluted_image_temp = convolution(I,kernelxDirection,'mirror');
%convoluted_image_temp= do_padding(convoluted_image_temp,kernelyDirection,'border');
convoluted_image_final = convolution(convoluted_image_temp, kernelyDirection,'mirror');
toc

onedsigma3 = convoluted_image_final;

subplot(3,2,4)
imshow(uint8(convoluted_image_final)) %*128
title('2x 1D Gaussians;sigma=3')

resultsigma1 = sqrt((onedsigma1 - twodsigma1).^2);
resultsigma3 = sqrt((onedsigma3 - twodsigma3).^2);
%resultsigma1 = sum(sum(resultsigma1));

figure(26)
imshow(uint8(resultsigma1), [min(uint8(resultsigma1(:)))  max(uint8(resultsigma1(:)))]) 

figure(27)
imshow(uint8(resultsigma3), [min(uint8(resultsigma3(:)))  max(uint8(resultsigma3(:)))])