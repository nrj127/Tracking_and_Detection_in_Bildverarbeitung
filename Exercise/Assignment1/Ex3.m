I = imread('lena.gif');

% Creating the derivative filters
radius = 3;
range = -floor(radius/2):floor(radius/2);
[dX,dY] = meshgrid(range,range);

%Computing the gradients by convolution with these filters.

dX_I = convolution(I,dX,'mirror');
imwrite(uint8(dX_I),'x-derivative.png');
dY_I = convolution(I,dY,'mirror');
imwrite(uint8(dY_I),'y-derivative.png');

%Computing gradient magnitude and orientation
grad_I = (dX_I.^2 + dY_I.^2 ).^0.5;
orientation = atan(dY_I./dX_I);
imwrite(uint8(grad_I),'grad_magnitude.png');
imwrite(uint8(orientation*128),'orientation.png');

% Part 3

sigma = 1;
gauss = Gaussian2D(sigma);

mask = convolution(gauss,dX,'mirror');
IX = convolution(I,mask,'mirror');
mask = convolution(gauss,dY,'mirror');
IY = convolution(I,mask,'mirror');

figure(1)
imshow(IX)
title('Gradient X')
figure(2)
imshow(IY)
title('Gradient Y')
