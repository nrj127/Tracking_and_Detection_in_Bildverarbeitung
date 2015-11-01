function [ filteredImage ] = bilateralFilter( I,sigma_d,sigma_r,treatment )

kernel = ones(sigma_d*3);
padded_image = do_padding(I,kernel,treatment);

[kr, kc] = size(kernel);
n_rowsPadded = floor(kr/2);
n_colPadded = floor(kc/2);

[paddedImgR, paddedImgC] = size(padded_image);

domain_filter = zeros(size(kernel));

i = 1;
for row = -floor(kr/2):floor(kr/2)
    j=1;
    for col = -floor(kc/2):floor(kc/2)
        domain_filter(i,j) = exp(-0.5*(sqrt(row.^2+col.^2)/sigma_d).^2);
        j=j+1;
    end
    i=i+1;
end

filteredImage = zeros(paddedImgR-2*n_rowsPadded ,paddedImgC -2*n_colPadded );

for rows = 1 + n_rowsPadded : paddedImgR - n_rowsPadded
    for cols = 1 + n_colPadded : paddedImgC - n_colPadded
        roi = double(padded_image(rows - n_rowsPadded : rows + n_rowsPadded , cols - n_colPadded : cols + n_colPadded));
        pixel = double(padded_image(rows,cols));
        pixel_matrix = repmat(pixel,[kr kc]);
        range_filter = exp(-0.5*(((pixel_matrix-roi)/sigma_r).^2));
        normalizer = sum(sum(domain_filter.*range_filter));
        filteredImage(rows - n_rowsPadded ,cols - n_colPadded) = (sum(sum(roi.*domain_filter.*range_filter)))/normalizer;
    end
end

end