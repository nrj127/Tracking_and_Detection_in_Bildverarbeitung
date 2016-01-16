clc;
clear;
close all;

frame1 = 140;
frame2 = 141;
frame_last = 190;
convergence_iteration = 20;
roi = [507,310, 555,344];      
I1 = imread(num2str(frame1,'sequence/2043_000%03d.jpeg'));
region = I1(roi(2):roi(4), roi(1):roi(3),:);
h = colorHist(region);

width = (roi(3)-roi(1))/2;
height = (roi(4)-roi(2))/2;
centers = zeros(frame_last-frame2+2, 2);
centers(1,:) = [roi(1) + width, roi(2) + height];

figure;
imagesc(I1);
hold on;

rectangle('Position', [centers(1,1)-width, centers(1,2)-height,width*2,height*2] );


for i = 2:frame_last-frame2+2
    disp(i);
    disp(i+frame2-2);
    new_frame = imread(num2str(i+frame2-2,'sequence/2043_000%03d.jpeg'));
    
    centers(i,:) = centers(i-1,:);
    
    for j = 1:convergence_iteration
        
        region = new_frame(centers(i,2)-height:centers(i,2)+height, centers(i,1)-width:centers(i,1)+width,:);
        P = probMap(region, h);
        
        [y,x] = meshgrid(centers(i,2)-height:centers(i,2)+height, centers(i,1)-width:centers(i,1)+width);
        xc_new = round(sum(sum(x'.*P)) / sum(sum(P)));
        yc_new = round(sum(sum(y'.*P)) / sum(sum(P)));
        
        
        if abs(centers(i,1)-xc_new) < 2 || abs(centers(i,2)-yc_new) < 2
            centers(i,:) = [xc_new, yc_new];
            break;
        end
        centers(i,:) = [xc_new, yc_new];
    end
    imagesc(new_frame);
   
   rectangle('Position', [centers(i,1)-width, centers(i,2)-height,width*2,height*2] );
   pause
    
    
end
