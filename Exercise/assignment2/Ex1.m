addpath('Helper Functions');
I = rgb2gray(imread('bb.jpg')) ; % read image
[rows,columns] = size(I) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Salt-Pepper Noise , Median Filter%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spNoisyImage = AddSaltPepperNoise(I , 10);
roi_size = 5;
medianFiltered = median_filter(spNoisyImage,roi_size,'mirror');

figure(1)
subplot(1,2,1)
imshow(uint8(spNoisyImage)) % Salt and Pepper Noisy
title('Salt and Pepper Noisy')

hold on
subplot(1,2,2)
imshow(uint8(medianFiltered)) % Median Filtered
title(strcat('Median Filter = ',num2str(roi_size),'X',num2str(roi_size)))
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gaussian Noise , Gaussian Filter%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigma = 3;
gaussNoisyImage = AddGaussianNoise(I,32); %AddGaussianNoise( input_image , deviation)
filter = Gaussian2D(sigma);
gaussFiltered = convolution(gaussNoisyImage,filter,'mirror');

figure(2)
subplot(1,2,1)
imshow(uint8(gaussNoisyImage)) % Gaussian Noisy
title('Gaussian Noisy')

hold on
subplot(1,2,2)
imshow(uint8(gaussFiltered)) % Gaussian Filtered
title(strcat('Gaussian Filter = ',num2str(sigma),'X',num2str(sigma)))
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gaussian Noise , Median Filter%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gaussNoisyImage = AddGaussianNoise(I,32); %AddGaussianNoise( input_image , deviation)
roi_size = 5;
medianFiltered = median_filter(gaussNoisyImage,roi_size,'mirror');

figure(3)
subplot(1,2,1)
imshow(uint8(gaussNoisyImage)) % Gaussian Noisy
title('Gaussian Noisy')

hold on
subplot(1,2,2)
imshow(uint8(medianFiltered)) % Median Filtered
title(strcat('Median Filter = ',num2str(roi_size),'X',num2str(roi_size)))
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Salt Pepper Noise , Gaussian Filter%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigma = 3;
spNoisyImage = AddSaltPepperNoise(I , 10);
filter = Gaussian2D(sigma);
gaussFiltered = convolution(spNoisyImage,filter,'mirror');

figure(4)
subplot(1,2,1)
imshow(uint8(spNoisyImage)) % SP Noisy
title('Salt Pepper Noisy')

hold on
subplot(1,2,2)
imshow(uint8(gaussFiltered)) % Gaussian Filtered
title(strcat('Gaussian Filter = ',num2str(sigma),'X',num2str(sigma)))
hold off

