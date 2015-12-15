
close all
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
[m, d0] = vl_sift(I0);

%2D Homogeneous Coordinates
m = m(1:2 , :);
m = [ m; ones(1, size(m,2))];

%3D Coordinates
M = inv(A)*m;

%Array for the location of the camera
camLoc = zeros(3,length(fileList(:,1)));

for i = 1:length(fileList(:,1))
    I = imread(fileList(i,:));
    if(size(I,3) >=3)
        I = rgb2gray(I);
    end
    I = single(I);
    [f, d] = vl_sift(I);
    
    [matches, scores] = vl_ubcmatch(d0, d);

    X1 = m(:,matches(1, :));
    mi = f(1:2,matches(2, :));
    mi = [ mi; ones(1, size(mi,2))];
    Mi = M(:,matches(1, :));
    p=0.8; td = 1; tset=70;
    H = RANSAC_ADAPTIVE(X1,mi,p,td,tset);

    figure
    showMatchedFeatures(I0,I,X1(1:2,:)',mi(1:2,:)','montage');
    title(strcat('matching RANSAC ','I0-I', num2str(i)))
    print(strcat('matches\I0-I', num2str(i) ), '-dpng')
    close all

    %x0 = zeros(size([R,t]));
    inputs = [R,t];
    func = @(inputs) E(inputs(:,1:3),inputs(:,4),A,Mi,mi);
    [x,value] = fminsearch(func, [R,t] );
    R = x(:, 1:3);
    t = x(:,4);
    
    camLoc(:,i) = -R'*t;
end

%TODO
figure;
plot3(camLoc(1,:),camLoc(2,:),camLoc(3,:))
title('Output Trajectory')
print( 'Trajectory' , '-dpng') ;
