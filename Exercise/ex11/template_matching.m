function [  ] = template_matching( type,mode,method,img,rect )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if ( strcmp(type, 'SSD' ) && strcmp(mode, 'Grayscale' ) && strcmp(method , 'Exhaustive') )
   
    template  = img(rect(2):rect(2)+rect(4), rect(1):rect(1)+ rect(3),:);
    imshow(template);

    img = rgb2gray(img);
    template = rgb2gray(template);
    template_size = size(template);

    tic

    result = nlfilter(img, template_size, @(patch) sum(sum( (template - patch).^2 ) ));

    min_element_value = min(min(result));
    [row, col] = ind2sub(size(img), find(result == min_element_value));

    toc

    imshow(img);
    hold on;
    plot(col, row, '+');
end

if ( strcmp(type, 'NCC' ) && strcmp(mode, 'Grayscale' ) && strcmp(method , 'Exhaustive') )
   
    template_top_left_x_y = [255, 330];
    template_bottom_right_x_y = [303, 366];

    template = img(template_top_left_x_y(2):template_bottom_right_x_y(2), template_top_left_x_y(1):template_bottom_right_x_y(1), :);
    imshow(template);

    img = rgb2gray(img);
    template = rgb2gray(template);
    template_size = size(template);

    tic

    result = nlfilter(img, template_size, @(patch) NCC(template, patch));

    largest_element_value = max(max(result));
    [row, col] = ind2sub(size(img), find(result == largest_element_value));

    toc

    imshow(img);
    hold on;
    plot(col, row, 'o');
    
end
    


end
 
      

