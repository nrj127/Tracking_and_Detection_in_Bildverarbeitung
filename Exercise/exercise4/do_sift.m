function [ output_args ] = do_sift(object_image,test_image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



%object_image = imread(object_image);
object_image = imresize(object_image,1);
object_image = single(rgb2gray(object_image));


[f1,d1] = vl_sift(object_image);
figure(1);
imshow(object_image/255);
visualize(f1,d1,50);
title('object image 1')

test_image = imresize(test_image,1);
test_image = single(rgb2gray(test_image));
[f2,d2] = vl_sift(test_image);

figure(2);
imshow(test_image/255);
visualize(f2,d2,50);
title('test image ');

[matches,scores] = vl_ubcmatch(d1,d2);

X1 = f1(1:2,matches(1,:))'; %X1(3,:) = 1;
X2 = f2(1:2,matches(2,:))'; %X2(3,:) = 1;

figure(2)
showMatchedFeatures(test_image,object_image,X2,X1,'montage');


[~,inlier_obj, inlier_test]= estimateGeometricTransform(X1,X2,'similarity');
figure(3)
showMatchedFeatures(test_image,object_image,inlier_test,inlier_obj,'montage');



end

