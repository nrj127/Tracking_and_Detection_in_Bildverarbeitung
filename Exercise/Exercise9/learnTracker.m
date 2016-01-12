function [ MatrixA ] = learning( img, x_y_random_value_range, topLeft, bottmRight, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%range for random noise
a = -0.001;
b = 0.001;

MatrixP = [];
MatrixI =[];


    for i = 1:n  
    
        [ I, Iw, displacement_vector ] = randomTransform( img, x_y_random_value_range, topLeft, bottmRight );

        % normalize warped intensities
        Iw = Normalise(Iw);
        rand_noise = (b-a).*rand(size(Iw,1), 1) + a;
        Iw = Iw + rand_noise;

        % normalize original template intensities
        I = Normalise(I);
        %calculate normalized differences
        diffI = Iw - I;
        
        %add columns
        MatrixI = [MatrixI diffI];
        MatrixP = [MatrixP displacement_vector];
    end
    
    size(MatrixP)
    size(MatrixI)
    
    %Compute Matrix A
    MatrixA = (MatrixP * MatrixI') / (MatrixI * MatrixI');



end