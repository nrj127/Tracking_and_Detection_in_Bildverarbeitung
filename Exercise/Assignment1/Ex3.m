addpath('helper_functions');
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
orientation = atan(double(dY_I./dX_I));
imwrite(uint8(grad_I),'grad_magnitude.png');
imwrite(orientation,'orientation.png');

figure(10)
subplot(2,2,1)
imshow(uint8(dX_I))
title('Gradient X')
subplot(2,2,2)
imshow(uint8(dY_I))
title('Gradient Y')
subplot(2,2,3)
imshow(uint8(grad_I))
title('Magnitude')
subplot(2,2,4)
imshow(orientation)
title('Orientation')

suptitle('Ex3')
 
