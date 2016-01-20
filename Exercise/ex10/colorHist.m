function [ h ] = colorHist( region )
% region: region from a colored image

    hsv = rgb2hsv(region);
    hue = hsv(:,:,1);
    
    range = 0: (1/256) : 1;
    
    for i=1:256
       
        h(i) = sum(sum( hue>=range(i) & hue<range(i+1)));
        
    end
    bar(h)
    
    %% For debugging
    %h = hist(hue(:), 256);
    %hist(hue(:), 256);

end