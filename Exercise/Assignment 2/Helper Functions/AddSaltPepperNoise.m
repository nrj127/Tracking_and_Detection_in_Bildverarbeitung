function [ result ] = AddSaltPepperNoise( input_image , amount_corruption) 

        result = input_image;
        n_pixels = size(input_image(:));
        n_pixels = n_pixels(1,1);
		random_index = randperm(n_pixels(1));
		n_corroupted = floor(n_pixels*amount_corruption/100);
		result(random_index(1:n_corroupted)) = 0;

        n_saltPixels = floor(n_corroupted / 2);
		result(random_index(1:n_saltPixels)) = 255;

end
