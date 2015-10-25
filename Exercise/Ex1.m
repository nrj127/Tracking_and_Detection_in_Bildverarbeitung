% matlab code to find convolution of an image using mean filter

I = imread('lena.gif') ; % read image
[rows,columns] = size(I) ;

kernel = ones(3)/9;

[kr kc] = size(kernel);

padded_image = do_padding(I,kernel,'mirror');

convoluted_image = convolution(padded_image,kernel);