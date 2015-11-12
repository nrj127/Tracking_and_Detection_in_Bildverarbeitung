function R  = Harris_function( Image, n, s0, k, alpha)
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    
    Gradient_x = [-1 0 1; -1 0 1; -1 0 1];
    Gradient_y = [-1 -1 -1; 0 0 0; 1 1 1];

    
    dev_in = s0 * k^n; 
    dev_dn = dev_in; %0.7*dev_in

    
    g_dn = gaussian_2d_kernel(dev_dn);
    g_in = gaussian_2d_kernel(dev_in);
    
   
    
    d_x = conv2(Gradient_x, g_dn, 'same');
    d_y = conv2(Gradient_y, g_dn, 'same');

   
    I_x = conv2(double(Image),d_x,'same');
    I_y = conv2(double(Image),d_y,'same');

  
    I_x2 = I_x.^2;
    I_y2 = I_y.^2;
    I_xy = I_x .* I_y;

    g_di = g_in*dev_dn^2;

    
    L_x2 = conv2(I_x2, g_di, 'same');
    L_y2 = conv2(I_y2, g_di, 'same');
    L_xy = conv2(I_xy, g_di, 'same');

    
    R = (L_x2.*L_y2 - L_xy.^2)-alpha*(L_x2+L_y2).^2;

end