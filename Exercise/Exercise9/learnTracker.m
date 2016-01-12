function [ A ] = learnTracker( img, randomRange, topLeft, bottomRight, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%range for random noise
a = -0.001;
b = 0.001;

P = [];
I =[];


    for i = 1:n  
    
        [ I, Iw, displacement_vector ] = randomTransform( img, randomRange, topLeft, bottomRight );
    
        % normalize warped intensities
        Iw = Normalise(Iw);
        % Add random noise to the warped image
        rand_noise = (b-a).*rand(size(Iw,1), 1) + a;
        Iw = Iw + rand_noise;
        
        % normalize original template intensities
        I = Normalise(I);
        
        %calculate normalized differences
        diffI = Iw - I;
        
        %add columns
        I = [I diffI];
        
        P = [P displacement_vector];
        
    
    end
    
    size(P)
    size(I)
    
    %Compute Matrix A
    A = (P * I') / (I * I');



end