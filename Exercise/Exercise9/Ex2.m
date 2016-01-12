
img = imread('data/seq/im000.pgm');

[w, h] = size(img);
n_images = 200;


frames = zeros(w, h, n_images );
for i = 1 : n_images
    
    img_name = sprintf('data/seq/im%03d.pgm', i);
    frames(:,:,i) = imread(img_name) ;
end

% Get initial rectangle coordinates
topLeft = [152, 106];
bottomRight = [508, 464];
topRight = [bottomRight(1), topLeft(2)];
bottomLeft = [topLeft(1), bottomRight(2)];

% Get homogenous rectangle coordinates
rectangle_coords = [topLeft; topRight; bottomLeft; bottomRight];
coords = [rectangle_coords'; ones(1, size(rectangle_coords, 1))];

% Load set of trained matrices
load('A.mat');


x_span = topLeft(1):5:topRight(1);
y_span = topRight(2):5:bottomRight(2);


% Include last row and column into the grid
if x_span(end) ~= topRight(1)
    x_span(end + 1) = topRight(1);
end
    
if y_span(end) ~= bottomRight(2)
    y_span(end + 1) = bottomRight(2);
end


% Get the coordinates of all the grid points
[x, y] = meshgrid(x_span, y_span);

grid_coords = [x(:) y(:)];

grid_coords = [ grid_coords'; ones(1, size(grid_coords, 1))];


% Initial coords and current. At the begining they are the same.
current_parameter = coords;
initial_parameter = coords;

gridpoints = grid_coords;

current_homography = [1 0 0; 0 1 0 ;0 0 1];

original_intensities = [];
current_frame = frames(:,:,1);


for j = 1 : size(gridpoints, 2)
    
   original_intensities = [original_intensities; double(img( round(gridpoints(2,j)), round(gridpoints(1,j)) )) ];
end

original_intensities = Normalise(original_intensities);


% for each frame
for n = 1:n_images
    
    
    current_frame = frames(:,:,n);
    
    n

    %multiplying by the same matrix to get better estimation of the
    %parameter - 5 because it is adviced in the exercise
    
    for i = 1:10 %size(cell)
        
        current_A = A{i};
        
        for mult = 1 : 5


            current_homography = DLT(initial_parameter, current_parameter);

            gridpositions = current_homography * gridpoints ;  %to warp according to the current parameters
            gridpositions = gridpositions ./ repmat( gridpositions(3,:), 3, 1 );

            I = [];

           % Extract image
           for j = 1 : size(gridpositions, 2)

               x = min(   max(round(gridpositions(2,j))  ,1)  ,w);
               y = min(   max(round(gridpositions(1,j))  ,1)  ,h);

                I = [I; current_frame(x, y ) ];

           end

            I = Normalise(I);  

            diff = I - original_intensities;

            P = current_A * diff;

            %get P & coords into homogenous coordinate form

            P1 = P(1:4,1);
            P2 = P(5:8,1);
            newP = [P1 P2 ones(4,1)];

            newP';

            newP = current_parameter + newP' - [zeros(4, 1) zeros(4, 1) ones(4,1)]';


            update_homography = DLT(current_parameter, newP);


            new_homography = current_homography * update_homography;
            
            new_parameter = new_homography * initial_parameter;
            new_parameter = new_parameter ./ repmat( new_parameter(3,:), 3, 1 );

            current_parameter = new_parameter;


        end
    end
    
    image_handler = imshow(uint8(current_frame));
    hold on;
    plot(current_parameter(1,:), current_parameter(2,:), 'r*');
    saveas(image_handler, sprintf('results/%03d.jpg', n));
    close all;
    
    initial_parameter = current_parameter;
    gridpoints = gridpositions;
end


% plot and see if it works
% image_handler = imshow(uint8(current_frame));
% hold on;
% plot(current_parameter(1,:), current_parameter(2,:), 'r*');
% saveas(image_handler, sprintf('result_images/%d.jpg', i));