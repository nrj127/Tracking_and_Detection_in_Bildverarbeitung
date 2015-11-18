function [ ind ] = Harris_Detector(I,n,s0,k,alpha,threshold )

sigma_in = k^n*s0;
sigma_dn = sigma_in;

%[rows, columns]  = size(I);

%%%% Calculations for the second moment matrix %%%%%%
%1. Creating the gaussian Kernals
g_dn = fspecial('gaussian',[round(3*sigma_dn),round(3*sigma_dn)],sigma_dn); 
g_in = fspecial('gaussian',[round(3*sigma_in),round(3*sigma_in)],sigma_in); 

%2. Smoothning with the gaussian kernal
I_g_dn = imfilter(I, g_dn);

%3. Getting the gradient of the smoothened image
[Lx_sigma_dn, Ly_sigma_dn] = imgradientxy(I_g_dn);

%4. Computing the structure tensor
L_x2_sigma_dn = Lx_sigma_dn.^2;
L_y2_sigma_dn = Ly_sigma_dn.^2;
LxLy = Lx_sigma_dn.*Ly_sigma_dn;

m11 = imfilter(L_x2_sigma_dn, g_in);
m22 = imfilter(L_y2_sigma_dn, g_in);
m12 = imfilter(LxLy, g_in);
m21 = imfilter(LxLy, g_in);

R = (m11.*m22 - m21.*m12) - alpha*((m11+m22).^2);

ind = find(R<=threshold);
R(ind) = 0;

% Find local maximum
%R = nlfilter(R, [5 5], @(x) all(x(13) > x([1:12 14:25])) );
R = nlfilter(R, [5 5], @(x) all(x(13) > x([1:12 14:25])) );

ind = find(R == 1);



