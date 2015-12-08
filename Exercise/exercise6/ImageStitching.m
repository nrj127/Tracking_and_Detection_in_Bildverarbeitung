
run('C:/vlfeat/toolbox/vl_setup')

im1 = imread('box.pgm');
im2 = imread('scene.pgm');

if(size(im1,3) >=3)
    im1 = rgb2gray(im1);
end
if(size(im1,3) >=3)
    im2 = rgb2gray(im2);
end

im1 = single(im1);
im2 = single(im2);

[f1, d1] = vl_sift(im1);
[f2, d2] = vl_sift(im2);
[matches, scores] = vl_ubcmatch(d1, d2);

X1 = f1(1:2,matches(1, :));
X1 = [ X1; ones(1, size(X1,2))];
X2 = f2(1:2,matches(2, :));
X2 = [ X2; ones(1, size(X2,2))];

%p=0.8; td = 1; tset=70;
%H = RANSAC_ADAPTIVE(X1,X2,p,td,tset);

N=100; td = 1;
H = RANSAC(X1,X2,N,td);

T = maketform('projective', H');

[~,xdataim2t,ydataim2t]=imtransform(im1, T);
% now xdataim2t and ydataim2t store the bounds of the transformed im2
xdataout=[min(1,xdataim2t(1)) max(size(im2, 2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(im2, 1),ydataim2t(2))];
% let's transform both images with the computed xdata and ydata
im2t=imtransform(im1,T,'XData',xdataout,'YData',ydataout);
im1t=imtransform(im2,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

stitchedImg=im1t/2+im2t/2;

figure, imshow(uint8(im1))
title('Image 1')
figure, imshow(uint8(im2))
title('Image 2')
figure, imshow(uint8(stitchedImg))
title('Stitched Images')

