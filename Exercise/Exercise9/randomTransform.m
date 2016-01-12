function [ original_intensities, warped_intensities, displacement_vector ] = randomTransform( img, randomRange, topLeft, bottomRight )
    
    %% Extract rectangle coordinates
    topRight = [bottomRight(1), topLeft(2)];
    bottomLeft = [topLeft(1), bottomRight(2)];
    rectangle_coords = [topLeft; topRight; bottomLeft; bottomRight];

    %% Randomly find new rectangle coordinates
    x_y_random_value_length = randomRange(2) - randomRange(1);
    rectangle_random_values = rand(4, 2)* x_y_random_value_length + randomRange(1);
    rectangle_new_coords = rectangle_coords + rectangle_random_values;
    
    % Homogeneous coordinates
    rectangle_coords = [rectangle_coords'; ones(1, size(rectangle_coords, 1))];
    rectangle_new_coords = [rectangle_new_coords'; ones(1, size(rectangle_new_coords, 1))];

    H = DLT(rectangle_coords, rectangle_new_coords);

    %% Making a grid at every 5 pixels
    x_span = topLeft(1):5:topRight(1);
    y_span = topRight(2):5:bottomRight(2);
    
    % Add last elements in case they are not divided by 5
    if x_span(end) ~= topRight(1)
        x_span(end + 1) = topRight(1);
    end
    if y_span(end) ~= bottomRight(2)
        y_span(end + 1) = bottomRight(2);
    end
        
    [x, y] = meshgrid(x_span, y_span);

    grid_coords = [x(:) y(:)];
    grid_coords = [ grid_coords'; ones(1, size(grid_coords, 1))];

    %% Back Warping the coordinates
    
    back_warp_coords = inv(H)*grid_coords;
    back_warp_coords = back_warp_coords ./ repmat( back_warp_coords(3,:), 3, 1 );
    
    n_elements = numel(x);

    original_intensities = zeros(n_elements, 1);
    warped_intensities = zeros(n_elements, 1);

    for coordinate = 1:n_elements

        original_intensities(coordinate) =  img(round(grid_coords(2, coordinate)), round(grid_coords(1, coordinate)));
        warped_intensities(coordinate) =  img(round(back_warp_coords(2, coordinate)), round(back_warp_coords(1, coordinate)));
    end

    displacement_vector = reshape(rectangle_random_values, [], 1);

end

