function [ convoluted_image ] = convolution( padded_image,kernel )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sumconv = 0;

[kr kc] = size(kernel);

%kernel = kernel'
%kernel = kernel(:);
%kernel = [kernel(1,:)';kernel(2,:)';kernel(3,:)']

for rows = 1:512
    for cols = 1:512
     tempConv =   ExtractROI(padded_image(rows:rows+2*floor(kr/2),cols:cols+2*floor(kc/2)));
      for k = 1:kr
       sumconv = sumconv+ (tempConv(k) * kernel(k));
      end
      convResult(rows,cols) = floor(sumconv);
      sumconv = 0;
    end
end

convoluted_image = convResult;


