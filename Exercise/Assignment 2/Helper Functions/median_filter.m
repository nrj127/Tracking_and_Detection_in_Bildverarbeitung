function [ output ] = median_filter(I,roi_size, border_treatment)

kernel = ones(roi_size);
padded_image = do_padding(I,kernel,border_treatment);

[kr, kc] = size(kernel);
n_rowsPadded = floor(kr/2);
n_colPadded = floor(kc/2);

[paddedImgR, paddedImgC] = size(padded_image);

output = zeros(paddedImgR-2*n_rowsPadded ,paddedImgC -2*n_colPadded );

    for rows = 1 + n_rowsPadded : paddedImgR - n_rowsPadded
        for cols = 1 + n_colPadded : paddedImgC - n_colPadded
            roi = double(padded_image(rows - n_rowsPadded : rows + n_rowsPadded , cols - n_colPadded : cols + n_colPadded));
            pixelValue = median(sort(roi(:)));
            output(rows - n_rowsPadded ,cols - n_colPadded) = pixelValue;
        end
    end
end