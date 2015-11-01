function [ filteredImage ] = bilateralFilter( I,kernel,sigmad,sigmar )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
padded_image = do_padding(I,kernel,'border');

%[kr, kc] = size(kernel);
kr = kernel(1);
kc = kernel(2);
n_rowsPadded = floor(kr/2);
n_colPadded = floor(kc/2);


[paddedImgR, paddedImgC] = size(padded_image);

convResult = zeros(paddedImgR-2*n_rowsPadded ,paddedImgC -2*n_colPadded );


domain_filter = zeros(size(kernel));

i = 1;

for row = -floor(kr/2):floor(kr/2)
    j=1;
    for col = -floor(kc/2):floor(kc/2)
        domain_filter(i,j) = exp(-0.5*(sqrt(row.^2+col.^2)/sigmad).^2);
        j=j+1;
    end
    i=i+1;
end



for rows = 1 + n_rowsPadded : paddedImgR - n_rowsPadded
    for cols = 1 + n_colPadded : paddedImgC - n_colPadded
        roi = double(padded_image(rows - n_rowsPadded : rows + n_rowsPadded , cols - n_colPadded : cols + n_colPadded));
        value = double(padded_image(rows,cols));
        value1 = repmat(value,[kr kc]);
        rangeKernel = exp((-0.5*((value1-roi)/sigmar).^2) );
        convResult(rows - n_rowsPadded ,cols - n_colPadded) = sum(sum(rangeKernel.* domain_filter.*roi)) * 1/sum(sum(rangeKernel.*domain_filter));
    end
end

filteredImage = convResult;
end