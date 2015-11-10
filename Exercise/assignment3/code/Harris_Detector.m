function [ output_args ] = Harris_Detector(I,n,so,k,alpha,t )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

sn = k^n*so;
s = sn;

%I = double(I);
rows = size(I,1);
columns = size(I,2);

% creating the derivative filters
radius = 3;
range = -floor(radius/2):floor(radius/2);
[dX dY] = meshgrid(range,range);

gaussian_kernel_dn = Gaussian2D(s);
gaussian_kernel_in = Gaussian2D(sn);

%G_x = conv2(dX,gaussian_kernel_dn,'same');
%G_y = conv2(dY,gaussian_kernel_dn,'same');
%I_x = conv2(G_x,double(I),'same');
%I_y = conv2(G_y,double(I),'same');

G_x = conv2(dX,gaussian_kernel_dn,'same');
G_y = conv2(dY,gaussian_kernel_dn,'same');
I_x = conv2(double(I),(G_x),'same');
I_y = conv2(double(I),(G_y),'same');


L_x2 = I_x.^2;
L_y2 = I_y.^2;
LxLy = I_x.*I_y;


L_matrix = [L_x2 LxLy;LxLy L_y2];

temp = s^2*gaussian_kernel_in;

M = conv2(L_matrix,temp,'same');
%det_M = det(M);
%trace_M = trace(M);

%R = det_M - alpha*(trace_M.^2);

R = (L_x2.*L_y2 - LxLy.^2) - alpha*(L_x2+L_y2).^2;



for x = 1:rows
    for y = 1:columns
        if (R>t)
            I(x,y) = R;
        end
    end
end

result = I > imdilate(I, [1 1 1;1 0 1; 1 1 1]);
figure, imshow(I);
figure , imagesc(result);
end

