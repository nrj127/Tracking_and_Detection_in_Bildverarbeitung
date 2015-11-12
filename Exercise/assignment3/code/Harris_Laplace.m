function feature_points = Harris_Laplace( I,s0,k,alpha,threshold_h,threshold_l,n )

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[x y] = size(I);

levels = zeros(x,y,n);
interest_points = zeros(x,y,n);



for level = 1:n
    sigmaI = s0*k^(level-1);
    
    current_level = Harris_function(I,level-1,s0,k,alpha);
    
    interest_points(:, :, level) = nlfilter(current_level, [3 3], @(x) (x(5) > threshold_h && all(x(5) > x([1:4 6:9]))));
    
    laplacian_kernel = fspecial('log', floor(3*sigmaI), sigmaI);
    
    harris_scales_levels(:, :, level) = abs(sigmaI^2 * conv2(double(I), laplacian_kernel, 'same'));
end


roi = find(interest_points>0);

u = size(roi);


for e = 1:size(roi)
    [x, y, z] = ind2sub( size(harris_scales_levels), roi(e));
    
    if(harris_scales_levels(x, y, z) < threshold_l)
        roi(e) = 0;
    end
    
    if ((z-1) > 0)
        if(harris_scales_levels(x, y, z-1) >= harris_scales_levels(x, y, z))
            roi(e) = 0;
        end
    end
    
    if ((z+1) <= n)
        if(harris_scales_levels(x, y, z+1) >= harris_scales_levels(x, y, z))
            roi(e) = 0;
        end
    end
end

roi = roi(roi> 0);

feature_points = zeros(size(roi, 1), 3);

for i = 1:size(roi, 1)
    [x, y, z] = ind2sub( size(harris_scales_levels), roi(i));
    feature_points(i, 1) = x;
    feature_points(i, 2) = y;
    feature_points(i, 3) = s0 * k^(z - 1);
end


end













