
close all
clear all
run('C:/vlfeat/toolbox/vl_setup')

cd images;
fileList = ls('*.png');
cd ..
fileList = strcat('images/',fileList);

%initial pose
R = eye(3);
t = zeros(3,1);

%Intrinsics
A = [472.3 0.64 329.0;
     0 471.0 268.3;
     0 0 1];
 
% setting m and M
I0 = imread('images\0000.png');

if(size(I0,3) >=3)
    I0 = rgb2gray(I0);
end

I0 = single(I0);
[pointsI0, descriptorsI0] = vl_sift(I0);

%2D Homogeneous Coordinates
pointsI0 = pointsI0(1:2 , :);
pointsI0 = [ pointsI0; ones(1, size(pointsI0,2))];

%3D Coordinates
M = inv(A)*pointsI0;

%Array for the location of the camera
camLoc = zeros(3,length(fileList(:,1)));

%Euler Angles parameterization
alpha = 0;
beta = 0;
gamma = 0;


for i = 1:length(fileList(:,1))
    I = imread(fileList(i,:));
    fileList(i,:)
    if(size(I,3) >=3)
        I = rgb2gray(I);
    end
    I = single(I);
    [PointsIi, descriptorsIi] = vl_sift(I);
    
    [matches, scores] = vl_ubcmatch(descriptorsI0, descriptorsIi);

    m0 = pointsI0(:,matches(1, :));
    mi = PointsIi(1:2,matches(2, :));
    mi = [ mi; ones(1, size(mi,2))];

    Mi = M(:,matches(1, :));
    p=0.8; td = 1; tset=70;
    [~, bestPoints] = RANSAC_ADAPTIVE(m0,mi,p,td,tset);

    m0 = m0(:,bestPoints);
    mi = mi(:,bestPoints);
    Mi = Mi(:,bestPoints);
    
    %figure
    %showMatchedFeatures(I0,I,m0(1:2,:)',mi(1:2,:)','montage');
    %title(strcat('matching RANSAC ','I0-I', num2str(i-1)))
    %print(strcat('matches\I0-I', num2str(i-1) ), '-dpng')
    %close all

    % First 3 for rotation (Euler), next 3 for translation.
    params = [ alpha;beta;gamma; t ];
    func = @(params)E(params,A,Mi,mi);
    options = optimset('MaxIter', 10000000000);
    [outParams,value] = fminsearch(func, [ alpha;beta;gamma; t ] , options );
    
    alpha = outParams(1);
    beta = outParams(2);
    gamma = outParams(3);
    RX = [ 1, 0, 0; 0, cos(alpha), sin(alpha); 0, -sin(alpha), cos(alpha)];
    RY = [ cos(beta), 0, -sin(beta); 0,1,0; sin(beta),0,cos(beta)];
    RZ = [ cos(gamma), sin(gamma) , 0; -sin(gamma), cos(gamma) , 0 ; 0 , 0 , 1];
    
    R = RZ * RY * RX;
    t = outParams(4:6);

    camLoc(:,i) = -R'*t;
end

%TODO
figure;
plot3(camLoc(1, :), camLoc(2, :) , camLoc(3,:));
labels = cellstr( num2str([0:44]') );
text(camLoc(1, :), camLoc(2, :),camLoc(3,:), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right');
title('Output Trajectory 3D')
print( 'Trajectory3D' , '-dpng') ;

figure;
plot(camLoc(1, :), camLoc(2, :));
labels = cellstr( num2str([0:44]') );
text(camLoc(1, :), camLoc(2, :), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right');
title('Output Trajectory 2D')
print( 'Trajectory' , '-dpng') ;

