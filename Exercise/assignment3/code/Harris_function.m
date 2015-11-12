function R  = Harris_function( Image, n, s0, k, alpha)
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here

    Gradient_x = [-1 0 1; -1 0 1; -1 0 1];
    Gradient_y = [-1 -1 -1; 0 0 0; 1 1 1];

    %formulas given in the execise sheet
    dev_in = s0 * k^n; 
    dev_dn = 0.76 * dev_in;

    %acquiring guassian kernels
    g_dn = gaussian_2d_kernel(dev_dn);
    g_in = gaussian_2d_kernel(dev_in);
    
    %     g_dn = fspecial('gaussian', floor(6*dev_dn+1), dev_dn);
    %     g_in = fspecial('gaussian', floor(6*dev_in+1), dev_in);
    
    %smoothing with differential gaussian before applying gradients
    d_x = conv2(Gradient_x, g_dn, 'same');
    d_y = conv2(Gradient_y, g_dn, 'same');

    %Applying Gradients to the image
    I_x = conv2(double(Image),d_x,'same');
    I_y = conv2(double(Image),d_y,'same');

    %calculating values for the matrix M
    I_x2 = I_x.^2;
    I_y2 = I_y.^2;
    I_xy = I_x .* I_y;

    g_di = g_in*dev_dn^2;

    %appplying integral gaussian
    L_x2 = conv2(I_x2, g_di, 'same');
    L_y2 = conv2(I_y2, g_di, 'same');
    L_xy = conv2(I_xy, g_di, 'same');

    %applying the formula provided in the exercise sheet
    
    R = (L_x2.*L_y2 - L_xy.^2)-alpha*(L_x2+L_y2).^2;

end