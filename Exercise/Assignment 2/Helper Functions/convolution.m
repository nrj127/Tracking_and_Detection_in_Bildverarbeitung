function [ convoluted_image ] = convolution( I,kernel, border_treatment )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

padded_image = do_padding(I,kernel,border_treatment);

[kr, kc] = size(kernel);
n_rowsPadded = floor(kr/2);
n_colPadded = floor(kc/2);
%kernel = kernel'
%kernel = kernel(:);
%kernel = [kernel(1,:)';kernel(2,:)';kernel(3,:)']
[paddedImgR, paddedImgC] = size(padded_image);

convResult = zeros(paddedImgR-2*n_rowsPadded ,paddedImgC -2*n_colPadded );

for rows = 1 + n_rowsPadded : paddedImgR - n_rowsPadded
    for cols = 1 + n_colPadded : paddedImgC - n_colPadded
        roi = double(padded_image(rows - n_rowsPadded : rows + n_rowsPadded , cols - n_colPadded : cols + n_colPadded));
        sumconv = kernel.*roi;
        sumconv = sum(sumconv(:));
        convResult(rows - n_rowsPadded ,cols - n_colPadded) = sumconv;
    end
end

convoluted_image = convResult;


