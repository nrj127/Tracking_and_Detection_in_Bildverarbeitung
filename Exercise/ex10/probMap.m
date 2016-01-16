function [ prob ] = probMap( region, h )

    
    hsv = rgb2hsv(region);
    ind = round(hsv(:,:,1).*255)+1;
    prob = h(ind);
    
    maximum = max(max(prob));
    prob = round(prob .* (255/maximum));

end
