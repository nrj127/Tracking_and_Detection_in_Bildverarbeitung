function [ image ] = AddGaussianNoise( input_image , deviation) 

    noise = normrnd(0, deviation, size(input_image));
    image = double(input_image) + noise;
    
end
